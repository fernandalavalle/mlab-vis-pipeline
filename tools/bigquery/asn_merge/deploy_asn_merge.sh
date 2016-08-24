#!/bin/bash

basedir=`dirname $0`


tableName=bocoup.asn_merge

tableSchema=$basedir/../../../dataflow/data/bigquery/asn_merge/schemas/asn_merge.json
outputFile=$basedir/output/asn_merge.csv

echo "Processing mlab_sites CSV"
python $basedir/process_asn_merge.py

echo "Removing $tableName from BigQuery"
bq rm -f $tableName

echo "Adding $tableName to BigQuery"
bq load --allow_quoted_newlines --skip_leading_rows=1 \
  $tableName $outputFile $tableSchema

echo "Done."