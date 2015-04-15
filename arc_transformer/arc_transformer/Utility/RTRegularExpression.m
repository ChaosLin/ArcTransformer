//
//  regularExpression.m
//  arc_transformer
//
//  Created by RentonTheUncoped on 15/1/19.
//  Copyright (c) 2015年 Uncoped Studio. All rights reserved.
//

#import "RTRegularExpression.h"

@interface RTRegularExpression ()

@end

@implementation RTRegularExpression



#pragma mark - public
+ (NSString*)stringByReplaceString:(NSString*)string_origin withPattern:(NSString *)pattern templateString:(NSString *)templateString
{
    NSError* error = nil;
    NSString* str_return = nil;
    NSRegularExpression* expression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange range;
    range.location = 0;
    range.length = string_origin.length;
    
    str_return = [expression stringByReplacingMatchesInString:string_origin options:NSMatchingReportProgress range:range withTemplate:templateString];
    return str_return;
}

+ (void)replaceString:(NSMutableString *)str_orign withPattern:(NSString *)pattern templateString:(NSString *)templateString
{
    NSError* error = nil;
    NSRegularExpression* expression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange range;
    range.location = 0;
    range.length = str_orign.length;
    
    [expression replaceMatchesInString:str_orign options:NSMatchingReportProgress range:range withTemplate:templateString];
}

+ (NSString*)replaceFileURL:(NSURL*)url_filePath withPattern:(NSString *)pattern templateString:(NSString *)templateString
{
    NSError* error_readFile = nil;
    NSString* str_origin = [[NSString alloc]initWithContentsOfURL:url_filePath encoding:NSUTF8StringEncoding error:&error_readFile];
    if (str_origin)
    {
        return [self stringByReplaceString:str_origin withPattern:pattern templateString:templateString];
    }
    else
    {
        return nil;
    }
}

#pragma mark release
+ (void)replaceReleaseForString:(NSMutableString *)str_origin
{
    [self replaceString:str_origin withPattern:@"\\[(\\s)*\\w+\\s+release(\\s)*\\](\\s)*(,|;)" templateString:@"//releas_e deleted\n"];
}

#pragma mark dealloc
//替换[super dealloc];
+ (void)replaceDeallocForString:(NSMutableString *)str_origin
{
    [self replaceString:str_origin withPattern:@"\\[(\\s)*\\w+\\s+dealloc(\\s)*\\](\\s)*;\n" templateString:@"//deallo_c deleted\n"];
}

#pragma mark retain
//[ xx retain ] ;,
//                              1   2    3     4     5        6     7    8
NSString* PATTERN_RETAIN = @"(\\[)(\\s*)(\\w+)(\\s+)(retain)(\\s*)(\\])(\\s*;|,)";
NSString* TEMPLATE_RETAIN = @"$2$3$4$6$8";
////[ xx retain ];,
////                              1   2    3     4     5        6     7    8
NSString* PATTERN_RETAIN_2 = @"(\\[)(\\s)*(\\w+)(\\s)+(retain)(\\s*)(\\])(\\s*\\w+)";
NSString* TEMPLATE_RETAIN_2 = @"$2$3$4$6$8";
//] retain ]
//                              1       2    3     4     5
NSString* PATTERN_RETAIN_3 = @"(\\])(\\s*)(retain)(\\s*)(\\])";
NSString* TEMPLATE_RETAIN_3 = @"$1";

//替换[xx retain]
+ (void)replaceRetainForString:(NSMutableString *)str_origin
{
    [self replaceString:str_origin withPattern:PATTERN_RETAIN templateString:TEMPLATE_RETAIN];
    [self replaceString:str_origin withPattern:PATTERN_RETAIN_2 templateString:TEMPLATE_RETAIN_2];
    [self replaceString:str_origin withPattern:PATTERN_RETAIN_3 templateString:TEMPLATE_RETAIN_3];
}

#pragma mark autorelease
//[ [ [ xx xx] xx ] autorelease ]
//                                   1    2    3     4     5   6     7    8     9      10    11     12
NSString* PATTERN_AUTORELEASE = @"(\\[)(\\s*)(\\[)(\\s*)(\\[)(\\s*)(\\w+)(\\s*)(\\w+)(\\s*)(\\])(\\s*)"\
    //13    //14   //15//16 //17          //18   //19
    @"(\\w+)(\\s*)(\\])(\\s*)(autorelease)(\\s*)(\\])";
NSString* TEMPLATE_AUTORELEASE = @"$2$3$4$5$6$7$8$9$10$11$12$13$14$15$16$18";
//[ [ xx xx ] autorelease]
//                                      1   2   3   4       5   6       7   8       9
NSString* PATTERN_AUTORELEASE_2 = @"(\\[)(\\s*)(\\[)(\\s*)(\\w+)(\\s+)(\\w+)(\\s*)(\\])"\
//10    //11           //12//13
@"(\\s*)(autorelease)(\\s*)(\\])";
NSString* TEMPLATE_AUTORELEASE_2 = @"$2$3$4$5$6$7$8$9";
//[ xx autorelease]
//                                  1           2       3
NSString* PATTERN_AUTORELEASE_3 = @"(\\[\\s*)(\\w+\\s+)(autorelease\\s*\\])";
NSString* TEMPLATE_AUTORELEASE_3 = @"$2";
// autorelease]
NSString* PATTERN_AUTORELEASE_4 = @"autorelease]";
NSString* TEMPLATE_AUTORELEASE_4 = @"";
//[[[->[[
NSString* PATTERN_AUTORELEASE_5 = @"\\[\\[\\[";
NSString* TEMPLATE_AUTORELEASE_5 = @"\\[\\[";

//替换[xx autorlease]
+ (void)replaceAutoreleaseForString:(NSMutableString *)str_origin
{
    [self replaceString:str_origin withPattern:PATTERN_AUTORELEASE templateString:TEMPLATE_AUTORELEASE];
    [self replaceString:str_origin withPattern:PATTERN_AUTORELEASE_2 templateString:TEMPLATE_AUTORELEASE_2];
    [self replaceString:str_origin withPattern:PATTERN_AUTORELEASE_3 templateString:TEMPLATE_AUTORELEASE_3];
    [self replaceString:str_origin withPattern:PATTERN_AUTORELEASE_4 templateString:TEMPLATE_AUTORELEASE_4];
    [self replaceString:str_origin withPattern:PATTERN_AUTORELEASE_5 templateString:TEMPLATE_AUTORELEASE_5];
}

#pragma mark retain->strong
//                                      1   2    3       4     5
NSString* PATTERN_RETAINPROPERTY = @"(\\(|,)(\\s*)(retain)(\\s*)(,|\\))";
NSString* TEMPLATE_RETAINPROPERTY = @"$1$2strong$4$5";
//                                      1   2       3   4       5
//NSString* PATTERN_RETAINPROPERTY_2 = @"(,)(\\s*)(retain)(\\s*)(,|\\))";
//NSString* TEMPLATE_RETAINPROPERTY_2 = @"$1$2strong$4$5";
//                                      1       2       3   4       5
NSString* PATTERN_RETAINPROPERTY_3 = @"(\\w+)(\\s+)(retain)(\\s*)(,|\\))";
NSString* TEMPLATE_RETAINPROPERTY_3 = @"$1$2strong$4$5";

//替换(retain, xx) (xx, retain , xx) -> (strong)
+ (void)replaceRetainToStrongForString:(NSMutableString*)str_origin
{
    [self replaceString:str_origin withPattern:PATTERN_RETAINPROPERTY templateString:TEMPLATE_RETAINPROPERTY];
    [self replaceString:str_origin withPattern:PATTERN_RETAINPROPERTY_3 templateString:TEMPLATE_RETAINPROPERTY_3];
}

#pragma mark assign->weak
//替换(assign, xx) (xx, assign) (assign)
//(, assign ) ( xx * xx) | ( id ) | ( IBOutlet )
//                                      1   2       3       4       5   6
NSString* PATTERN_ASSIGNPROPERTY = @"(\\(|,)(\\s*)(assign)(\\s*)(\\))((\\s*\\w+\\s*\\*\\s*\\w+)|(\\s*id\\s+)|(\\s*id\\s*<)|(\\s*IBOutlet\\s+))";
NSString* TEMPLATE_ASSIGNPROPERTY = @"$1$2weak$4$5$6";
//                                      1       2       3       4                  5   6 后面的xx* xx
NSString* PATTERN_ASSIGNPROPERTY_2 = @"(\\(|,)(\\s*)(assign)(\\s*,\\s*\\w+\\s*)(\\))((\\s*\\w+\\s*\\*\\s*\\w+)|(\\s*id\\s+)|(\\s*id\\s*<)|(\\s*IBOutlet\\s+))";
NSString* TEMPLATE_ASSIGNPROPERTY_2 = @"$1$2weak$4$5$6";
#warning 2和3其实是类似的，只是我还不知道正则是如何嵌套的,嵌套后$1$2这种方式好像会出现紊乱
//                                      1       2       3       4                   5               6   7后面的xx* xx
NSString* PATTERN_ASSIGNPROPERTY_3 = @"(\\(|,)(\\s*)(assign)(\\s*,\\s*\\w+\\s*)(\\s*,\\s*\\w+\\s*)(\\))((\\s*\\w+\\s*\\*\\s*\\w+)|(\\s*id\\s+)|(\\s*id\\s*<)|(\\s*IBOutlet\\s+))";
NSString* TEMPLATE_ASSIGNPROPERTY_3 = @"$1$2weak$4$5$6$7";

+ (void)replaceAssignToWeakForString:(NSMutableString*)str_origin
{
    [self replaceString:str_origin withPattern:PATTERN_ASSIGNPROPERTY templateString:TEMPLATE_ASSIGNPROPERTY];
    [self replaceString:str_origin withPattern:PATTERN_ASSIGNPROPERTY_2 templateString:TEMPLATE_ASSIGNPROPERTY_2];
    [self replaceString:str_origin withPattern:PATTERN_ASSIGNPROPERTY_3 templateString:TEMPLATE_ASSIGNPROPERTY_3];
}

#pragma mark - 合的接口
//封装，对外接口，整体
+ (void)replaceMRCToARCForString:(NSMutableString*)str_origin option:(RTARCProcessType)type
{
    if (![str_origin isKindOfClass:[NSMutableString class]])
    {
        assert(0);
    }
    if (type & RTProcessRelease)
    {
        [self replaceReleaseForString:str_origin];
    }
    if (type & RTProcessDealloc)
    {
        [self replaceDeallocForString:str_origin];
    }
    if (type & RTProcessRetain)
    {
        [self replaceRetainForString:str_origin];
    }
    if (type & RTProcessRetainProperty)
    {
        [self replaceRetainToStrongForString:str_origin];
    }
    if (type & RTProcessAssignProperty)
    {
        [self replaceAssignToWeakForString:str_origin];
    }
    if (type & RTProcessAutorelease)
    {
        [self replaceAutoreleaseForString:str_origin];
    }
}
#pragma mark test
+ (void)test
{
    
//    //(, assign ) ( xx * xx) | ( id ) | ( IBOutlet )
//    //                                      1   2       3       4       5   6
//    NSString* PATTERN_ASSIGNPROPERTY = @"(\\(|,)(\\s*)(assign)(\\s*)(\\))((\\s*\\w+\\s*\\*\\s*\\w+)|(\\s*id\\s+)|(\\s*id\\s*<)(\\s*IBOutlet\\s+))";
//    NSString* TEMPLATE_ASSIGNPROPERTY = @"$1$2weak$4$5$6";
    
    NSString* pattern = PATTERN_ASSIGNPROPERTY;
    NSString* str_origin = @"(assign) id <xx>";
    NSString* templete = TEMPLATE_ASSIGNPROPERTY;

    NSError* error = nil;
    NSRegularExpression* expression = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange range;
    range.location = 0;
    range.length = str_origin.length;
    
    NSLog(@"origin is %@", str_origin);
//    NSArray* arr_result = [expression matchesInString:str_origin options:NSMatchingReportProgress range:range];
//    [arr_result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSTextCheckingResult* result = obj;
//        NSLog(@"%@ : %@", NSStringFromRange(result.range), [str_origin substringWithRange:result.range]);
//    }];
    
    NSString* str_new = [expression stringByReplacingMatchesInString:str_origin options:NSMatchingReportProgress range:range withTemplate:templete];
    NSLog(@"end %@", str_new);
}
@end
