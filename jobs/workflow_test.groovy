evaluate(new File("${WORKSPACE}/jobs/common.groovy"))

[
  // create a workflow-test-master and workflow-test-pr job
  [type: 'master'],
  [type: 'pr'],
].each { Map config ->
  isMaster = config.type == 'master'
  isPR = config.type == 'pr'

  job(defaults.testJob[config.type]) {
    description """<ol>
    <li>Runs the <a href="https://github.com/deis/workflow-e2e">e2e tests</a> against an updated deis-dev chart</li>
    <li>using the immutable deis_component images created by a ${config.type} commit in said deis_component repo</li>
  </ol>"""
    scm {
      git {
        remote {
          github("deis/charts")
          credentials('597819a0-b0b9-4974-a79b-3a5c2322606d')
        }
        branch('master')
      }
    }

    logRotator {
      numToKeep defaults.numBuildsToKeep
    }

    // concurrent builds allowed for pr e2e job
    if (isPR) {
      concurrentBuild()
      throttleConcurrentBuilds {
        maxPerNode(1)
        maxTotal(3)
      }
    }

    publishers {
      slackNotifications {
        // TODO: solution to send to appropriate channel
        projectChannel("#testing")
        notifyAborted()
        notifyFailure()
        notifySuccess()
        notifyBackToNormal()
       }

       if (isMaster) {
         git {
           pushOnlyIfSuccess()
           branch('origin', 'master')
         }
       }

       archiveJunit('logs/**/junit*.xml') {
         retainLongStdout(false)
       }

       archiveArtifacts {
         pattern('logs/**')
         onlyIfSuccessful(false)
         fingerprint(false)
       }
     }

    parameters {
      // create string parameters for every <COMPONENT>_SHA passed from upstream
      repos.each { Map repo ->
       stringParam(repo.commitEnvVar, '', "${repo.name} commit SHA")
     }
    }

    triggers {
      cron('@daily')
      githubPush()
    }

    wrappers {
      timestamps()
      colorizeOutput 'xterm'
      credentialsBinding {
        string("GCLOUD_CREDENTIALS", "246d6550-569b-4925-8cda-e11a4f0d6803")
      }
    }

    environmentVariables {
      env('COMMIT', isMaster)
    }

    steps {
      shell """
        #!/usr/bin/env bash

        set -eo pipefail

        ./ci.sh
        if [ "\${COMMIT}" == "true" ]; then
          ${defaults.bumpverCommitCmd}
        fi
      """.stripIndent().trim()
    }
  }
}
