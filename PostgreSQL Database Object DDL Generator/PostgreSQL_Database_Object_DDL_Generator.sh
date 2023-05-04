#!/bin/bash


##########################################################################################
####Author : Alwyn D'Souza                                                            ####
####Purpose: the scripts generates DDL for each postgres db object in a separate file ####
####TODO : The scripts needs to be parameterised                                      ####
##########################################################################################


#parameters are hardcoded. Updated server details before running the script.
#Config:
## db password
export PGPASSWORD="postgres"
##db name
db=postgres
## username
user=postgres
## server ip
#server=xx.xx.xx.xx  #prod
server=xx.xx.xx.xx #dev
## port number 
port=3306

#directory to dump files without trailing slash:
DIR=~/psql_db_dump_dir

mkdir -p $DIR/public/tables
mkdir -p $DIR/public/foreign_tables
mkdir -p $DIR/public/views
mkdir -p $DIR/public/functions

AUTH="-h $server -p $port -d $db -U $user "

#BASE TABLES
QUERY_PREDICATE="and table_type='BASE TABLE' and not table_name ~'\d{8}$'  and not table_name ~'\d{6}$' and table_name not like '%_old' and table_name not like '%_backup' and table_name not like '%_test'"

echo $QUERY_PREDICATE
SCHEMA="public"
TABLES="$(psql $AUTH -t -c "SELECT table_name FROM information_schema.tables WHERE table_schema ='$SCHEMA' $QUERY_PREDICATE")"
for table in $TABLES; do
  echo backup base table $table ...
  pg_dump $AUTH -s -t $table > $DIR/$SCHEMA/foreign_tables/$table.sql;
done;
echo done

#FORIEGNS TABLES
QUERY_PREDICATE="and table_type='FOREIGN' and not table_name ~'\d{8}$'  and not table_name ~'\d{6}$' and table_name not like '%_old' and table_name not like '%_backup' and table_name not like '%_test'"

SCHEMA="public"
TABLES="$(psql $AUTH -t -c "SELECT table_name FROM information_schema.tables WHERE table_schema ='$SCHEMA' $QUERY_PREDICATE")"
for table in $TABLES; do
  echo backup foreign table $table ...
  pg_dump $AUTH -s -t $table > $DIR/$SCHEMA/foreign_tables/$table.sql;
done;
echo done

#Views

VIEWS="$(psql $AUTH -t -c "SELECT table_name FROM information_schema.views WHERE table_schema ='public' ORDER BY table_name")"
for view in $VIEWS; do
  echo backup view $view ...
  pg_dump $AUTH -s -t $view > $DIR/public/views/$view.sql;
done;
echo done


#FUNCTIONS
FUNCTIONS="$(psql $AUTH -t -c "select pp.proname from pg_proc pp inner join pg_namespace pn on (pp.pronamespace = pn.oid) inner join pg_language pl on (pp.prolang = pl.oid) where pl.lanname NOT IN ('c','internal') and pn.nspname NOT LIKE 'pg_%' and pn.nspname <> 'information_schema' and nspname='public'")"
for function in $FUNCTIONS; do
  echo backup $function ...
  psql $AUTH -t -A -c  "select pg_get_functiondef(pp.oid) from pg_proc pp inner join pg_namespace pn on (pp.pronamespace = pn.oid) inner join pg_language pl on (pp.prolang = pl.oid) where pl.lanname NOT IN ('c','internal') and pn.nspname NOT LIKE 'pg_%' and pn.nspname <> 'information_schema' and pp.proname = '$function'" > $DIR/public/functions/$function.sql;
done;
echo done