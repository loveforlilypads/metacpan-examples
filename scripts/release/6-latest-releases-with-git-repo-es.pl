#!/usr/bin/env perl

use strict;
use warnings;
use feature qw( say );

use Data::Printer;
use lib './lib';
use MetaCPAN::Util qw( es );

my @must = (
    { term => { 'resources.repository.type' => 'git' }, },
    { term => { status                      => 'latest' } },
    { term => { authorized                  => 'true' } },
);

my $scroller = es()->scroll_helper(
    body => {
        query => {
            filtered => {
                filter => { bool => { must => \@must } },
            },
        },
    },
    fields      => [ 'author', 'date', 'distribution', 'name', 'resources' ],
    search_type => 'scan',
    scroll      => '5m',
    index       => 'cpan',
    type        => 'release',
    size        => 500,
);

while ( my $result = $scroller->next ) {
    my $release = $result->{_source};
}
