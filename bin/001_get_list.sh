#!/bin/bash
set -e

# B Side
curl -s "https://slack.com/api/channels.list?token=${SLACK_B_API_TOKEN}&pretty=1" \
    > tmp/b_channel.txt

curl -s "https://slack.com/api/users.list?token=${SLACK_B_API_TOKEN}&pretty=1" > \
    tmp/b_user_list.txt

