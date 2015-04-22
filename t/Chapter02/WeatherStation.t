#########1 Test File for the Weather Station      5#########6#########7#########8#########9
#!/usr/bin/env perl
use Test::Most tests => 20;
use Capture::Tiny qw( capture_stdout );

my $sub_lib = 'jandrew_lib/Chapter02/weather';
my ( @use_lib ) = @ARGV;
@use_lib = ( @use_lib ) ? ( @use_lib ) :
	( '../../' . $sub_lib, $sub_lib );
eval "use lib '" . join( "', '", @use_lib ) . "'";
require WeatherData;
require CurrentConditionsDisplay;
require StatisticsDisplay;
require ForcastDisplay;
require HeatIndexDisplay;#Comment out till page 61 complete

my ( $weatherData, $currentDisplay, $statisticsDisplay, $forcastDisplay, $output, );
my $x = 0;
my $question_ref = [
		[80, 65, 30.4],
		[82, 70, 29.2],
		[78, 90, 29.2],
	];
my $answer_ref = [
		[
			"Current conditions: 80.0F degrees and 65.0% humidity",
			"Avg/Max/Min temperature = 80.0/80.0/80.0",
			"Forcast: Improving weather on the way!",
			'Heat index is 82.95535'#Comment out till page 61 complete
		],
		[
			"Current conditions: 82.0F degrees and 70.0% humidity",
			"Avg/Max/Min temperature = 81.0/82.0/80.0",
			"Forcast: Watch out for cooler, rainy weather",
			'Heat index is 86.90123'#Comment out till page 61 complete
		],
		[
			"Current conditions: 78.0F degrees and 90.0% humidity",
			"Avg/Max/Min temperature = 80.0/82.0/78.0",
			"Forcast: More of the same",
			'Heat index is 83.64967',#Comment out till page 61 complete
		],
	];
lives_ok{	$weatherData = WeatherData->new }
				"Make a WeatherStation";
lives_ok{	
			$currentDisplay = CurrentConditionsDisplay->new( $weatherData );
}
				"Start the current conditions display";
lives_ok{	$statisticsDisplay = StatisticsDisplay->new( $weatherData ) }
				"Start the statistics display";
lives_ok{	$forcastDisplay = ForcastDisplay->new( $weatherData ) }
				"Start the forcast display";
lives_ok{	$forcastDisplay = HeatIndexDisplay->new( $weatherData ) }
				"Start the heat index display";#Comment out till page 61 complete
			for my $question ( @$question_ref ){
ok			1,	"Setting weather station to: " . join( ' - ', @$question );
			$output = capture_stdout{ 
				$weatherData->setMeasurements( @$question );
			};
			my $result_ref = [ split /\n/, $output ];
			for my $result ( @$result_ref ){
			my $y = 0;
			TESTMATCH:for my $answer ( @{$answer_ref->[$x]} ){# To allow for out of order returns
			if( $result eq $answer ){
ok			$result,
				"Found expected output: $answer";
			splice( @{$answer_ref->[$x]}, $y, 1 );
			last TESTMATCH;
			}
			$y++;
			}
			}
			for my $answer ( @{$answer_ref->[$x]} ){
ok			!$answer,
				"Expected missing answer: $answer";
			}
			$x++;
			}
done_testing();
explain 								"...Is it hot today, or is it just me?";