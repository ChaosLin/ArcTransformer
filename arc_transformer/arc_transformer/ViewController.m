//
//  ViewController.m
//  arc_transformer
//
//  Created by RentonTheUncoped on 15/1/16.
//  Copyright (c) 2015年 Uncoped Studio. All rights reserved.
//

#import "ViewController.h"
#import "IgnoreFiles.h"
#import "RTRegularExpression.h"

@interface ViewController()

- (IBAction)transButtonClicked:(id)sender;

- (BOOL)checkPathValid;
- (void)parseParth;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString* str_path = //@"Macintosh HD ▸ 用户 ▸ RentonTheUncoped ▸ 文稿 ▸ WorkSpace";
////                            @"/Users/RentonTheUncoped/Documents/WorkSpace/arc_transformer";
////                            @"/Users/RentonTheUncoped/iPhone5.0.2_ARC/DDEngine";
////                            @"/Users/RentonTheUncoped/iPhone5.0.2_ARC/ThirdSDKs";
////                            @"/Users/RentonTheUncoped/iPhone5.0.2_ARC/DDDevLib";
//                            @"/Users/RentonTheUncoped/iPhone5.0.2_ARC/DD_iPhone_Client2.0.0";
////                                @"/Users/RentonTheUncoped/iPhone5.0.2_ARC/DD_iPhone_Client2.0.0";
////                                @"/Users/RentonTheUncoped/iPhone5.0.2_ARC/";
}

- (IBAction)selectPathButtonClicked:(id)sender
{
    NSOpenPanel* panel = [NSOpenPanel new];
    panel.canChooseDirectories = YES;
    panel.canChooseFiles = NO;
    BOOL okButtonPressed = ([panel runModal] == NSModalResponseOK);
    if (okButtonPressed)
    {
        self.directoryURL = panel.URL;
        self.label_path.stringValue = self.directoryURL.absoluteString;
    }
}

- (BOOL)checkPathValid
{
    return self.directoryURL?YES:NO;
}

- (IBAction)transButtonClicked:(id)sender
{
    [self parseParth];
}

- (void)parseParth
{
    if (![self checkPathValid])
    {
        return;
    }
    
//    NSURL* url_resource = [NSURL URLWithString:self.directoryPath relativeToURL:nil];
    NSURL* url_resource = self.directoryURL;
    
    NSDirectoryEnumerator* enumerator = [[NSFileManager defaultManager] enumeratorAtURL:url_resource includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsPackageDescendants | NSDirectoryEnumerationSkipsHiddenFiles errorHandler:^BOOL(NSURL *url, NSError *error) {
        NSLog(@"error:%@", error);
        return YES;
    }];
    
    for (NSURL* url in enumerator)
    {
        NSString* str_filePath = url.absoluteString;
        NSString* fileName = str_filePath.lastPathComponent;
        //非m、mm、h不处理
        if ((![fileName hasSuffix:@".m"] && ![fileName hasSuffix:@".h"] && ![fileName hasSuffix:@".mm"]) || [IgnoreFiles includeFile:fileName])
        {
            NSLog(@"ignore %@", url);
        }
        else
        {
            NSLog(@"Processing url: %@", url);
            
            //替换
            NSMutableString* str_file = [[NSMutableString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            if (str_file)
            {
                [RTRegularExpression replaceMRCToARCForString:str_file option:RTProcessAll];
                if (str_file)
                {
                    NSError* error_write = nil;
                    [str_file writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error_write];
                }
            }
            
            NSLog(@"Finished processing url: %@", url);
        }
    }

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
