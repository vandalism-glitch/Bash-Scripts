#!/bin/bash

HOST=`hostname`
REPORT=/root/report.txt
EMAIL=reports@example.com
HEADER=/root/header.txt
FOOTER=/root/footer.txt

SMTP_HOST=
SMTP_USER=
SMTP_PASS=
SMTP_PORT=

flush_reports () {
        echo "Flushing old Report files.."
        :> $REPORT
        echo "..Done"
}

generate_email_content () {
        echo "Generating Email Content .."
        cat << EOF > $HEADER
        Hello,

        As a part of routine maintenance, we have found that these files are using up a lot of space in your Server.

        Please go through the attached report, and remove the unwanted files to free up Disk Space. 
EOF

        cat << EOF > $FOOTER

        Feel free to get back to us if you have any queries.

        Regards,
EOF

}

get_1G_files () {
        echo "Generating report of files with 1G+ size.."
        find /home -type f -size +1G -exec du -sch {} \; | grep -v "total" > $REPORT
        echo "..Done"
}

mail_report () {
        echo "Sending report via Mail to $EMAIL .."
        cat $HEADER $FOOTER | mailx -s "Disk Usage Report for $HOST" -a $REPORT -S smtp=smtp://$SMTP_HOST -S smtp-auth=login -S smtp-auth-user=$SMTP_USER -S smtp-auth-password=$SMTP_PASS -S from="$SMTP_USER" $EMAIL
        echo ".. Sent"
}

flush_reports
generate_email_content
get_1G_files
mail_report
