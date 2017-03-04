//
//  XMGLrcCell.h
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGLrcLabel;

@interface XMGLrcCell : UITableViewCell

@property (nonatomic, weak, readonly) XMGLrcLabel *lrcLabel;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;

@end
