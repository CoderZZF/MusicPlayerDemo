//
//  XMGLrcLine.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGLrcLine.h"

@implementation XMGLrcLine

- (instancetype)initWithLrclineString:(NSString *)lrclineString {
    if (self = [super init]) {
        // [00:32.67]变成蜡烛燃烧自己
        NSArray *lrcArray = [lrclineString componentsSeparatedByString:@"]"];
        self.text = lrcArray[1];
        NSString *timeString = lrcArray[0];
        self.time = [self timeStringWithString:[timeString substringFromIndex:1]];
    }
    return self;
}


+ (instancetype)lrcLineWithLrclineString:(NSString *)lrclineString {
    return [[self alloc] initWithLrclineString:lrclineString];
}


#pragma mark - 私有方法
- (NSTimeInterval)timeStringWithString:(NSString *)timeString {
//    00:32.67
    NSInteger min = [[timeString componentsSeparatedByString:@":"][0] integerValue];
    NSInteger sec = [[timeString substringWithRange:NSMakeRange(3, 2)] integerValue];
    NSInteger msec = [[timeString componentsSeparatedByString:@"."][1] integerValue];
    
    return min * 60 + sec + msec * 0.01;
}
@end
