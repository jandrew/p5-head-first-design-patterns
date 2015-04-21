package StatisticsDisplay;
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
	printf "%s%.1f/%.1f/%.1f\n",
		(
			"Avg/Max/Min temperature = ", ($self->_tempSum / $self->_numReadings),
			$self->_maxTemp, $self->_minTemp
		);
}
	

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9

has _maxTemp =>(
		isa		=> Num,
		default => 0,
		writer	=> '_set_maxTemp',
	);

has _minTemp =>(
		isa 	=> Num,
		default => 200,
		writer	=> '_set_minTemp',
	);

has _tempSum =>(
		isa		=> Num,
		traits	=> ['Number'],
		default => 0,
		writer	=> '_set_tempSum',
		handles =>{
			_add_to_temp => 'add',
		},
	);

has _numReadings =>(
		isa		=> Int,
		traits	=> ['Number'],
		default => 0,
		writer	=> '_set_numReadings',
		handles => { _plus_plus => [ 'add' => 1 ] },#Currying the Moose!
	);

#########1 Private Methods    3#########4#########5#########6#########7#########8#########9

after 'update' => sub{
	my ( $self, ) = @_;
	$self->_add_to_temp( $self->temp );
	$self->_plus_plus;
	
	if ( $self->temp > $self->_maxTemp) {
		$self->_set_maxTemp( $self->temp );
	}
 
	if ( $self->temp < $self->_minTemp) {
		$self->_set_minTemp( $self->temp );
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
