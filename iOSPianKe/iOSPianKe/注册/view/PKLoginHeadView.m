//
//  PKLoginHeadView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/18.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLoginHeadView.h"
#import "Masonry.h"

@implementation PKLoginHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.returnBtn];
        [self addSubview:self.iconImageBtn];
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
    
    [_iconImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.equalTo(CGSizeMake(80, 80));
    }];
    
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_returnBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    }
    return _returnBtn;
}

- (UIButton *)iconImageBtn {
    if (!_iconImageBtn) {
        _iconImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconImageBtn setImage:[UIImage imageNamed:@"上传头像"] forState:UIControlStateNormal];
//        _iconImageBtn.layer.cornerRadius = 25.0;
//        _iconImageBtn.layer.masksToBounds = YES;
    }
    return _iconImageBtn;
}

@end




















