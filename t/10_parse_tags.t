use strict;
use warnings;

use Test2::Bundle::More;
use MojoX::HyperScript qw[];

my ( $name, $id, @classes ) = MojoX::HyperScript::_parse_tags('p#id.classA.classB');

is( $name, 'p' );

is( $id, 'id' );

is_deeply( \@classes, [ qw( classA classB ) ] );

done_testing;
