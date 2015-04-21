package AngelListener;
use version; our $VERSION = qv('v0.0.1');

use Moose;
use MooseX::StrictConstructor;
use MooseX::HasDefaults::RO;
with 'Observer';

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9



#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub display{
	my ( $self, ) = @_;
	print "Don't do it, you might regret it!\n";
}
	

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9



#########1 Private Methods    3#########4#########5#########6#########7#########8#########9

after 'update' => sub{
	my ( $self, $input_ref ) = @_;

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
