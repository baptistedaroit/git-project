if [ $# != 2 ]; then 
  echo "error: you must specify an username and a password"
  echo "example: ./create-user.sh user password" 
  exit 1
else 
  GIT_ROOT=/srv/git
  GIT_USER="${1}"
  GIT_PASSWORD="${2}"
fi

id -u ${GIT_USER} >/dev/null 2>&1
if [ $? -eq 0 ]; then
  #~ If user exists, chech that it owns a personnal dir into GIT_ROOT
  if [ -d "${GIT_ROOT}/${GIT_USER}" ]; then
    chmod 775 ${GIT_ROOT}/${GIT_USER}
    chown -R ${GIT_USER}:${GIT_USER} "${GIT_ROOT}/${GIT_USER}"
  else
    #~ If no personnal dir found for the user into GIT_ROT, update user to get one
    usermod -d ${GIT_ROOT}/${GIT_USER} ${GIT_USER}
    chmod 775 ${GIT_ROOT}/${GIT_USER}
    chown -R ${GIT_USER}:${GIT_USER} "${GIT_ROOT}/${GIT_USER}"
  fi
else 
  # Create user if missing
  useradd -m -d ${GIT_ROOT}/${GIT_USER} ${GIT_USER}
  echo "${GIT_USER}:${GIT_PASSWORD}" | chpasswd
  chmod 775 ${GIT_ROOT}/${GIT_USER}
  chown -R ${GIT_USER}:${GIT_USER} "${GIT_ROOT}/${GIT_USER}"
fi 
