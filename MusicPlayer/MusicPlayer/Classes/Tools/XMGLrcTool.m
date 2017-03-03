//
//  XMGLrcTool.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGLrcTool.h"
#import "XMGLrcLine.h"

@implementation XMGLrcTool

+ (NSArray *)lrcToolWithLrcName:(NSString *)lrcName {
    // 1. 拿到歌词文件的路径
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:lrcName ofType:nil];
    
    // 2. 读取歌词
    NSString *lrcString = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    
    // 3. 拿到歌词数组
    NSArray *lrcArray = [lrcString componentsSeparatedByString:@"\n"];
    
    // 4. 遍历每一句歌词,转成模型
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *lrcLineString in lrcArray) {
        // 拿到每一句歌词
        /*
         [ti:心碎了无痕]
         [ar:张学友]
         [al:]
         */
        
        // 过滤不需要的歌词的行
        if ([lrcLineString hasPrefix:@"[ti:"] || [lrcLineString hasPrefix:@"[ar:"] || [lrcLineString hasPrefix:@"[al:"] || ![lrcLineString hasPrefix:@"["]) {
            continue;
        }
        
        // 将歌词转成模型
        XMGLrcLine *lrcLine = [XMGLrcLine lrcLineWithLrclineString:lrcLineString];
        [tempArray addObject:lrcLine];
    }
    
    return tempArray;
}

@end
