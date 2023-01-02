
use v5.10;

use PPR;

my $perl = <<'HERE';

use v5.10;

=pod

use v5.22;

=cut


HERE

$perl =~ s{ (?&PerlNWS)  $PPR::GRAMMAR }{ }gx;
say "------\n$perl\n-------\n";

while( $perl =~ / ((?&PerlUseStatement)) $PPR::GRAMMAR /gx ) {
	say "<$1>";
	}
