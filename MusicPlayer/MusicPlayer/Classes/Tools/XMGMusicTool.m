//
//  XMGMusicTool.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGMusicTool.h"
#import "XMGMusic.h"
#import "MJExtension.h"

@implementation XMGMusicTool

static NSArray *_musics;
static XMGMusic *_playingMusic;

+ (void)initialize {
    _musics = [XMGMusic objectArrayWithFilename:@"Musics.plist"];
    
    if (_playingMusic == nil) {
        _playingMusic = _musics[1];
    }
}

+ (NSArray *)musics {
    return _musics;
}

+ (XMGMusic *)playingMusic {
    return _playingMusic;
}

+ (void)setPlayingMusic:(XMGMusic *)playingMusic {
    _playingMusic = playingMusic;
}

+ (XMGMusic *)nextMusic {
    // 1. 拿到当前播放歌曲的索引
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2. 取出下一首歌
    NSInteger nextIndex = ++currentIndex;
    if (nextIndex >= _musics.count) {
        nextIndex = 0;
    }
    XMGMusic *nextMusic = _musics[nextIndex];
    
    return nextMusic;
}

+ (XMGMusic *)previousMusic {
    // 1. 拿到当前播放歌曲的索引
    NSInteger currentIndex = [_musics indexOfObject:_playingMusic];
    
    // 2. 取出上一首歌
    NSInteger previousIndex = --currentIndex;
    if (previousIndex < 0) {
        previousIndex = _musics.count -1;
    }
    XMGMusic *previousMusic = _musics[previousIndex];
    
    return previousMusic;
}
@end
