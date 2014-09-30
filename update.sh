#!/bin/bash

mysql --defaults-file=~/replica.my.cnf -h tools-db -e "insert into executions (query_id, time, duration, results) values ($1, '$2 $3', $4, $5)" s51223_db
mysql --defaults-file=~/replica.my.cnf -h tools-db -e "update queries set times = times + 1, last_execution_at = '$2 $3', updated_at = '$2 $3', last_execution_results = $5 where id = $1" s51223_db
