package WeatherData;
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

sub setMeasurements{
	my ( $self, $temperature, $humidity, $pressure ) = @_;
	$self->_set_temp( $temperature );
	$self->_set_humidity( $humidity );
	$self->_set_pressure( $pressure );
	$self->measurementsChanged();
}

sub measurementsChanged{
	my ( $self,) = @_;
	$self->setChanged;
	$self->notifyObservers();
}

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9

has _temp =>(
		isa => Num,
		writer	=> '_set_temp',
		reader	=> 'getTemperature',
	);

has _humidity =>(
		isa => Num,
		writer	=> '_set_humidity',
		reader	=> 'getHumidity',
	);

has _pressure =>(
		isa => Num,
		writer	=> '_set_pressure',
		reader	=> 'getPressure',
	);

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

WeatherData - Weather station

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9
