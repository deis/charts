repos = [
  [name: 'builder', slackChannel: 'builder'],
  [name: 'dockerbuilder', slackChannel: 'builder'],
  [name: 'fluentd', slackChannel: 'logger'],
  [name: 'logger', slackChannel: 'logger'],
  [name: 'minio', slackChannel: 'object-store'],
  [name: 'postgres', slackChannel: 'postgres'],
  [name: 'registry', slackChannel: 'registry'],
  [name: 'router', slackChannel: 'router'],
  [name: 'slugbuilder', slackChannel: 'builder'],
  [name: 'slugrunner', slackChannel: 'builder'],
  [name: 'controller', slackChannel: 'controller'],
  [name: 'workflow-e2e', slackChannel: 'testing'],
  [name: 'workflow-manager', slackChannel: 'wfm'],
]

repos.each { Map repo ->
  repo.commitEnvVar = "${repo.name.toUpperCase().replaceAll('-', '_')}_SHA"
}

defaults = [
  numBuildsToKeep: 42,
  bumpverCommitCmd: 'git commit -a -m "chore(versions): ci bumped versions via ${BUILD_URL}" || true',
  testJob: [master: 'workflow-test', pr: 'workflow-test-pr'],
]
