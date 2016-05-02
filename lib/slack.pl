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
    for (ch_list($self)){
        $self->{status}->{$_}=0;
    }
    if ( -r "status/status.txt" ){
        open (my $in,"<", "status/status.txt") or die $!;
        close $in;
    }
    else {
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
# post {{{
sub post_ch {
    my $self = shift;
    my %param = @_;
    #say ch_name_to_id($self,$param{ch});
    my $str = $param{text};
    $str =~ s/([^ 0-9a-zA-Z])/"%".uc(unpack("H2",$1))/eg;
    $str =~ s/ /+/g;
    my $token = $ENV{"SLACK_" . uc($self->{side}) . "_API_TOKEN"};
    my $ch = ch_name_to_id($self,$param{ch});
    my $user = $param{username};
    system ("curl -s 'https://slack.com/api/chat.postMessage?token=$token\&channel=$ch\&text=$str\&username=$user'");

}
# }}}

1;
