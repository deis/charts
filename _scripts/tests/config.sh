
if [ ! -z "${JENKINS_URL}" ]; then
  echo "Setting up GCLOUD_CREDENTIALS_FILE"
  mkdir -p "${HOME}/.secrets/"
  echo ${GCLOUD_CREDENTIALS} > "${HOME}/.secrets/helm-testing-creds.json"
fi

export GCLOUD_CREDENTIALS_FILE="${GCLOUD_CREDENTIALS_FILE:-${HOME}/.secrets/helm-testing-creds.json}"
export PATH="$(pwd):$(pwd)/.bin:${HOME}/google-cloud-sdk/bin:$PATH"
