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
#import "NSString+XMGTimeExtension.h"
#import "CALayer+PauseAimate.h"
#import "XMGLrcView.h"

#define XMGColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface XMGPlayingViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet XMGLrcView *lrcView;
@property (weak, nonatomic) IBOutlet UILabel *lrcLabel;

/** 定时器 */
@property (nonatomic, strong) NSTimer *progressTimer;
/** 播放器 */
@property (nonatomic, weak) AVAudioPlayer *currentPlayer;

#pragma mark- slider的事件处理
- (IBAction)startSlide:(id)sender;
- (IBAction)sliderValueChange:(id)sender;
- (IBAction)endSlide:(id)sender;
- (IBAction)sliderClick:(UITapGestureRecognizer *)sender;

#pragma mark- 歌曲控制的事件处理
- (IBAction)playOrPause;
- (IBAction)previous;
- (IBAction)next;
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
    
    // 4. 设置lrcView的contentSize
    self.lrcView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
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
    self.totalTimeLabel.text = [NSString stringWithTime:currentPlayer.duration];
    self.currentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.currentPlayer = currentPlayer;
    self.playOrPauseButton.selected = self.currentPlayer.isPlaying;
    
    // 4. 开始播放动画
    [self startIconAnimate];
    
    // 5. 添加定时器用户更新进度界面
    [self removeProgressTimer];
    [self addProgressTimer];
}

- (void)startIconAnimate {
    // 1. 创建基本动画
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 2. 设置基本动画属性
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI *2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration = 30;
    
    // 3. 添加动画到图层上
    [self.iconView.layer addAnimation:rotateAnim forKey:nil];
}


#pragma mark - 对定时器的操作
- (void)addProgressTimer {
    [self updateProgressInfo];
    
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}


- (void)removeProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

#pragma mark - 更新进度界面
- (void)updateProgressInfo {
    // 1. 设置当前的播放时间
    self.currentTimeLabel.text = [NSString stringWithTime:self.currentPlayer.currentTime];
    
    // 2. 更新滑块的位置
    self.progressSlider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
}



#pragma mark- slider的事件处理
- (IBAction)startSlide:(id)sender {
    [self removeProgressTimer];
}

- (IBAction)sliderValueChange:(id)sender {
    // 设置当前播放时间的label
    self.currentTimeLabel.text = [NSString stringWithTime:self.currentPlayer.duration * self.progressSlider.value];
}

- (IBAction)endSlide:(id)sender {
    // 1. 设置歌曲的播放时间
    self.currentPlayer.currentTime = self.progressSlider.value * self.currentPlayer.duration;
    
    // 2. 添加定时器
    [self addProgressTimer];
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    // 1. 获取点击的位置
    CGPoint point = [sender locationInView:sender.view];
    
    // 2. 获取点击的在slider长度中占据的比例
    CGFloat ratio = point.x / self.progressSlider.bounds.size.width;
    
    // 3. 改变歌曲播放的时间
    self.currentPlayer.currentTime = ratio * self.currentPlayer.duration;
    
    // 4. 更改界面信息
    [self updateProgressInfo];
}

#pragma mark- 歌曲控制的事件处理
- (IBAction)playOrPause {
    self.playOrPauseButton.selected = !self.playOrPauseButton.selected;
    
    if (self.currentPlayer.playing) {
        [self.currentPlayer pause];
        
        [self removeProgressTimer];
        
        // 暂停动画
        [self.iconView.layer pauseAnimate];
    } else {
        [self.currentPlayer play];
        
        [self addProgressTimer];
        
        // 恢复动画
        [self.iconView.layer resumeAnimate];
    }
}

- (IBAction)previous {
    // 1. 获取上一首歌曲
    XMGMusic *previousMusic = [XMGMusicTool previousMusic];
    
    // 2. 播放上一首歌曲
    [self playingMusicWithMusic:previousMusic];
}

- (IBAction)next {
    // 1. 获取下一首歌曲
    XMGMusic *nextMusic = [XMGMusicTool nextMusic];
    
    // 2. 播放下一首歌曲
    [self playingMusicWithMusic:nextMusic];
}


- (void)playingMusicWithMusic:(XMGMusic *)Music {
    // 1. 停止当前歌曲
    XMGMusic *playingMusic = [XMGMusicTool playingMusic];
    [XMGAudioTool stopMusicWithMusicName:playingMusic.filename];
    
    // 2. 播放歌曲
    [XMGAudioTool playMusicWithMusicName:Music.filename];
    
    // 3. 将工具类中的当前歌曲切换成播放的歌曲
    [XMGMusicTool setPlayingMusic:Music];
    
    // 4. 改变界面信息
    [self startPlayingMusic];
}

#pragma mark - 实现UIScrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1. 获取滑动的多少
    CGPoint point = scrollView.contentOffset;
    
    // 2. 计算滑动比例
    CGFloat ratio = 1 - point.x / scrollView.bounds.size.width;
    
    // 3. 设置iconView和歌词label的透明度
    self.iconView.alpha = ratio;
    self.lrcLabel.alpha = ratio;
}
@end
