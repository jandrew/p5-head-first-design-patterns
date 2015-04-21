#!/usr/bin/env perl
my	$dir 	= './';
my	$up		= '../';
for my $next ( <*> ){
	if( ($next eq 't') and -d $next ){
		$dir	= './t/';
		$up		= '';
		last;
	}
}

use	TAP::Formatter::Console;
my $formatter = TAP::Formatter::Console->new({
					jobs => 1,
					#~ verbosity => 1,
				});
my	$args ={
		test_args =>{
			Ducks_test		=>[ $up . 'jandrew_lib/Chapter01/' ],
			Weather_test	=>[ $up . 'jandrew_lib/Chapter02/weather/' ],
			WeatherObservable_test	=>[ $up . 'jandrew_lib/Chapter02/weatherobservable/' ],
		},
		formatter => $formatter,
	};
my	@tests =(
		[ $dir . 'Chapter01/MiniDuckSimulator.t', 'Ducks_test' ],
		[ $dir . 'Chapter02/WeatherStation.t', 'Weather_test' ],
		[ $dir . 'Chapter02/WeatherStation.t', 'WeatherObservable_test' ],
	);
use	TAP::Harness;
use	TAP::Parser::Aggregator;
my	$harness	= TAP::Harness->new( $args );
my	$aggregator	= TAP::Parser::Aggregator->new;
	$aggregator->start();
	$harness->aggregate_tests( $aggregator, @tests );
	$aggregator->stop();
use Test::More;
explain $formatter->summary($aggregator);
pass( "Test Harness Testing complete" );
done_testing();