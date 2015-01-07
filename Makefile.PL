require 5.010;
use strict;
use warnings;


my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/';

my %WriteMakefile = (
	'NAME'	        => 'Module::Extract::DeclaredMinimumPerl',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM'    => {
		'feature'              => '0',
		'PPI'                  => '0',
		'Test::More'           => '0',
		'Test::Output'         => '0',
		'version'              => '0',
		},

	(
	$ExtUtils::MakeMaker::VERSION ge '6.48' ? 
		(
		MIN_PERL_VERSION => 5.006,

		META_MERGE       => {
			resources => {
				repository => 'git://github.com/briandfoy/module-extract-declaredminimumperl.git',
				},
			keywords => [ qw( ppi parsing static-analysis modules ) ],
			no_index => {
				dir       => [ qw(corpus) ],
				directory => [ qw(corpus) ],
				},
			},
	 	) 
	 	: 
	 	()
	 ),

	clean  => { FILES    => q|Module-Extract-DeclaredMinimumPerl-*| },

	);

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
