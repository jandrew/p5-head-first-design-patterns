package HeatIndexDisplay;
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
	my ( $self, $heat_index ) = @_;
	printf "%s%.5f\n", ("Heat index is ", $heat_index);
}
	

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9



#########1 Private Methods    3#########4#########5#########6#########7#########8#########9

after 'update' => sub{
	my ( $self, $input_ref ) = @_;
	my $temperature = $input_ref->{temp};
	my $humidity = $input_ref->{humidity};
	my $heat_index =(
		(
			16.923 + (0.185212 * $temperature) +
			(5.37941 * $humidity) - 
			(0.100254 * $temperature * $humidity) +
			(0.00941695 * ($temperature * $temperature)) + 
			(0.00728898 * ($humidity * $humidity)) +
			(0.000345372 * ($temperature * $temperature * $humidity)) -
			(0.000814971 * ($temperature * $humidity * $humidity)) +
			(0.0000102102 * ($temperature * $temperature * $humidity * $humidity)) - 
			(0.000038646 * ($temperature * $temperature * $temperature)) +
			(0.0000291583 * ($humidity * $humidity * $humidity)) +
			(0.00000142721 * ($temperature * $temperature * $temperature * $humidity)) + 
			(0.000000197483 * ($temperature * $humidity * $humidity * $humidity)) -
			(0.0000000218429 * ($temperature * $temperature * $temperature * $humidity * $humidity)) +
			(0.000000000843296 * ($temperature * $temperature * $humidity * $humidity * $humidity))
		) -
		(0.0000000000481975 * ($temperature * $temperature * $temperature * $humidity * $humidity * $humidity))
	);

	$self->display( $heat_index);
};

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose;
__PACKAGE__->meta->make_immutable;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

HeatIndexDisplay - Display the current heat index

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9
