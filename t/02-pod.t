#!/usr/bin/env perl
### Test that the pod files run
use Test::More;
use Test::Pod 1.48;
my	$up		= '../';
for my $next ( <*> ){
	if( ($next eq 't') and -d $next ){
		### <where> - found the t directory - must be using prove ...
		$up	= '';
		last;
	}
}
pod_file_ok( $up . 	'README.pod',
						"The README file has good POD" );
done_testing();