//
//  controllerIcons.m
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import "controllerIcons.h"

@interface controllerIcons ()

@end

@implementation controllerIcons

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
		[self setUp];
    }
    return self;
}
- (void)awakeFromNib {

}

-(void)setUp {
	NSRect dropRect = NSRectFromCGRect(CGRectMake((self.view.frame.size.width - 56) - 16,(self.view.frame.size.height - 56) - 16,56,56));
	imageDrop *dropper = [[imageDrop alloc] initWithFrame:dropRect];
	[dropper setDelegate:self];
	[self.view addSubview:dropper];
	
	arraySizes = [[NSMutableArray alloc] initWithObjects:@1024,@640,@512,@320,@144,@114,@96,@72,@64,@58,@57,@48,@29, nil];
	
}

-(IBAction)sizeCheckboxes:(id)sender{
	
}



-(void)filesDropped:(NSArray *)arrayFiles {
	
	[progressBar startAnimation:Nil];
	
	backgroundQueue = dispatch_queue_create("resizeQueue", NULL);

	dispatch_async(backgroundQueue, ^(void) {
		for (id file in arrayFiles) {
			for (NSNumber *size in arraySizes) {
				[self resizeImage:file toSize:size];
			}
		}
		[progressBar stopAnimation:nil];
	});
	
}


-(BOOL)resizeImage:(NSString *)imagePath toSize:(NSNumber *)size {
	
	NSString *fileName = [[imagePath lastPathComponent] stringByDeletingPathExtension];;
	NSString *folderPath = [imagePath stringByDeletingLastPathComponent];
	NSRect newRect = NSRectFromCGRect(CGRectMake(0, 0, [size floatValue], [size floatValue]));
	
	NSImage *originalImage = [[NSImage alloc] initWithContentsOfFile:imagePath];
	
	NSImage *newImage = [[NSImage alloc] initWithSize:CGSizeMake([size floatValue], [size floatValue])];
	[newImage lockFocus];
	[originalImage drawInRect:newRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	[newImage unlockFocus];
	
	NSString *newFileName = [NSString stringWithFormat:@"%@-%@.png",fileName,size];
	NSString *finalPath = [folderPath stringByAppendingPathComponent:newFileName];
	NSData *imageData = [newImage TIFFRepresentation];
	NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:imageData];
    NSData *dataToWrite = [rep representationUsingType:NSPNGFileType properties:nil];
	[dataToWrite writeToFile:finalPath atomically:NO];

	
	
	NSLog(@"RESIZING: %@ to %@",fileName,newFileName);
	return YES;
}












@end
