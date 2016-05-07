#!/bin/bash
set -e

# clear
rm -rf tmp/*

# A Side
curl -s "https://slack.com/api/channels.list?token=${SLACK_A_API_TOKEN}&pretty=1" \
    > tmp/a_channel.txt

curl -s "https://slack.com/api/users.list?token=${SLACK_A_API_TOKEN}&pretty=1" > \
    tmp/a_user_list.txt

# B Side
curl -s "https://slack.com/api/channels.list?token=${SLACK_B_API_TOKEN}&pretty=1" \
    > tmp/b_channel.txt

curl -s "https://slack.com/api/users.list?token=${SLACK_B_API_TOKEN}&pretty=1" > \
    tmp/b_user_list.txt

