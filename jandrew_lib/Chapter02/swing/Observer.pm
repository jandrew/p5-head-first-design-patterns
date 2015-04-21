package Observer;
use version; our $VERSION = qv('v0.0.1');
use Data::Dumper;
use Moose::Role;
use Types::Standard qw(
		ArrayRef	HashRef		ConsumerOf		Str
    );

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9

has observables =>(
		isa		=> HashRef[ConsumerOf['Observable']],
		traits	=> ['Hash'],
		default => sub{ {} },
		reader	=> 'get_observables',
		handles	=>{
			get_observable		=> 'get',
			_set_observable		=> 'set',
			observable_objects	=> 'values',
			_clear_observable	=> 'delete',
		},
	);
	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

sub update{
	my ( $self, $update_ref ) = @_;
	my $observable_name;
	my $x = 0;
	while( !$observable_name or $observable_name =~ /(Class::MOP|Eval|Observable)/ ){
		my @caller = caller( $x++ );
		#~ print Dumper( @caller );
		$observable_name = $caller[0];
	}
	#~ print "Observable -$observable_name- just pushed\n";
	$self->set_pushed_data( $update_ref );
	$self->set_pushed_source( $observable_name );
}

sub set_observables{
	my ( $self, @observable_list ) = @_;
	for my $observable ( @observable_list ){
		my $name = ref $observable or
			die "Passed -$observable- but it doesn't appear to be an observable object";
		$self->_set_observable( $name => $observable );
		$observable->addObserver( $self );
	}
}

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9

has _pushed_data =>(
		isa		=> ArrayRef,
		default	=> sub{ [] },
		writer	=> 'set_pushed_data',
		reader	=> 'get_pushed_data',
	);

has _pushed_source =>(
		isa		=> Str,
		writer	=> 'set_pushed_source',
		reader	=> 'get_pushed_source',
		clearer	=> 'clear_pushed_source',
		predicate => 'has_pushed_source',
	);
	
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
	for my $observable ( @observable_list ){
		my $name = ref $observable or
			die "Passed -$observable- but it doesn't appear to be an observable object";
		$class_args{observables}->{$name} = $observable;
	}
	#~ print Dumper( %class_args );
	return $class->$orig(%class_args);
};

sub BUILD{
	my ( $self, ) = @_;
	for my $object ( $self->observable_objects ){
		$object->addObserver( $self );
	}
}

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose::Role;
	
1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

Observer - Observer role to match with Observable

=head1 DESCRIPTION

The head first design patterns crew use interfaces from Java but Moose implements that 
in the 'isa => ConsumerOf[]' section of the consuming modules so this is the Moose near 
neighbor 'Role'.  Roles appear to be a bit more flexible/powerful than instances so I 
have added common behaviour for the WeatherData as well.

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9

