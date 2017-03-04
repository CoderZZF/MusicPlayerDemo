//
//  XMGLrcCell.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGLrcCell.h"
#import "XMGLrcLabel.h"
#import "Masonry.h"

@implementation XMGLrcCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        XMGLrcLabel *lrcLabel = [[XMGLrcLabel alloc] init];
        //        cell.textLabel.textColor = [UIColor whiteColor];
        lrcLabel.font = [UIFont systemFontOfSize:14];
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        _lrcLabel = lrcLabel;
        [self.contentView addSubview:lrcLabel];
        lrcLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"lrcCell";
    XMGLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XMGLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
