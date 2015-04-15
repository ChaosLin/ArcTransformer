//
//  IgnoreFiles.m
//  arc_transformer
//
//  Created by RentonTheUncoped on 15/1/16.
//  Copyright (c) 2015年 Uncoped Studio. All rights reserved.
//

#import "IgnoreFiles.h"
static IgnoreFiles* ignoreFiles = nil;

@interface IgnoreFiles ()
+ (instancetype)sharedInstance;
+ (void)destroy;

- (BOOL)includeFileName:(NSString*)fileName;

@property (nonatomic, strong) NSMutableArray* arr_ignoreFileName;
@end

@implementation IgnoreFiles

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ignoreFiles = [[self class] new];
    });
    return ignoreFiles;
}

+ (void)destroy
{
    ignoreFiles = nil;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.arr_ignoreFileName = [NSMutableArray array];
        NSMutableArray* arr_all = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IgnoreFile" ofType:@"plist"]];
        for (NSArray* arr_group in arr_all)
        {
            [self.arr_ignoreFileName addObjectsFromArray:arr_group];
        }
    }
    return self;
}

+ (BOOL)includeFile:(NSString *)fileName
{
    BOOL result = [[IgnoreFiles sharedInstance] includeFileName:fileName];
    return result;
}

- (BOOL)includeFileName:(NSString*)fileName
{
    __block BOOL result = NO;
    [self.arr_ignoreFileName enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (NSOrderedSame == [fileName caseInsensitiveCompare:obj])
        {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}
@end
