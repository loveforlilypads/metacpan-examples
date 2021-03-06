use strict;
use warnings;
use feature qw( say );

use MetaCPAN::Client ();

my $mc = MetaCPAN::Client->new;
my $release_results = $mc->release( { not => { status => 'backpan' } } );

while ( my $release = $release_results->next ) {
    say $release->download_url;
}
