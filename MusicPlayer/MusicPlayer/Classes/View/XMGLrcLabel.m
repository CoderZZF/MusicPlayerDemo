
//
//  XMGLrcLabel.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/4.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGLrcLabel.h"

@implementation XMGLrcLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 1. 获取需要画的区域
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    // 2. 设置颜色
    [[UIColor redColor] set];
    
    // 3. 填充区域
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self setNeedsDisplay];
}

@end
