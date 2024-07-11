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

update-airbyte-hosts() {
  if [[ "$(kubectx --current)" != "minikube" ]]; then
    echo "This command is only available in minikube context."
    return 1
  fi

  ingress_ip="$(kubectl -n ingress-nginx get services ingress-nginx-controller -o jsonpath='{$.status.loadBalancer.ingress[0].ip}')"

  if [[ -z "$ingress_ip" ]]; then
    echo "Ingress IP not found. Is 'minikube tunnel' running?"
    return 1
  fi

  echo "Ingress IP address: $ingress_ip"

  echo "Updating /etc/hosts with new ingress IP..."

  sudo sed -i "s/.*\([ \t]\+\)\(.*\)\.airbyte\.dev/$ingress_ip\1\2.airbyte.dev/g" /etc/hosts
}

export DOCKER_PROVIDER="native"
