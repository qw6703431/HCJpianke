//
//  PKMiddleLandingView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/15.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKMiddleLandingView.h"
#import "Masonry.h"

@implementation PKMiddleLandingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lineLabel1];
        [self addSubview:self.lineLabel2];
        [self addSubview:self.tostLabel1];
        [self addSubview:self.tostLabel2];
        [self addSubview:self.emailText];
        [self addSubview:self.passwordText];
        [self addSubview:self.landingBtn];
        self.backgroundColor = [UIColor whiteColor];
        [self addAutoLayout];
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(55);
        make.left.equalTo(weakSelf.mas_left).offset(40);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
        make.height.equalTo(1);
    }];
    
    [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel1.mas_bottom).offset(55);
        make.left.equalTo(weakSelf.mas_left).offset(40);
        make.right.equalTo(weakSelf.mas_right).offset(-40);
        make.height.equalTo(1);
    }];
    
    [_tostLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineLabel1.mas_left);
        make.size.equalTo(CGSizeMake(35, 13));
        make.bottom.equalTo(weakSelf.lineLabel1.mas_top).offset(-10);
    }];
    
    [_tostLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.lineLabel2.mas_left);
        make.size.equalTo(CGSizeMake(35, 13));
        make.bottom.equalTo(weakSelf.lineLabel2.mas_top).offset(-10);
    }];
    
    [_emailText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tostLabel1.mas_right).offset(5);
        make.right.equalTo(weakSelf.lineLabel1.mas_right);
        make.height.equalTo(33);
        make.bottom.equalTo(weakSelf.lineLabel1.mas_top);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.tostLabel2.mas_right).offset(5);
        make.right.equalTo(weakSelf.lineLabel2.mas_right);
        make.height.equalTo(33);
        make.bottom.equalTo(weakSelf.lineLabel2.mas_top);
    }];
    
    [_landingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(30);
        make.left.equalTo(weakSelf.lineLabel1.mas_left);
        make.right.equalTo(weakSelf.lineLabel1.mas_right);
        make.top.equalTo(weakSelf.lineLabel2.mas_bottom).offset(25);
    }];
    
}


- (UILabel*)lineLabel1 {
    if (!_lineLabel1) {
        _lineLabel1 = [[UILabel alloc] init];
        _lineLabel1.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel1;
}

- (UILabel*)lineLabel2 {
    if (!_lineLabel2) {
        _lineLabel2 = [[UILabel alloc] init];
        _lineLabel2.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel2;
}

- (UILabel*)tostLabel1 {
    if (!_tostLabel1) {
        _tostLabel1 = [[UILabel alloc] init];
        _tostLabel1.text = @"邮箱:";
        _tostLabel1.textAlignment = NSTextAlignmentLeft;
        _tostLabel1.font = [UIFont systemFontOfSize:13.0];
    }
    return _tostLabel1;
}

- (UILabel*)tostLabel2 {
    if (!_tostLabel2) {
        _tostLabel2 = [[UILabel alloc] init];
        _tostLabel2.text = @"密码:";
        _tostLabel2.textAlignment = NSTextAlignmentLeft;
        _tostLabel2.font = [UIFont systemFontOfSize:13.0];
    }
    return _tostLabel2;
}

- (UITextField *)emailText {
    if (!_emailText) {
        _emailText = [[UITextField alloc] init];
        _emailText.textColor = [UIColor blackColor];
        _emailText.delegate = self;
        // 设置边框
        _emailText.borderStyle = UITextBorderStyleNone;
    }
    return _emailText;
}

- (UITextField *)passwordText {
    if (!_passwordText) {
        _passwordText = [[UITextField alloc] init];
        // 以密文显示
        _passwordText.secureTextEntry = YES;
        _passwordText.delegate = self;
        // 设置边框
        _passwordText.borderStyle = UITextBorderStyleNone;
    }
    return _passwordText;
}

- (UIButton*)landingBtn {
    if (!_landingBtn) {
        _landingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_landingBtn setBackgroundColor:RGB(119, 182, 69)];
        [_landingBtn setTitle:@"登陆" forState:(UIControlStateNormal)];
    }
    return _landingBtn;
}

@end















