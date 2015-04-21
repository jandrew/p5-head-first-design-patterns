#########1 Test File for the Swing Observer Equivalent
#!/usr/bin/env perl
use Tk;
use strict;
use lib '../../jandrew_lib/Chapter02/swing';
use ButtonAction;
use AngelListener;
use DevilListener;

my	$buttonAction = ButtonAction->new;
AngelListener->new( $buttonAction );
DevilListener->new( $buttonAction );
my $mw = MainWindow->new;
$mw->Label(-text => "Click the button\nLook for the output\nthen exit the window.")->pack;
$mw->Button(
	-text    => "Should I do it?",
	-command => sub { $buttonAction->buttonPressed },
)->pack;
MainLoop;