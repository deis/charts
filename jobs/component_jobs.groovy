evaluate(new File("./common.groovy"))

repos.each { Map repo ->
  [
    // for each repo, create a <repo.name>-master and <repo.name>-pr job
    [type: 'master', branch: 'master'],
    [type: 'pr', branch: '${sha1}'],
  ].each { Map config ->
    isMaster = config.type == 'master'
    isPR = config.type == 'pr'

    name = isMaster ? repo.name : "${repo.name}-pr"

    job(name) {
      description """<ol>
      <li>Watches the ${repo.name} repo for a ${config.type} commit/li>
      <li>Kicks off downstream ${defaults.testJob[config.type]} job to vet changes</li>
    </ol>"""
      scm {
        git {
          remote {
            github("deis/${repo.name}")
            if (isPR) {
              refspec('+refs/pull/*:refs/remotes/origin/pr/*')
            }
          }
          branch(config.branch)
        }
      }

      publishers {
        slackNotifications {
          projectChannel("#${repo.slackChannel}")
          notifyAborted()
          notifyFailure()
         }
      }

      logRotator {
        numToKeep defaults.numBuildsToKeep
      }

      if (isPR) { // set up GitHubPullRequest build trigger
        triggers {
          pullRequest {
            admin('deis-admin')
            cron('H/5 * * * *')
            useGitHubHooks()
            triggerPhrase('OK to test')
            orgWhitelist(['deis'])
            allowMembersOfWhitelistedOrgsAsAdmin()
            // TODO: configure commit status messaging
            // extensions {
            //   commitStatus {
            //     context('deploy to staging site')
            //       triggeredStatus('starting deployment to staging site...')
            //       startedStatus('deploying to staging site...')
            //       statusUrl('http://mystatussite.com/prs')
            //       completedStatus('SUCCESS', 'All is well')
            //       completedStatus('FAILURE', 'Something went wrong. Investigate!')
            //       completedStatus('PENDING', 'still in progress...')
            //       completedStatus('ERROR', 'Something went really wrong. Investigate!')
            //     }
            //   }
          }
        }
      }

      if (isMaster) { // used for remote build trigger (from TravisCI)
        authenticationToken('5ISZbTayHuC0nHV')
      }

      if (isPR) { // we'll be pushing images and testing specific git SHAs
        parameters {
          stringParam('DOCKER_USERNAME', 'deisbot', 'Docker Hub account name')
          stringParam('DOCKER_EMAIL', 'dummy-address@deis.com', 'Docker Hub email address')
          stringParam('QUAY_USERNAME', 'deisci+jenkins', 'Quay account name')
          stringParam('QUAY_EMAIL', 'deisci+jenkins@deis.com', 'Quay email address')
          stringParam('sha1', 'master', 'Specific Git SHA to test')
        }
      }

      wrappers {
        timestamps()
        colorizeOutput 'xterm'
        if (isPR) { // we'll be pushing images
          credentialsBinding {
            string("DOCKER_PASSWORD", "0d1f268f-407d-4cd9-a3c2-0f9671df0104")
            string("QUAY_PASSWORD", "c67dc0a1-c8c4-4568-a73d-53ad8530ceeb")
          }
        }
      }

      steps {
        if (repo.name != 'workflow-manager') {
          if (isPR) { // we'll need to push docker images
            shell '''
              #!/usr/bin/env bash

              set -eo pipefail

              make bootstrap || true

              export IMAGE_PREFIX=deisci
              docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
              DEIS_REGISTRY='' make docker-build docker-immutable-push
              docker login -e="$QUAY_EMAIL" -u="$QUAY_USERNAME" -p="$QUAY_PASSWORD" quay.io
              DEIS_REGISTRY=quay.io/ make docker-build docker-immutable-push
            '''.stripIndent().trim()
          }

          downstreamParameterized {
            trigger("${defaults.testJob[config.type]}") {
              parameters {
                predefinedProp(repo.commitEnvVar, '${GIT_COMMIT}')
              }
              block {
                buildStepFailure('FAILURE')
                failure('FAILURE')
                unstable('UNSTABLE')
              }
            }
          }
        } else { // do not run e2e tests for workflow-manager at this time
          shell """
            #!/usr/bin/env bash

            set -eo pipefail

            if [ ! -z "\${WORKFLOW_MANAGER_SHA}" ]; then
              rerun chart-mate:bumpver
              ${defaults.bumpverCommitCmd}
            fi
          """.stripIndent().trim()
        }
      }
    }
  }
}
