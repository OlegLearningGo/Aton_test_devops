#!/bin/bash

# for smtp server variables
URL="smtps://smtp.mail.ru"
SMTP_PORT="465"
USER_LOGIN="LOGIN"
USER_PASSWORD="PASSWORD"
# data of letter
FROM_EMAIL="vasilev-oleg02@mail.ru"
MAIL_RESPONSE="vasilev-oleg02@mail.ru"
SUBJECT="Alert"
BODY="There is a near out of memory (>=85%) in one of the devices"

# Letter
EMAIL_LETTER=$(cat <<EOF
From: ${FROM_EMAIL}
To: ${MAIL_RESPONSE}
Subject: ${SUBJECT}
${BODY}
EOF
)

df -h --output=pcent | awk '{if ($1 >= 85) exit 1}'

if [ $? -eq 1 ]; then

    curl -v --ssl-reqd\
    --url "${URL}:${SMTP_PORT}"\
    --user "${USER_LOGIN}:${USER_PASSWORD}"\
    --mail-from "${FROM_EMAIL}"\
    --mail-rcpt "${MAIL_RESPONSE}"\
    --upload-file - <<< "${EMAIL_LETTER}"

    # Check res
    if [ $? -eq 0 ]; then
	echo "Sending letter is ok"
    else
	echo "Error of send"
    fi

fi
