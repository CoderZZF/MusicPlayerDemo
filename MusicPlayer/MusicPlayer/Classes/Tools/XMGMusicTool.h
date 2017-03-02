//
//  XMGMusicTool.h
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGMusic;

@interface XMGMusicTool : NSObject

+ (NSArray *)musics;

+ (XMGMusic *)playingMusic;

+ (void)setPlayingMusic:(XMGMusic *)playingMusic;

+ (XMGMusic *)nextMusic;

+ (XMGMusic *)previousMusic;
@end
