package MallardDuck;
use version; our $VERSION = qv('v0.0.1');

use Moose;
use MooseX::StrictConstructor;
use MooseX::HasDefaults::RO;
extends 'Duck';
use Quack;
use FlyWithWings;

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9

has +flyBehavior =>(
		default => sub{ FlyWithWings->new },
	);

has +quackBehavior =>(
		default => sub{ Quack->new },
	);
	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub display{
	print "I'm a real Mallard duck\n";
}

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

MallardDuck - Mallard Duck class

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9