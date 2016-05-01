#!/usr/bin/perl
use strict;
use warnings;
use JSON qw/encode_json decode_json/;
use feature qw(say);

my $ch_json;
{
    open (my $in,"<", "tmp/b_channel.txt") or die $!;
    local $/ = undef;
    my $data = <$in>;
    close($in);
    $ch_json = decode_json($data);
}

{
    open (my $wr,">:utf8", "hash/b_channel.txt") or die $!;
    for(@{$ch_json->{channels}}){
        say $wr "$_->{id}:$_->{name}" ;
    }
    close $wr;
}
