//
//  PKHeadLandingView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/15.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKHeadLandingView.h"
#import "Masonry.h"

@implementation PKHeadLandingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.returnBtn];
        [self addSubview:self.registerBtn];
        [self addSubview:self.logoView];
        self.backgroundColor = [UIColor whiteColor];
        [self addAutoLayout];
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.top.equalTo(weakSelf.mas_top).offset(30);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.top.equalTo(weakSelf.mas_top).offset(30);
        make.size.equalTo(CGSizeMake(40, 20));
    }];
    
    [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(20);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
}

- (UIButton*)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_returnBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    }
    return _returnBtn;
}

- (UIButton*)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_registerBtn setTitle:@"注册" forState:(UIControlStateNormal)];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_registerBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    }
    return _registerBtn;
}

- (UIImageView*)logoView {
    if (!_logoView) {
        _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"片刻LOGO"]];
    }
    return _logoView;
}

@end











