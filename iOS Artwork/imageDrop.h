//
//  imageDrop.h
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol imageDropDelegate
-(void)filesDropped:(NSArray *)arrayFiles;
@end

@interface imageDrop : NSImageView {
	id<imageDropDelegate> delegate;

	
	BOOL highlight;
	
}

- (void)setDelegate:(id<imageDropDelegate>)_delegate;


@end
