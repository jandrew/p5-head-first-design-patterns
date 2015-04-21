package ButtonAction;
use version; our $VERSION = qv('v0.0.1');

use Moose;
use MooseX::StrictConstructor;
use MooseX::HasDefaults::RO;
use Types::Standard qw(
		Num
    );
with 'Observable';

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9



#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub buttonPressed{
	my ( $self,) = @_;
	$self->setChanged;
	$self->notifyObservers();
	#~ exit 1;# Placed here for brevity.
}

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9



#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

ButtonAction - Take action when the button is pressed

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9
