//
//  PKThirdLandingView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/15.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKThirdLandingView.h"
#import "Masonry.h"

@implementation PKThirdLandingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.xianView];
        [self addSubview:self.headLabel];
        [self addSubview:self.weiBoBtn];
        [self addSubview:self.renRenBtn];
        [self addSubview:self.douBanBtn];
        [self addSubview:self.QQBtn];
        self.backgroundColor = [UIColor whiteColor];
        [self addAutoLayout];
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_xianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(40);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
        make.height.equalTo(1);
        make.top.equalTo(weakSelf.mas_top).offset(25);
    }];
    
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.xianView.mas_centerY);
        make.size.equalTo(CGSizeMake(90, 10));
    }];
    CGFloat width = (VIEW_WIDTH-120)/5;
    [_weiBoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(width);
        make.top.equalTo(weakSelf.xianView.mas_bottom).offset(30);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_renRenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.weiBoBtn.mas_right).offset(width);
        make.centerY.equalTo(weakSelf.weiBoBtn.mas_centerY);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_douBanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.renRenBtn.mas_right).offset(width);
        make.centerY.equalTo(weakSelf.renRenBtn.mas_centerY);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.douBanBtn.mas_right).offset(width);
        make.centerY.equalTo(weakSelf.douBanBtn.mas_centerY);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
}

- (UILabel*)headLabel {
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.text = @"合作伙伴登陆片刻";
        _headLabel.backgroundColor = [UIColor whiteColor];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font = [UIFont systemFontOfSize:10];
    }
    return _headLabel;
}

- (UIImageView*)xianView {
    if (!_xianView) {
        _xianView = [[UIImageView alloc] init];
        _xianView.backgroundColor = [UIColor blackColor];
    }
    return _xianView;
}

- (UIButton*)weiBoBtn {
    if (!_weiBoBtn) {
        _weiBoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_weiBoBtn setBackgroundImage:[UIImage imageNamed:@"新浪"] forState:(UIControlStateNormal)];
//        _weiBoBtn.layer.cornerRadius = 
    }
    return _weiBoBtn;
}

- (UIButton*)renRenBtn {
    if (!_renRenBtn) {
        _renRenBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_renRenBtn setBackgroundImage:[UIImage imageNamed:@"人人"] forState:(UIControlStateNormal)];
    }
    return _renRenBtn;
}

- (UIButton*)douBanBtn {
    if (!_douBanBtn) {
        _douBanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_douBanBtn setBackgroundImage:[UIImage imageNamed:@"豆瓣"] forState:(UIControlStateNormal)];
    }
    return _douBanBtn;
}

- (UIButton*)QQBtn {
    if (!_QQBtn) {
        _QQBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_QQBtn setBackgroundImage:[UIImage imageNamed:@"QQ"] forState:(UIControlStateNormal)];
    }
    return _QQBtn;
}

@end



















