//
//  controllerRetina.h
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <dispatch/dispatch.h>

#import "imageDrop.h"


@interface controllerRetina : NSViewController <imageDropDelegate> {
	
	IBOutlet NSImageView *dropperView;
	IBOutlet NSBox *boxMain;
	IBOutlet NSProgressIndicator *progressBar;
	
	dispatch_queue_t backgroundQueue;

}

@end
