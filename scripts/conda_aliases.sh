#** Remove conda env
conda_env_del() {
  conda env remove -n $1
}
#** Create conda environment.yml
conda_env_make() {
  conda env export > environment.yml
}

alias conda_env_list='conda env list'
