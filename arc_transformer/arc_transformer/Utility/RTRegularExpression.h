//
//  regularExpression.h
//  arc_transformer
//
//  Created by RentonTheUncoped on 15/1/19.
//  Copyright (c) 2015年 Uncoped Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RTProcessRelease = 0x1<<0,
    RTProcessDealloc = 0x1<<1,
    RTProcessRetain = 0x1<<2,
    RTProcessAutorelease = 0x1<<3,
    RTProcessRetainProperty = 0x1<<4,
    RTProcessAssignProperty = 0x1<<5,
    RTProcessAll = 0xffffff
} RTARCProcessType;

@interface RTRegularExpression : NSObject

+ (NSString*)stringByReplaceString:(NSString*)str_origin withPattern:(NSString*)pattern templateString:(NSString*)templateString;
+ (void)replaceString:(NSMutableString*)str_orign withPattern:(NSString*)pattern templateString:(NSString*)templateString;
+ (NSString*)replaceFileURL:(NSURL*)url_filePath withPattern:(NSString *)pattern templateString:(NSString*)templateString;

//替换[xx release];
+ (void)replaceReleaseForString:(NSMutableString*)str_origin;

//替换[super dealloc];
+ (void)replaceDeallocForString:(NSMutableString *)str_origin;

//替换[xx retain]
+ (void)replaceRetainForString:(NSMutableString *)str_origin;

//替换[[[xx alloc]initxx:xx]autorelease];
+ (void)replaceAutoreleaseForString:(NSMutableString *)str_origin;

//替换(strong, xx) (xx, strong) (strong)
+ (void)replaceRetainToStrongForString:(NSMutableString*)str_origin;

//替换(assign, xx) (xx, assign) (assign)
+ (void)replaceAssignToWeakForString:(NSMutableString*)str_origin;

//封装，对外接口，整体
+ (void)replaceMRCToARCForString:(NSMutableString*)str_origin option:(RTARCProcessType)type;

+ (void)test;
@end
