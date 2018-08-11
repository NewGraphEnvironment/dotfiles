#!/bin/bash

# -----------------------------------------------------
# Install and setup GDAL / Postgresql / PostGIS / etc
# -----------------------------------------------------

# install postgres
brew install postgresql              


# install GDAL now because postgis requires it and will grab the default gdal
# if we don't install and link the osgeo4mac formula first
# (the osgeo4mac tap makes the filegdb and python installs easy)
brew tap osgeo/osgeo4mac

# this will install postgresql
brew install gdal2 --enable-unsupported --with-postgresql --with-complete --with-libkml

export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins

brew install gdal2-filegdb
brew install gdal2-python

# point to gdal2
brew link --force gdal2


brew services start postgresql       # homebrew provided service to stop/start db

# homebrew now runs initdb, creating superuser with the user account (as in ubuntu)...
# we want a default superuser postgres/postgres for dev, create it
createuser -s -e postgres -U $USER

# set the password (rather than interactively with the createuser -P option)
psql -c -U $USER "alter user postgres with password postgres;"

# install postgis *after* installing gdal2
brew install postgis

# create a default postgis enabled db with user postgres/postgres
createdb postgis
psql -d postgis -c "CREATE EXTENSION postgis;"

# tune the database

# This writes settings to /usr/local/var/postgres/pgtune.conf to optimize
# postgres for running on big postgis databases. These settings have been 
# tested on a 2018 Macbook Pro with 32GB RAM.
# http://big-elephants.com/2012-12/tuning-postgres-on-macos/

cat << EOF > /usr/local/var/postgres/pgtune.conf
log_timezone = 'Canada/Pacific'
datestyle = 'iso, mdy'
timezone = 'Canada/Pacific'
lc_messages = 'en_US.UTF-8'			# locale for system error message
lc_monetary = 'en_US.UTF-8'			# locale for monetary formatting
lc_numeric = 'en_US.UTF-8'			# locale for number formatting
lc_time = 'en_US.UTF-8'				# locale for time formatting
default_text_search_config = 'pg_catalog.english'
default_statistics_target = 100
log_min_duration_statement = 2000
max_connections = 100
max_locks_per_transaction = 64
shared_buffers = 128MB			# min 128kB
dynamic_shared_memory_type = posix
checkpoint_timeout = 30min		# range 30s-1d
maintenance_work_mem = 1GB
effective_cache_size = 6GB
work_mem = 500MB
max_wal_size = 10GB
wal_buffers = 16MB
shared_buffers = 4GB
EOF

# Edit /usr/local/var/postgres/postgresql.conf to read and load pgtune.conf

cat << EOF >> /usr/local/var/postgres/postgresql.conf
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

# install and config odbc drivers
brew install psqlodbc

# define an ODBC driver entry for PortgreSQL in the file /usr/local/etc/odbcinst.ini
# note that square brackets around the driver are essential, and change the
# file path of unixodbc as required. get file path with command
# $ odbc_config --odbcinstini
cat <<EOF >> /usr/local/etc/odbcinst.ini
[PostgreSQL Unicode]
Description     = PostgreSQL ODBC driver (Unicode version)
Driver          = psqlodbcw.so
Debug           = 0
CommLog         = 0
UsageCount      = 1
EOF

# define DSNs
# create if not exists the file .odbc.ini in $HOME directory and add the desired DSN
# presumably change protocol value depending on postgres version
touch .odbc.ini
cat <<EOF >> .odbc.ini
[postgis]
Driver      = PostgreSQL Unicode
ServerName  = localhost
Port        = 5432
Database    = postgis
Username    = postgres
Password    = postgres
Protocol    = 10.4
Debug       = 1
EOF

# test with command
# > isql -v postgis
# should connect successfully


# lostgis  -- useful postgis extension
pip install pgxnclient
pgxn install lostgis
pgxn load -d postgis lostgis

# for dumping postgres queries to csv
brew install psql2csv

# -----------------------------
# Python
# -----------------------------
pip install virtualenv
pip install pyodbc
pip install psycopg2-binary

pip install shapely
pip install fiona
pip install rasterio

pip install jupyter

pip install bcdata
pip install pgdata


# -----------------------------
# Node
# -----------------------------
npm install -g topojson
npm install -g tokml
npm install -g geojson-rewind
npm install -g togeojson
npm install -g csv2geojson
npm install -g mapshaper
npm install -g http-server
npm install -g tj/serve


# -----------------------------
# Ruby (https://github.com/nicolashery/mac-dev-setup)
# -----------------------------
curl -L https://get.rvm.io | bash -s stable --ruby
gem install gist

# -----------------------------
# Misc
# -----------------------------
brew install pandoc
