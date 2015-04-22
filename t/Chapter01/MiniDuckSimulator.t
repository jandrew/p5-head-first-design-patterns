#########1 Test File for the Duck Simulator       5#########6#########7#########8#########9
#!/usr/bin/env perl
use Test::Most tests => 9;
use Capture::Tiny qw( capture_stdout );

my $sub_lib = 'jandrew_lib/Chapter01';
my ( @use_lib ) = @ARGV;
@use_lib = ( @use_lib ) ? ( @use_lib ) :
	( '../../' . $sub_lib, $sub_lib );
eval "use lib '" . join( "', '", @use_lib ) . "'";
require MallardDuck;
require ModelDuck;
require FlyRocketPowered;
require Quack;
my ( $mallard, $model, $output, $duck_call );
my $x = 0;
my $answer_ref = [
		"Quack", "I'm flying!!",
		"I can't fly", "I'm flying with a rocket!",
		"Quack",
	];
lives_ok{	$mallard = MallardDuck->new }
				"Make a MallardDuck";
			$output = capture_stdout{ $mallard->quack }; chomp $output;
is			$output, $answer_ref->[$x],
				"Ensure it quacks with: " . $answer_ref->[$x++];
			$output = capture_stdout{ $mallard->fly }; chomp $output;
is			$output, $answer_ref->[$x],
				"Ensure it flys with: " .  $answer_ref->[$x++];

lives_ok{	$model = ModelDuck->new }
				"Make a ModelDuck";
			$output = capture_stdout{ $model->fly }; chomp $output;
is			$output, $answer_ref->[$x],
				"Make sure it doesn't fly with: " .  $answer_ref->[$x++];
ok			$model->set_flyBehavior( FlyRocketPowered->new ),
				"Give the model a jet pack";
			$output = capture_stdout{ $model->fly }; chomp $output;
is			$output, $answer_ref->[$x],
				"..and see how fast it goes with: " .  $answer_ref->[$x++];

lives_ok{	$duck_call = Quack->new }
				"Make a Duck call";
			$output = capture_stdout{ $duck_call->quack }; chomp $output;
is			$output, $answer_ref->[$x],
				"Blow the call with: " .  $answer_ref->[$x++];
done_testing;
#~ explain 								"...Ducks in the house!";