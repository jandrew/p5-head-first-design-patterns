package Subject;
use version; our $VERSION = qv('v0.0.1');
use Data::Dumper;
use Moose::Role;
use Types::Standard qw(
		ArrayRef	HasMethods ConsumerOf
    );

#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9


	
#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

# This is slightly trickier than the Java equivalent push but Moose doesn't appear to have 
#  the same instance matching for removal that Java does.  The up side is the cleaner 
#  Observer removal code.
sub registerObserver{
	my ( $self, $observer ) = @_;
	#~ print "registering observer: " . Dumper( $observer );
	if( $observer->has_position ){# From an abundance of caution to avoid reporting to zombies
		$self->removeObserver( $observer );
	}
	my $position = $#{$self->_get_observerList};
	$observer->set_position( $position );
	$self->_add_item( $observer );
}

# This isn't super clean since the removal of observers leaves a hole and an effective 
#  memory leak for long running processes.  Strategies to handle that are; re-setting 
#  positions on all subsequent observers after a splice, maintaining an open wholes list 
#  and using it to backfill new observers if available, or changing the _observerList to a 
#  hash table from an array.  (The last still requires storing the key for each observer in 
#  it's instance.)
sub removeObserver{
	my ( $self, $observer ) = @_;
	$self->_change_item( $observer->get_position, undef );
}

sub notifyObservers{
	my ( $self, $update_ref ) = @_;
	for my $observer ( @{$self->_get_observerList} ){
		$observer->update( $update_ref );# More flexible than the head-first version
	}
}

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9

has _observerList =>(# Java WeatherData line 6
		isa => ArrayRef[# Java WeatherData line 6
			#The next line is the equivalent of the 'Subject' Interface
			ConsumerOf['Observer']# Java WeatherData line 6 and all of Subject.java
		],# Java WeatherData line 6
		traits	=> ['Array'],# Java WeatherData line 3
		default	=> sub{ [] },# Java WeatherData line 12
		reader	=> '_get_observerList',
		handles =>{
			_next_postion	=> 'count',
			_add_item		=> 'push',
			_change_item	=> 'set',
		}
	);

#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose::Role;

1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9

__END__

=head1 NAME

Subject - Subject Role for the initial Observer pattern

=cut

#########1#########2 main pod documentation end  5#########6#########7#########8#########9

