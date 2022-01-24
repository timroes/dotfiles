alias docker-ips='docker ps --format "{{.ID}}" | xargs docker inspect -f "{{.Name}} --- {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'

# Start a minikube env
k8s() {
  minikube status &> /dev/null
  if [ $? -ne 0 ]; then
    minikube start
  fi
  eval $(minikube docker-env)
  source <(kubectl completion zsh)
  alias kubectl='minikube kubectl --'
  export DOCKER_MINIKUBE=true
  echo 'Initialized minikube env.'
}
