#!/bin/bash

BOT_TOKEN="5814305143:AAHFYuOrO4pkV3n0jA0SUQoGmPvDqtliRyg"
USER_ID="556288929"

URL="https://api.telegram.org/bot$BOT_TOKEN/sendMessage"
TEXT="Stage:+$CI_JOB_STAGE%0A%0AProject:+$CI_PROJECT_NAME%0AStatus:+$CI_JOB_STATUS%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s -d "chat_id=$USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
