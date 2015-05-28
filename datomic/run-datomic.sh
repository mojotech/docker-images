#!/usr/bin/env bash

set -o errexit nounset pipefail

# converts keys like DATOMIC_NAME to name
format_key() {
  local key=$1

  # strip off leading DATOMIC_
  key=${key#DATOMIC_*}
  # convert delimiter _ to -
  key=${key//_/-}
  # lowercase string
  key=${key,,}

  echo "$key"
}

# find the transactor.properties file, in this order
#   1. ./transactor.properties
#   2. $SCRIPT_PATH/transactor.properties
#   3. /etc/datomic/transactor.properties
find_properties_file(){
  local path="$(dirname $0)"
  local file="transactor.properties"

  if [[ -f "$file" ]]; then
    echo "$file"
  elif [[ -f "$path/$file" ]]; then
    echo "$path/$file"
  else
    echo "/etc/datomic/$file"
  fi
}

# set properties in property file from env variables that start with DATOMIC_
update_properties_file() {
  file="$1"

  for kv in $(env | grep '^DATOMIC_'); do
    # splits `env` = delimited env entries, like this:
    #   DATOMIC_NAME=value
    k="$(format_key ${kv%=*})"
    v=${kv#*=}

    # if the key already exists in the file...
    if grep -q "^$k=" "$file" ; then
      # ...replace the value...
      sed -i "s/^$k=.*/$k=$v/" "$file"
    else
      # ...else just append the new key/value pair
      echo "$k=$v" >> "$file"
    fi
  done
}

PROPERTIES_FILE="$(find_properties_file)"

update_properties_file $PROPERTIES_FILE

exec /opt/datomic/bin/transactor $PROPERTIES_FILE
