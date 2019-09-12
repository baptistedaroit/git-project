if [ $# != 2 ]; then 
  echo "error: you must specify an username and a project name"
  exit 1
else 
  GIT_ROOT=/srv/git
  GIT_USER="${1}"
  GIT_PROJECT="${2}"
fi

cd ${GIT_ROOT}
if [ -d "${GIT_ROOT}/${GIT_USER}/${GIT_PROJECT}" ]; then
  echo "error: git repository already exist"
  exit 1 
else 
  mkdir -p "${GIT_ROOT}/${GIT_USER}/${GIT_PROJECT}.git"
  cd "${GIT_ROOT}/${GIT_USER}/${GIT_PROJECT}.git"
  git init --bare
fi
