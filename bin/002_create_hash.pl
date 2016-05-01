#!/usr/bin/perl
use strict;
use warnings;
use JSON qw/encode_json decode_json/;
use feature qw(say);

write_ch_hash("a");
write_ch_hash("b");
write_user_hash("a");
write_user_hash("b");

sub write_ch_hash {
    my $side = shift;
    my $ch_json;
    {
        open (my $in,"<", "tmp/${side}_channel.txt") or die $!;
        local $/ = undef;
        my $data = <$in>;
        close($in);
        $ch_json = decode_json($data);
    }
    {
        open (my $wr,">:utf8", "hash/${side}_channel.txt") or die $!;
        for(@{$ch_json->{channels}}){
            say $wr "$_->{id}:$_->{name}" ;
        }
        close $wr;
    }
}
sub write_user_hash {
    my $user_json;
    my $side = shift;
    {
        open (my $in,"<", "tmp/${side}_user_list.txt") or die $!;
        local $/ = undef;
        my $data = <$in>;
        close($in);
        $user_json = decode_json($data);
    }

    {
        open (my $wr,">:utf8", "hash/${side}_user_list.txt") or die $!;
        for(@{$user_json->{members}}){
            say $wr "$_->{id}:$_->{name}";
        }
        close $wr;
    }
}
