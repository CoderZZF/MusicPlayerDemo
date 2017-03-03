//
//  XMGLrcView.h
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGLrcView : UIScrollView
/** 歌词 */
@property (nonatomic, copy) NSString *lrcName;

/** 时间 */
@property (nonatomic, assign) NSTimeInterval currentTime;

@end
