while read value
do
    echo "Processing $value"
    echo "SET TERM OFF" > command.sql
    echo "SET FEED OFF" >> command.sql
    echo "SET SQLFORMAT CSV" >> command.sql
    echo "UNLOAD $value" >> command.sql
    echo "EXIT" >> command.sql
    wc -l $value*.csv
    rm -rf $value*.csv
    ./sql $CONN_STR @command.sql
    gsutil cp $value*.csv gs://$GCS_BUCKET/
done < table_list.txt