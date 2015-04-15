//
//  ViewController.h
//  arc_transformer
//
//  Created by RentonTheUncoped on 15/1/16.
//  Copyright (c) 2015年 Uncoped Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (nonatomic, strong) NSURL* directoryURL;

@property (nonatomic, weak) IBOutlet NSTextField* label_path;


- (IBAction)selectPathButtonClicked:(id)sender;
@end

