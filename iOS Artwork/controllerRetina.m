//
//  controllerRetina.m
//  iOS Artwork
//
//  Created by Paul Derbyshire on 12/02/2014.
//  Copyright (c) 2014 Resonance. All rights reserved.
//

#import "controllerRetina.h"

@interface controllerRetina ()

@end

@implementation controllerRetina


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)awakeFromNib {
	[self setUp];
}

-(void)setUp {
	NSRect dropRect = NSRectFromCGRect(CGRectMake((self.view.frame.size.width - 56) - 16,(self.view.frame.size.height - 56) - 16,56,56));
	imageDrop *dropper = [[imageDrop alloc] initWithFrame:dropRect];
	[dropper setDelegate:self];
	[self.view addSubview:dropper];
	
	
}


-(void)filesDropped:(NSArray *)arrayFiles {
	
	[progressBar startAnimation:Nil];
	
	backgroundQueue = dispatch_queue_create("resizeQueue", NULL);
	
	dispatch_async(backgroundQueue, ^(void) {
		for (id file in arrayFiles) {
			[self copyImage:file];
			[self resizeImage:file];
		}
		[progressBar stopAnimation:nil];
	});
	
}


-(BOOL)copyImage:(NSString *)imagePath {
	
	NSString *fileName = [[imagePath lastPathComponent] stringByDeletingPathExtension];
	NSString *fileExtension = [[imagePath lastPathComponent] pathExtension];
	NSString *fileNameNew = [NSString stringWithFormat:@"%@@2x.%@",fileName,fileExtension];
	NSString *fileNameOriginal = [NSString stringWithFormat:@"%@-original.%@",fileName,fileExtension];
	
	NSString *folderPath = [imagePath stringByDeletingLastPathComponent];
	NSString *destination = [folderPath stringByAppendingPathComponent:fileNameNew];
	NSString *destinationOriginal = [folderPath stringByAppendingPathComponent:fileNameOriginal];
	
	if ( [[NSFileManager defaultManager] isReadableFileAtPath:imagePath] ) {
		// Create the @2x file
		[[NSFileManager defaultManager] copyItemAtPath:imagePath toPath:destination error:nil];
		// The original file for backup purposes
		//[[NSFileManager defaultManager] copyItemAtPath:imagePath toPath:destinationOriginal error:nil];
	}

	return YES;
}

-(BOOL)resizeImage:(NSString *)imagePath {
	
	NSImage *originalImage = [[NSImage alloc] initWithContentsOfFile:imagePath];

	NSString *fileName = [[imagePath lastPathComponent] stringByDeletingPathExtension];;
	NSString *folderPath = [imagePath stringByDeletingLastPathComponent];
	NSRect newRect = NSRectFromCGRect(CGRectMake(0, 0, originalImage.size.width / 2, originalImage.size.height / 2));
	
	
	NSImage *newImage = [[NSImage alloc] initWithSize:CGSizeMake(originalImage.size.width / 2, originalImage.size.height / 2)];
	[newImage lockFocus];
	[originalImage drawInRect:newRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	[newImage unlockFocus];
	
	NSString *newFileName = [NSString stringWithFormat:@"%@.png",fileName];
	NSString *finalPath = [folderPath stringByAppendingPathComponent:newFileName];
	NSData *imageData = [newImage TIFFRepresentationUsingCompression:NSTIFFCompressionLZW factor:1];
	NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:imageData];
    NSData *dataToWrite = [rep representationUsingType:NSPNGFileType properties:nil];
	[dataToWrite writeToFile:finalPath atomically:NO];

	return YES;
}

@end
