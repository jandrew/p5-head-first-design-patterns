package Observer;
use version; our $VERSION = qv('v0.0.1');
# This more closely resembles the 
use Data::Dumper;
use Moose::Role;
use Types::Standard qw(
		Num		Int			ConsumerOf
    );

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9

has subjectPosition =>(
		isa			=> Int,
		writer 		=> 'set_position',
		reader		=> 'get_position',
		predicate	=> 'has_position',
	);

has temp =>(
		isa => Num,
		writer	=> 'set_temp',
		reader	=> 'temp',
	);

has humidity =>(
		isa => Num,
		writer	=> 'set_humidity',
		reader	=> 'humidity',
	);

has pressure =>(
		isa => Num,
		writer	=> 'set_pressure',
		reader	=> 'pressure',
	);

has weatherData =>(
		isa		=> ConsumerOf['Subject'],
		reader	=> 'get_weatherData',
		handles	=>[ 'registerObserver' ],
		trigger => \&_register_observer,
	);
	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub update{
	my ( $self, $update_ref ) = @_;
	for my $key ( keys %$update_ref ){
		my $method = 'set_' . $key;
		$self->$method( $update_ref->{$key} );
	}
}

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9


	
#########1 Private Methods    3#########4#########5#########6#########7#########8#########9

around BUILDARGS => sub {
    my ( $orig, $class, @input_list ) = @_;
	my $meta = $class->meta;
	my ( %class_args, @observable_list );
	my $need_value;
	for my $value ( @input_list ){
		if( $need_value ){
			$class_args{$need_value} = $value;
			$need_value = undef;
		}elsif( $meta->has_attribute( $value ) ){
			$need_value = $value;
		}else{
			push @observable_list, $value;
		}
	}
	$class_args{weatherData} = $observable_list[0];
	#~ print Dumper( %class_args );
	return $class->$orig(%class_args);
};

sub _register_observer{
	my ( $self, $subject) = @_;
	#~ print "Self:" . Dumper( $self );
	#~ print "Subject:" . Dumper( $subject);
	$subject->registerObserver( $self );
}

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose::Role;

1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

Observer - Observer role for the initial Observer pattern

=head1 DESCRIPTION

The head first design patterns crew use interfaces from Java but Moose implements that 
in the 'isa => ConsumerOf[]' section of the consuming modules so this is the Moose near 
neighbor 'Role'.  Roles appear to be a bit more flexible/powerful than instances so I 
have added common behaviour for the WeatherData as well.

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9

