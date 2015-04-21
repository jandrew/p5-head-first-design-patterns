package Observable;
use version; our $VERSION = qv('v0.0.1');
use Data::Dumper;
use Moose::Role;
use Types::Standard qw(
		HashRef		ArrayRef	Str		Bool
    );

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9

has changed =>(
		isa		=> Bool,
		traits	=> ['Bool'],
		default	=> 0,
		reader	=> 'changed',
		handles =>{
			setChanged => 'set',
			_darken_changed => 'unset',
		},
	);
	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

# The issue here is that perl/Moose can't match a reference against a previous stored 
#  reference.  I add the signature attribute to the observer to resolve this.  There is a 
#  risk of a namespace clash with this attribute if you wanted it for some other purpose. 
sub addObserver{
	my ( $self, $observer ) = @_;
	my $meta = $observer->meta or die "The passed instance is not a Class::MOP::Class";
	if( !$meta->has_method( 'update' ) ){
		die "Passed instance does not have the 'update' method";
	}
	if( !$meta->has_attribute( '_observer_id' ) ){
		$meta = $self->_add_signature( $meta );
	}
	my $class = ref $self;
	#~ print "Checking for registration of: $class\n";
	if( $observer->_has_registration( $class ) ){# to avoid reporting to zombies from reregistration and then destruction
		warn "This instance is already registered";
	}else{
		my $position = $self->_holes_exist ?
			$self->_get_hole : $self->_next_postion;
		$observer->_set_registration( $class => $position );
		#~ print "Changing position: $position for class: " . ref( $observer ) ."\n";
		$self->_change_item( $position => $observer );
	}
}

# This is where I leverage the signature 
sub deleteObserver{
	my ( $self, $observer ) = @_;
	my $class = ref $self;
	my $position;
	if( !$observer->can( '_get_registration' ) or # Warn on unregisterd observers
		!defined $observer->_get_registration( $class ) ){
			warn "Attempting to remove an Observer that was never registered";
			return 0;
	}else{
		$position = $observer->_get_registration( $class );
		#~ print "Removing position: $position for class: " . ref( $observer );
		$self->_change_item( $position => undef );
		$self->_add_hole( $position );
		$observer->clear_observable( $class );
	}
}

sub notifyObservers{
	my ( $self, @update_list ) = @_;
	if( $self->changed ){
		my $update = @update_list ? [@update_list] : [];
		#~ print "Start sending updates\n";
		#~ my $x = 0;
		for my $observer ( @{$self->_get_observerList} ){
			next if !$observer;
			#~ print "Notify observer $x++\n";
			$observer->update( $update );
		}
		$self->_darken_changed;
	}
}

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9

has _observerList =>(
		isa => ArrayRef,
		traits	=> ['Array'],
		default	=> sub{ [] },
		reader	=> '_get_observerList',
		handles =>{
			_next_postion	=> 'count',
			_change_item	=> 'set',
		}
	);
	
has _holes_list =>(
		isa => ArrayRef,
		traits => ['Array'],
		default => sub{ [] },
		handles =>{
			_holes_exist	=> 'count',
			_add_hole		=> 'push',
			_get_hole		=> 'shift',
		},
	);
	
#########1 Private Methods    3#########4#########5#########6#########7#########8#########9

sub _add_signature{
	my ( $self, $meta ) = @_;
	my $re_mute = 0;
	if( $meta->is_immutable ){
		$re_mute = 1;
		$meta->make_mutable;
	}
	$meta->add_attribute(
		_observer_id =>(
			isa => HashRef,
			traits =>['Hash'],
			handles =>{
				_has_registration => 'exists',
				_set_registration => 'set',
				_get_registration => 'get',
				_unregister       => 'delete',
			},
		)
	);
	if( $re_mute ){
		$meta->make_immutable;
	}
	return $meta;
}

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose::Role;

1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

Observable - Moose observable class like Java

=head1 DESCRIPTION

This is meant as an excersise to substitute for the Java Observable class instead of the 
Head First Design Patterns use of the java.util.Observable.  For an instance to be an 
observer it must be a Class::MOP::Class and it must have the 'update' method.  Incrementally 
this role will add the attribute '_observer_id' and populate it with hash key => value pairs 
to sign the observer so it can recognize it again if it shows up (for deletion) later.

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9

