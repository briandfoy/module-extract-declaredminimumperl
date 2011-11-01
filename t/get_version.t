#!/usr/bin/perl
use v5.10;
use strict;


use Test::More;
use File::Basename;
use File::Spec::Functions qw(catfile);
use version;

my $class = "Module::Extract::DeclaredMinimumPerl";

use_ok( $class );

my $extor = $class->new;
isa_ok( $extor, $class );
can_ok( $extor, 'get_minimum_declared_perl' );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file that doesn't exist, should fail
{
my $not_there = 'not_there';
ok( ! -e $not_there, "Missing file is actually missing" );

$extor->get_minimum_declared_perl( $not_there );
like( $extor->error, qr/does not exist/, "Missing file give right error" );
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with this file
{
my $test = $0;
ok( -e $test, "Test file is there" );

my $version = $extor->get_minimum_declared_perl( $test );
ok( ! $extor->error, "No error for parseable file [$test]" );

is( 
	$version, 
	eval { version->parse( v5.10 ) }, 
	'The version is correct' 
	);

}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file that has repeated use lines
# I should only get unique names
{
my $file = catfile( qw(corpus Repeated.pm) );
ok( -e $file, "Test file [$file] is there" );

my $version = $extor->get_minimum_declared_perl( $file );
ok( ! $extor->error, "No error for parseable file [$file]" );

is( 
	$version, 
	eval { version->parse( v5.11 ) }, 
	'The version is correct' 
	);
}

done_testing();
