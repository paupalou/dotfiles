docker_completion='$ZSH/docker/_docker-compose'
docker_compose_completion='$ZSH/docker/_docker'

if test -f $docker_completion
then
  source $docker_completion
fi

if test -f $docker_compose_completion
then
  source $docker_compose_completion
fi
