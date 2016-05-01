#!/usr/bin/perl
# vim: set fdm=marker:
use strict;
use warnings;
use feature qw(say);
package Slack;

sub new{
    my $class = shift;
    my $side = shift;

    my $self = {
        side => $side
    };
    return bless $self, $class;
}
# ch {{{
sub _create_ch_list {
    my $self = shift;
    $self->{ch}={};
    open (my $in,"<", "hash/$self->{side}_channel.txt") or die $!;
    while(<$in>){
        chomp;
        my($i, $n) = split(/\:/);
        $self->{ch}->{$n}=$i;
    }
    close $in;
}
sub ch_name_to_id {
    my $self = shift;
    my $name = shift;
    if(!defined($self->{ch})){
        _create_ch_list($self);
    }
    return $self->{ch}->{$name};
}
sub ch_list {
    my $self = shift;
    if(!defined($self->{ch})){
        _create_ch_list($self);
    }
    return keys(%{$self->{ch}})
}
# }}}
# status {{{
sub _create_status_list {
    my $self = shift;
    $self->{status}={};
    if ( -r "status/status.txt" ){
        open (my $in,"<", "status/status.txt") or die $!;
        close $in;
    }
    else {
        for (ch_list($self)){
            $self->{status}->{$_}=0;
        }
    }
}
sub last_get_date {
    my $self = shift;
    my $ch = shift;
    if (!defined($self->{status})){
        _create_status_list($self);
    }
    return $self->{status}->{$ch};
}
# }}}
# user {{{
sub id_to_user_name {
    my $self = shift;
    my $id = shift;
    if(!defined($self->{user})){
        _create_user_list($self);
    }
    return $self->{user}->{$id};
}
sub _create_user_list {
    my $self = shift;
    $self->{user}={};
    open (my $in,"<", "hash/$self->{side}_user_list.txt") or die $!;
    while(<$in>){
        chomp;
        my($i, $u) = split(/\:/);
        $self->{user}->{$i}=$u;
    }
    close $in;
}
# }}}

1;
