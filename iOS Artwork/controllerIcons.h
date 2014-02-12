//
//  controllerIcons.h
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <dispatch/dispatch.h>

#import "imageDrop.h"

@interface controllerIcons : NSViewController <imageDropDelegate> {
	
	IBOutlet NSImageView *dropperView;
	IBOutlet NSBox *boxMain;
	IBOutlet NSProgressIndicator *progressBar;
	
	NSMutableArray *arraySizes;
	dispatch_queue_t backgroundQueue;

}


-(IBAction)sizeCheckboxes:(id)sender;



@end
