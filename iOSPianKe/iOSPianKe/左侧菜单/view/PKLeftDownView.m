//
//  PKLeftDownView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLeftDownView.h"
#import "Masonry.h"

@implementation PKLeftDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
        [self addSubview:self.musicImage];
        [self addSubview:self.musicName];
        [self addSubview:self.musicFrom];
        [self addSubview:self.playBtn];
        // 绑定事件
        [self.playBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addAutoLayout];
    }
    return self;
}
// 按钮事件
- (void)btnPress:(id)sender {
    
    UIButton* btn = (UIButton*)sender;
    // 每次触发事件调用都切换按钮的选中状态和普通状态
    btn.selected = !btn.selected;
    
    
}

- (UIImageView*)musicImage {
    if (!_musicImage) {
        _musicImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"音乐"]];
    }
    return _musicImage;
}

- (UILabel*)musicName {
    if (!_musicName) {
        _musicName = [[UILabel alloc] init];
        _musicName.textColor = [UIColor whiteColor];
        _musicName.textAlignment = NSTextAlignmentLeft;
        _musicName.font = [UIFont systemFontOfSize:15.0];
        _musicName.text = @"印第安老斑鸠";
    }
    return _musicName;
}

- (UILabel*)musicFrom {
    if (!_musicFrom) {
        _musicFrom = [[UILabel alloc] init];
        _musicFrom.textColor = [UIColor whiteColor];
        _musicFrom.textAlignment = NSTextAlignmentLeft;
        _musicFrom.font = [UIFont systemFontOfSize:10.0];
        _musicFrom.text = @"周杰伦";
    }
    return _musicFrom;
}

- (UIButton*)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _playBtn.selected = NO;
        // 设定普通状态下按钮的背景图片
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"播放"] forState:(UIControlStateNormal)];
        // 设定选中状态下按钮的背景图片
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateSelected)];
        
    }
    return _playBtn;
}

- (UIButton*)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.backgroundColor = RGB(28, 28, 28);
    }
    return _backBtn;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, -45));
    }];
    
    [_musicImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(5);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    
    [_musicName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.musicImage.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(-8);
        make.right.equalTo(weakSelf.playBtn.mas_left).offset(-15);
        make.height.equalTo(16);
    }];
    
    [_musicFrom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.musicImage.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(10);
        make.right.equalTo(weakSelf.playBtn.mas_left).offset(-15);
        make.height.equalTo(11);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
}

@end
















