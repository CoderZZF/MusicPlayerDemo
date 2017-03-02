//
//  XMGPlayingViewController.m
//  MusicPlayer
//
//  Created by zhangzhifu on 2017/3/2.
//  Copyright © 2017年 seemygo. All rights reserved.
//

#import "XMGPlayingViewController.h"
#import "Masonry.h"
#import "XMGMusicTool.h"
#import "XMGMusic.h"
#import "XMGAudioTool.h"

#define XMGColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface XMGPlayingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@end

@implementation XMGPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 添加毛玻璃效果
    [self setupBlurView];
    
    // 2. 设置滑块图片
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
    // 3. 展示界面信息
    [self startPlayingMusic];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 设置iconView的圆角
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderWidth = 8.0;
    self.iconView.layer.borderColor = XMGColor(36, 36, 36).CGColor;
}

- (void)setupBlurView {
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleBlack];
    [self.albumView addSubview:toolBar];
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.albumView.mas_top);
        make.bottom.equalTo(self.albumView.mas_bottom);
        make.left.equalTo(self.albumView.mas_left);
        make.right.equalTo(self.albumView.mas_right);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - 开始播放音乐
- (void)startPlayingMusic {
    // 1. 取出当前播放的歌曲
    XMGMusic *playingMusic = [XMGMusicTool playingMusic];
    
    // 2. 设置界面信息
    self.albumView.image = [UIImage imageNamed:playingMusic.icon];
    self.iconView.image = [UIImage imageNamed:playingMusic.icon];
    self.songLabel.text = playingMusic.name;
    self.singerLabel.text = playingMusic.singer;
    
    // 3. 开始播放歌曲
    AVAudioPlayer *currentPlayer = [XMGAudioTool playMusicWithMusicName:playingMusic.filename];
    self.totalTimeLabel.text = [self stringWithTime:currentPlayer.duration];
    self.currentTimeLabel.text = [self stringWithTime:currentPlayer.currentTime];
}

- (NSString *)stringWithTime:(NSTimeInterval)time {
    NSInteger min = time / 60;
    NSInteger sec = (NSInteger)time % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
}
@end
