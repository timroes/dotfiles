minikube-sync-images() {
  echo "Syncing airbyte dev images to minikube..."
  MINIKUBE_CACHE=`minikube image list --format json | jq -r '.[] | ((.repoTags[0]) + "#" + (.id | "\(.[0:12])"))'`
  for line in `docker image list --format '{{ .Repository }}:{{ .Tag }}#{{ .ID }}' 'airbyte/*:dev'`; do
    image="$(echo $line | cut -f1 -d'#')"
    echo -n -e "Checking image \e[36m$image\e[0m - "
    if [[ "$MINIKUBE_CACHE" == *"$line"* ]]; then
      echo "up to date ✅"
    else
      echo "uploading new version 🔃"
      minikube image load $image
      echo "Uploaded new version ✅"
    fi
  done
}