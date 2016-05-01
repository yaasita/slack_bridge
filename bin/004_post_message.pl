#!/usr/bin/perl
use strict;
use warnings;
use JSON qw/encode_json decode_json/;
use feature qw(say);
require "lib/slack.pl";

use Encode;
use utf8;
binmode STDOUT, ":utf8";

my $slack = Slack->new("a");

my @files = <tmp/a_history_*>;
for (@files){
    post_message($_);
}

sub post_message {
    my $file = shift;
    my $json;
    {
        open (my $in,"<", $file) or die $!;
        local $/ = undef;
        my $data = <$in>;
        close $in;
        $json = decode_json($data);
    }
    for(sort {$a->{ts} <=> $b->{ts}} @{$json->{messages}}){
        print $slack->id_to_user_name($_->{user}) . ": ";
        my $text = $_->{text};
        $text =~ s/<\@([A-Z0-9]+)>/'"@" . $slack->id_to_user_name("' . $1 . '")'/eeg;
        print $text;
        say "";
    }
}
