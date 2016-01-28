//
//  PkRadioInfoHeaderView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PkRadioInfoHeaderView.h"
#import "Masonry.h"

@implementation PkRadioInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.headImage];
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.countImage];
        [self addSubview:self.countLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.lineLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    WS(weakSelf);
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(150);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImage.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.equalTo(CGSizeMake(30, 30));
    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(5);
        make.size.equalTo(CGSizeMake(150, 16));
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.size.equalTo(CGSizeMake(50, 11));
    }];
    
    [_countImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.right.equalTo(weakSelf.countLabel.mas_left);
        make.size.equalTo(CGSizeMake(8, 13));
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImage.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.height.equalTo(20);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(1);
    }];
    
}

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
    }
    return _headImage;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.layer.cornerRadius = 15.0;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = RGB(63, 110, 116);
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _nameLabel;
}

- (UIImageView *)countImage {
    if (!_countImage) {
        _countImage = [[UIImageView alloc] init];
        _countImage.image = [UIImage imageNamed:@"收听量"];
    }
    return _countImage;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor grayColor];
        _countLabel.font = [UIFont systemFontOfSize:10.0];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel;
}

@end












