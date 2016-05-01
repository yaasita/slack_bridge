#!/usr/bin/perl
use strict;
use warnings;
use JSON qw/encode_json decode_json/;
use feature qw(say);

my $user_json;
{
    open (my $in,"<", "tmp/b_user_list.txt") or die $!;
    local $/ = undef;
    my $data = <$in>;
    close($in);
    $user_json = decode_json($data);
}

{
    open (my $wr,">:utf8", "hash/b_user_list.txt") or die $!;
    for(@{$user_json->{members}}){
        say $wr "$_->{id}:$_->{name}";
    }
    close $wr;
}
