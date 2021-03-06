#!/bin/bash
basedir=`dirname $0`
timezoneDir=$basedir/../../../dataflow/data/bigquery/timezonedb

echo "Creating timezone tables"

echo "Processing timezones csvs CSV"
python $basedir/process_timezones.py

echo "Adding data_viz_helpers.localtime_timezones to BigQuery"
bq load --allow_quoted_newlines --skip_leading_rows=1 --source_format=CSV \
  data_viz_helpers.localtime_timezones  \
  $timezoneDir/merged_timezone.csv \
  $timezoneDir/schemas/merged_timezone.json

echo "Done."
