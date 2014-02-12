//
//  AppDelegate.h
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "controllerIcons.h"
#import "controllerRetina.h"


@interface AppDelegate : NSObject <NSApplicationDelegate> {
	NSUserDefaults *userDefaults;
	IBOutlet NSView *mainView;
}


-(IBAction)openTab:(id)sender;



@property (assign) IBOutlet NSWindow *window;
@property (nonatomic) IBOutlet NSToolbar *toolbar;

@property (nonatomic,strong) NSViewController *currentView;
@property (nonatomic,strong) controllerIcons *viewIcons;
@property (nonatomic,strong) controllerRetina *viewRetina;




@end
