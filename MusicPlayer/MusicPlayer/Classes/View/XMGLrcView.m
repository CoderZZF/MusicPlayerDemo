//
//  XMGLrcView.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/3.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGLrcView.h"
#import "Masonry.h"
#import "XMGLrcCell.h"
#import "XMGLrcTool.h"
#import "XMGLrcLine.h"

@interface XMGLrcView () <UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
/** 歌词的数组 */
@property (nonatomic, strong) NSArray *lrcList;
@end

@implementation XMGLrcView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupTableView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTableView];
    }
    
    return self;
}


- (void)setupTableView {
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] init];    
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 40;
    [self addSubview:tableView];
    tableView.dataSource = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView = tableView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 布局
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(self.mas_height);
        make.left.equalTo(self.mas_left).offset(self.bounds.size.width);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.mas_width);
    }];
    
    // 设置tableView额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
}


#pragma mark - 实现tableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lrcList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 创建cell
    XMGLrcCell *cell = [XMGLrcCell lrcCellWithTableView:tableView];
    
    // 2. 给cell设置数据
    // 2.1 取出模型
    XMGLrcLine *lrcLine = self.lrcList[indexPath.row];
    
    // 2.2 给cell设置数据
    cell.textLabel.text = lrcLine.text;
    
    return cell;
}


#pragma mark - 重写setLrcName方法
- (void)setLrcName:(NSString *)lrcName {
    // 1. 保存歌词名称
    _lrcName = lrcName;
    
    // 2. 解析歌词
    self.lrcList = [XMGLrcTool lrcToolWithLrcName:lrcName];
    
    
    // 3. 刷新表格
    [self.tableView reloadData];
}
@end
