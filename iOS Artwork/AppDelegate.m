//
//  AppDelegate.m
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate
@synthesize toolbar,currentView,viewIcons,viewRetina;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
	userDefaults = [NSUserDefaults standardUserDefaults];
	
	viewIcons = [[controllerIcons alloc] initWithNibName:@"controllerIcons" bundle:[NSBundle mainBundle]];
	viewRetina = [[controllerRetina alloc] initWithNibName:@"controllerRetina" bundle:[NSBundle mainBundle]];
	
	[toolbar setSelectedItemIdentifier:@"icons"];
	[self loadTab:1];
	
}


-(IBAction)openTab:(id)sender {
	[self loadTab:[sender tag]];
}

-(void)loadTab:(NSUInteger)tab {
	
	[[mainView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

	switch (tab) {
		case 1:
			//NSLog(@"load: icons");
			[mainView addSubview:viewIcons.view];
			break;
		case 2:
			//NSLog(@"load: retina");
			[mainView addSubview:viewRetina.view];
			break;
			
		default:
			currentView = viewIcons;
			break;
	}
	
	[mainView addSubview:currentView.view];
	
	[userDefaults setInteger:tab forKey:@"currentTab"];
	[userDefaults setObject:toolbar.selectedItemIdentifier forKey:@"currentTabIdentifier"];
	[userDefaults synchronize];
	
}





@end
