alias docker-ips='docker ps --format "{{.ID}}" | xargs docker inspect -f "{{.Name}} --- {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'

alias pods='watch -n 1 kubectl get pods'
alias k='kubectl'

# Start a minikube env
k8s() {
  minikube status &> /dev/null
  if [ $? -ne 0 ]; then
    minikube start --mount=true --mount-string="$HOME:$HOME"
  fi
  eval $(minikube docker-env)
  setopt complete_aliases
  alias kubectl="minikube kubectl --"
  source <(kubectl completion zsh)
  export DOCKER_MINIKUBE=true
  echo 'Initialized minikube env.'
}

function pick_pod() {
  kubectl get pods -o=name | fzf
}

function kexec() {
  pod=`pick_pod`
  kubectl exec -it $pod -- $@
}

function kbash() {
  kexec /bin/bash
}

function ksh() {
  kexec /bin/sh
}

function klogs() {
  pod=`pick_pod`
  kubectl logs $pod $@
}
