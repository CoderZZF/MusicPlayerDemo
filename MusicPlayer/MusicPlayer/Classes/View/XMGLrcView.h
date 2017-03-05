//
//  XMGLrcView.h
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGLrcLabel;

@interface XMGLrcView : UIScrollView
/** 歌词 */
@property (nonatomic, copy) NSString *lrcName;

/** 时间 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/** 传入歌词的label */
@property (nonatomic, weak) XMGLrcLabel *lrcLabel;

/** 歌曲的总时长 */
@property (nonatomic, assign) NSTimeInterval duration;

@end
