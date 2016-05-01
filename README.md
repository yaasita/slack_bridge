# slack_bridge

別slack同士をつなげる

# 必要なの

    apt-get install perl libjson-perl

# 使い方

A→Bへ連携する

# 設定

    cp conf/token.sh.sample conf/token.sh

    # Aのgeneralチャンネルの内容をBのrandomチャンネルへ流す
    export SLACK_A_API_TOKEN=xoxp-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxxx
    export SLACK_B_API_TOKEN=xoxp-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxxx
    export SLACK_A=general
    export SLACK_B=random

    # Aの全チャンネルの内容をBのrandomチャンネルへ流す
    export SLACK_A_API_TOKEN=xoxp-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxxx
    export SLACK_B_API_TOKEN=xoxp-xxxxxxxxxx-xxxxxxxxxx-xxxxxxxxxx-xxxxxx
    export SLACK_A="*"
    export SLACK_B=random
