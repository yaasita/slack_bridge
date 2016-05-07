#!/usr/bin/perl
use strict;
use warnings;
use utf8;
require "lib/slack.pl";

my $slack = Slack->new("b");

$slack->post_ch(
    ch => $ENV{SLACK_B},
    username => "hoge",
    text => "テスト"
);
