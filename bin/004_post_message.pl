#!/usr/bin/perl
use strict;
use warnings;
use JSON qw/encode_json decode_json/;
use feature qw(say);
require "lib/slack.pl";

use Time::Piece;
use Time::Seconds;

use Encode;
use utf8;
binmode STDOUT, ":utf8";

my $slack_a = Slack->new("a");
my $slack_b = Slack->new("b");

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
    my $ch;
    {
        if ($file =~ m#tmp/\w_history_(.*)\.txt$#){
            $ch = $1;
        }
        else {
            die "not match";
        }
    }
    for(sort {$a->{ts} <=> $b->{ts}} @{$json->{messages}}){
        my $json = $_;
        # ファイルアップロード
        if ( defined($json->{subtype}) and $json->{subtype} eq "file_share" ){
            my $download_url = $json->{file}->{permalink};
            say $download_url;
            next;
        }
        else {
            next;
        }
        {
            # メッセージ出力
            my $text="";
            my $t = localtime($json->{ts});
            my $message = $json->{text};
            $text .= $slack_a->id_to_user_name($_->{user}) . '@' . $ch . " (" . $t->strftime("%Y/%m/%d %H:%M:%S") . ") \n";
            $text .= "```\n";
            $text .= $message;
            $text =~ s/<\@([A-Z0-9]+)>/'"@" . $slack_a->id_to_user_name("' . $1 . '")'/eeg;
            $text .= "\n```";
            $slack_b->post_ch(
                ch => $ENV{SLACK_B},
                username => $slack_a->team_name(),
                text => $text
            );
        }
        $slack_a->last_set_date($ch, $json->{ts});
    }
}

