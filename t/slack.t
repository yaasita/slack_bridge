#!/usr/bin/perl
# vim: fdm=marker
use strict;
use warnings;
use feature qw(say);
use Test::More;

require "lib/slack.pl";

subtest 'team' => sub { #{{{
    my $slack = Slack->new("a");
    like ($slack->team_name(), qr/.+/);
}; #}}}
subtest 'set_date' => sub { #{{{
    unlink ("status/status.txt") or die $!;
    {
        my $slack = Slack->new("a");
        $slack->last_set_date("general",1461569774.000010);
    }
    ok ( -e "status/status.txt");
    open(my $in, "<", "status/status.txt") or die $!;
    my $line;
    while ($line = <$in>){
        last if $line =~ /^general/;
    }
    chomp $line;
    is ($line, "general:1461569774.00001");
    close $in;

}; #}}}
subtest 'get_date' => sub { #{{{
    my $slack = Slack->new("a");
    is ($slack->last_get_date("general"), 1461569774.00001);
}; #}}}
done_testing();
