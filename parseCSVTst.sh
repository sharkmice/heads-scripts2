#!/bin/bash
## Vars Definition for  this Script 
DB_USER=root
DB_PASSWD=admin89!
DB_NAME=typo3local

#echo -e $DB_NAME
#echo -e $DB_TABLE

# init function pause
function pause(){
   read -p "$*"
}

PARENTDIR=`pwd`
BASENAME=`basename "$PARENTDIR"`
currentDate=`date`
#echo "$BASENAME"

dirs=($PARENTDIR/*)

for dir in "${dirs[@]}"
do
  if [ -d "$dir" ]; then
    cd "$dir"
    dirNm=$(basename $dir)
    LOG_FILE="logdir_$dirNm"
    touch ${LOG_FILE}
    echo "AccessDir: $currentDate" > ${LOG_FILE} 
    echo "Start of Parsing  Csv for import" >> ${LOG_FILE}
    printf "%s\n\n">> ${LOG_FILE}
         ##Check if form data is availiable 
         echo "Check if the formdata0 is there" >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         chkfrmdtfl="${dir}/${dirNm}_formdata0.csv"
         if [ -f $chkfrmdtfl ]; then
         echo "Start of Parsing  Csv for form Data import" >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         awk -v ptnID=$dirNm -F ',' '{gsub(2,ptnID,$3); print}' OFS="," $dir"/"$dirNm"_formdata0.csv" > $dir"/"$dirNm"_formdata1.csv"
         awk  -F ',' '{gsub(/[0-9][0-9]/,"'"'NULL'"'",$1); print }' OFS=","   $dir"/"$dirNm"_formdata1.csv" > $dir"/"$dirNm"_formdata2.csv"
         awk  -F ',' '{gsub(/[0-9][0-9][0-9]/,"'"'NULL'"'",$1); print }' OFS=","  $dir"/"$dirNm"_formdata2.csv" > $dir"/"$dirNm"_formdata3.csv"
         awk  -F ',' '{gsub(/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/,"'"'NULL'"'",$12); print }' OFS=","  $dir"/"$dirNm"_formdata3.csv" > $dir"/"$dirNm"_formdata4.csv"
         awk  -F ',' '{gsub(/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/,"'"'NULL'"'",$13); print }' OFS="," $dir"/"$dirNm"_formdata4.csv" > $dir"/"$dirNm"_formdata5.csv"
         awk  -F ',' '{gsub("NULL","'"'NULL'"'",$16); print }' OFS=","  $dir"/"$dirNm"_formdata5.csv" > $dir"/"$dirNm"_formdata6.csv"

         ####-CleanUp Unnecessary Files -Edit FormData 
         rm -f $dir"/"$dirNm"_formdata"{1,2,3,4,5}".csv"
         frmdtfl="${dir}/${dirNm}_formdata6.csv"
         echo "End  of Parsing  Csv for form Data import" >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         echo "Result file is $frmdtfl"  >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         else
         echo "This Patient has already be imported check the _formdata0"  >> ${LOG_FILE}
         echo "LeaveDir: $currentDate" >> ${LOG_FILE}
         continue
         fi

          ##Check if Study status data is availiable 
         printf "%s\n\n">> ${LOG_FILE}
         echo "Check if the studystatus0 is there" >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         chkstudystsfl="${dir}/${dirNm}_studystatus0.csv"
         if [ -f $chkstudystsfl ]; then
         echo "Start of Parsing  Csv for Study Data import" >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         awk  -F ',' '{gsub(/[0-9]/,"'"'NULL'"'",$1); print }' OFS=","   $dir"/"$dirNm"_studystatus0.csv" > $dir"/"$dirNm"_studystatus1.csv"
         awk  -F ',' '{gsub(/[0-9][0-9][0-9]/,"'"'NULL'"'",$1); print }' OFS=","  $dir"/"$dirNm"_studystatus1.csv" > $dir"/"$dirNm"_studystatus2.csv"
         awk  -F ',' '{gsub(/[0-9]/,"2",$8); print }' OFS=","  $dir"/"$dirNm"_studystatus2.csv" > $dir"/"$dirNm"_studystatus3.csv"
         awk -v ptnID=$dirNm -F ',' '{gsub("2",ptnID,$13); print }' OFS=","  $dir"/"$dirNm"_studystatus3.csv" > $dir"/"$dirNm"_studystatus4.csv"
         awk  -F ',' '{gsub(/[0-9]/,"0",$17); print }' OFS=","  $dir"/"$dirNm"_studystatus4.csv" > $dir"/"$dirNm"_studystatus5.csv"
         awk  -F ',' '{gsub(/[0-9]/,"0",$18); print }' OFS=","  $dir"/"$dirNm"_studystatus5.csv" > $dir"/"$dirNm"_studystatus6.csv"
         awk  -F ',' '{gsub(/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/,"'"'NULL'"'",$9); print }' OFS=","  $dir"/"$dirNm"_studystatus6.csv" > $dir"/"$dirNm"_studystatus7.csv"
         awk  -F ',' '{gsub(/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/,"'"'NULL'"'",$10); print }' OFS=","  $dir"/"$dirNm"_studystatus7.csv" > $dir"/"$dirNm"_studystatus8.csv"

         ####-CleanUp Unnecessary Files -Edit StudyStatus 
         rm -f $dir"/"$dirNm"_studystatus"{1,2,3,4,5,6,7}".csv"
         studystsfl="${dir}/${dirNm}_formdata8.csv"
         echo "Result file is $studystsfl"  >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         echo "End  of Parsing  Csv for Study Status  Data import" >> ${LOG_FILE}
         printf "%s\n\n">> ${LOG_FILE}
         else
         echo "This Patient has already be imported check the _studystatus0"  >> ${LOG_FILE}
         echo "LeaveDir: $currentDate" >> ${LOG_FILE}
         continue
         fi
    printf "%s\n\n">> ${LOG_FILE}
    echo "End  of Parsing  Csv for import" >> ${LOG_FILE} 
 
    printf "%s\n\n">> ${LOG_FILE}
    echo "Starting Actions to Import Patient $dirNm " >> ${LOG_FILE}
    ##########################################################-Insert In Patient Table 
      echo -e "-----Start of Insert in Patients Table for  New patient-----" >> ${LOG_FILE}
      mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
      SET @pid='${dirNm}';
      SET @ptncode=CONCAT('5599100', @pid);
      --SELECT @ptncode;
      --INSERT INTO tx_clinica_domain_model_patient (uid, pid, center, group_type, tstamp, crdate, cruser_id, patient_code, status, treatment) VALUES (@pid, 21, 1, '', 1554973644, 0, 0, @ptncode, 4, 0);
EOF
      echo -e "-----Start of Insert Data in Form Data  Table for  New patient-----" >> ${LOG_FILE}
      mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME << EOF
      SET @frmdt= '${frmdtfl}';
      SET @trg_file = CONCAT('LOAD DATA INFILE ',@frmdt, " INTO TABLE tx_clinica_domain_model_formdata  FIELDS TERMINATED BY ' ';");
      SELECT @trg_file INTO OUTFILE '/tmp/tmp_script.sql';
      --SOURCE /tmp/tmp_script.sql;
      
      
      
      
      -- SET @frmdt= '${frmdtfl}'
       --load data local infile @frmdt into table tx_clinica_domain_model_formdata
       --fields terminated by ','
       --enclosed by '"'
       --lines terminated by '\n'
       --(uid,pid,patient,element,visit,visit_sequence,fe_user_id,value_str,value_int,value_bool,value_text,tstamp,crdate,cruser_id,form_sequence,form_sequence);

EOF



 
    echo "LeaveDir: $currentDate" >> ${LOG_FILE}
    cat ${LOG_FILE}
    cd ../
    pause 'Press [Enter] key to continue to next patient...'
   fi
done





# echo "Starting Actions to Import Patient $dirNm " >> ${LOG_FILE}
#     Ptn=$'\r\n'  command eval  "ptnfrmdata=($(cat $frmdtfl))"
#     len=${#ptnfrmdata[@]}
#     echo "FormData_Length: $len rows" >> ${LOG_FILE}
   