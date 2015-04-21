package Duck;
use version; our $VERSION = qv('v0.0.1');

use Moose;
use MooseX::StrictConstructor;
use MooseX::HasDefaults::RO;
use Types::Standard qw(
		HasMethods
    );

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9

has flyBehavior =>(
		isa		=> HasMethods['fly'],
		writer	=> 'set_flyBehavior',
		handles =>['fly'],
	);

has quackBehavior =>(
		isa		=> HasMethods['quack'],
		writer	=> 'set_quackBehavior',
		handles =>['quack'],
	);
	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub swim{
	print "All ducks float, even decoys!\n";
}

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

Duck - Parent Duck class

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9