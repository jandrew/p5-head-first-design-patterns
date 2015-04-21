package MuteQuack;
use version; our $VERSION = qv('v0.0.1');

use Moose;
use MooseX::StrictConstructor;
use MooseX::HasDefaults::RO;

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9

	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub quack{
	print "Squeak\n";
}

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

Squeak - Make a squeaking sound

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9