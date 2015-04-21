package ForcastDisplay;
use version; our $VERSION = qv('v0.0.1');

use Moose;
use MooseX::StrictConstructor;
use MooseX::HasDefaults::RO;
use Types::Standard qw(
		Num			Int
    );
with 'Observer';

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9



#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub display{# No display class needed
	my ( $self, ) = @_;
	print "Forcast: ";
	if ( $self->_currentPressure > $self->_lastPressure ) {
		print "Improving weather on the way!\n";
	} elsif ( $self->_currentPressure == $self->_lastPressure ) {
		print "More of the same\n";
	} else {
		print "Watch out for cooler, rainy weather\n";
	}
}
	

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9

has _currentPressure =>(
		isa		=> Num,
		default => 29.92,
		writer	=> '_set_currentPressure',
	);

has _lastPressure =>(
		isa 	=> Num,
		writer	=> '_set_lastPressure',
	);

#########1 Private Methods    3#########4#########5#########6#########7#########8#########9

after 'update' => sub{
	my ( $self, $input_ref ) = @_;
	if( exists $input_ref->{pressure} ){
		$self->_set_lastPressure( $self->_currentPressure );
		$self->_set_currentPressure( $input_ref->{pressure} );
	}

	$self->display();
};

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

WeatherData - Source of weather data

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9
