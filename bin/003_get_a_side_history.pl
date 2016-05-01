#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);
require "lib/slack.pl";

my $slack = Slack->new("a");

if ($ENV{SLACK_A} eq "*"){
    for($slack->ch_list()){
        sleep 2;
        get_history($_);
    }
}
else {
    get_history($ENV{SLACK_A});
}

sub get_history {
    my $ch = shift;
    my $id = $slack->ch_name_to_id($ch);
    my $oldest = $slack->last_get_date($ch);
    my $exec_curl = "curl -s 'https://slack.com/api/channels.history?token=$ENV{SLACK_A_API_TOKEN}&channel=$id&"
    . "count=1000&oldest=$oldest&pretty=1' > tmp/a_history_$ch.txt";
    system $exec_curl and die $!;
}

