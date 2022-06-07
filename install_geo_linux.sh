#!/bin/bash

# -----------------------------------------------------
# Install and setup GDAL / Postgresql / PostGIS / etc
# -----------------------------------------------------

# install postgres
brew install postgresql

brew install gdal

# rm /opt/homebrew/var/postgres/postmaster.pid  #had issues with connection so tried this but it didn't work https://stackoverflow.com/questions/13410686/postgres-could-not-connect-to-server



# homebrew now runs initdb, creating superuser with the user account (as in ubuntu)...
# we want a default superuser postgres/postgres for dev, create it

createuser -s -e postgres -U $USER

# create our primary gis db
createdb postgis

# set the password (rather than interactively with the createuser -P option)
psql -U $USER -c "alter user postgres with password 'postgres';"

# install postgis *after* installing gdal2
brew install postgis

# enable postgis
psql -d postgis -c "CREATE EXTENSION postgis;"

# tune the database

# This writes settings to /opt/homebrew/var/postgres/pgtune.conf to optimize
# postgres for running on big postgis databases. These settings have been
# tested on a 2018 Macbook Pro with 32GB RAM.
# http://big-elephants.com/2012-12/tuning-postgres-on-macos/

cat << EOF > /opt/homebrew/var/postgres/pgtune.conf
log_timezone = 'Canada/Pacific'
datestyle = 'iso, mdy'
timezone = 'Canada/Pacific'
lc_messages = 'en_US.UTF-8'         # locale for system error message
lc_monetary = 'en_US.UTF-8'         # locale for monetary formatting
lc_numeric = 'en_US.UTF-8'          # locale for number formatting
lc_time = 'en_US.UTF-8'             # locale for time formatting
default_text_search_config = 'pg_catalog.english'
default_statistics_target = 100
log_min_duration_statement = 2000
max_connections = 100
max_locks_per_transaction = 64
dynamic_shared_memory_type = posix
checkpoint_timeout = 30min          # range 30s-1d
maintenance_work_mem = 1GB
effective_cache_size = 16GB
work_mem = 500MB
max_wal_size = 10GB
wal_buffers = 16MB
shared_buffers = 8GB
EOF

# Edit /opt/homebrew/var/postgres/postgresql.conf to read and load pgtune.conf

cat << EOF >> /opt/homebrew/var/postgres/postgresql.conf
# Include custom settings:
include = 'pgtune.conf'
EOF

# Tune kernel settings to allow larger amounts of shared memory to facilitate
# parallel processing.
# https://www.postgresql.org/docs/10/static/kernel-resources.html
# https://benscheirman.com/2011/04/increasing-shared-memory-for-postgres-on-os-x/

sudo bash -c 'cat > /etc/sysctl.conf' << EOF
kern.sysv.shmmax=34359738368
kern.sysv.shmmin=1
kern.sysv.shmmni=32
kern.sysv.shmseg=8
kern.sysv.shmall=8388608
kern.maxprocperuid=512
kern.maxproc=2048
EOF

# restart the db for setting changes to take effect
brew services restart postgres

# for dumping postgres queries to csv
brew install psql2csv

# -----------------------------
# another python package manager
# (brew cask may be a better approach?)
# -----------------------------
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda config --set auto_activate_base false


# -----------------------------
# Python geo
# -----------------------------
pip install rtree
pip install virtualenv
brew install proj
pip install bcdata
pip install rasterstats


pip install pgdata



# -----------------------------
# Python dev
# -----------------------------
# https://github.com/tqdm/tqdm/issues/460
#sudo mkdir -p /opt/homebrew/man
#sudo chown -R "$USER:admin" /opt/homebrew/man
# pip install twine
# pip install flake8
# pip install black
# pip install white

# -----------------------------
# Node
# -----------------------------
brew install nvm
npm install -g http-server
npm install -g tj/serve

# -------------------here up unhash

# add as necessary
#npm install -g topojson
#npm install -g tokml
#npm install -g geojson-rewind
#npm install -g togeojson
#npm install -g csv2geojson
#npm install -g mapshaper

# -----------------------------
# Docker
# -----------------------------
# already did this
brew install --cask docker

# -----------------------------
# Misc
# -----------------------------
# brew install gist
# brew install pandoc
# brew install csvkit
# brew install rmtrash

#wget -O ~/bin/pgconman.py https://raw.githubusercontent.com/perrygeo/pgconman/master/pgconman.py


# ---
# LaTeX (enough for building markdown files to pdf with Sphinx)
# ---
# brew install basictex
# sudo tlmgr update --self
# sudo tlmgr install latexmk
# sudo tlmgr install tex-gyre
# sudo tlmgr install fncychap
# sudo tlmgr install wrapfig
# sudo tlmgr install capt-of
# sudo tlmgr install framed
# sudo tlmgr install needspace
# sudo tlmgr install tabulary
# sudo tlmgr install varwidth
# sudo tlmgr install titlesec