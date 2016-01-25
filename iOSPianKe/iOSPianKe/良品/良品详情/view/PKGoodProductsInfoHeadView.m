//
//  PKGoodProductsInfoHeadView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsInfoHeadView.h"
#import "Masonry.h"

@interface PKGoodProductsInfoHeadView ()

//这三个控件是写死的不需要与外界交互
// from: 的label
@property (strong, nonatomic) UILabel* fromLabel;
// from: 后面的Btn
@property (strong, nonatomic) UIButton* fromBtn;
// More·小组 → 的Btn
@property (strong, nonatomic) UIButton* MoreBtn;

@end

@implementation PKGoodProductsInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.fromLabel];
        [self addSubview:self.fromBtn];
        [self addSubview:self.MoreBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        
        [self addAutoLayout];
    }
    return self;
}
// 自适应
- (void)addAutoLayout {
    WS(weakSelf);
    [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(25);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.size.equalTo(CGSizeMake(30, 15));
    }];
    
    [_fromBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.fromLabel.mas_right);
        make.centerY.equalTo(weakSelf.fromLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH/2-100, 25));
    }];
    
    [_MoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.fromLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(65, 15));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fromBtn.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.fromLabel.mas_left);
        make.size.equalTo(CGSizeMake(VIEW_WIDTH-40, 25));
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.titleLabel.mas_left);
        make.size.equalTo(CGSizeMake(50, 50));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.height.equalTo(15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(5);
        make.right.equalTo(weakSelf.timeLabel.mas_left).offset(-5);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.MoreBtn.mas_right);
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.size.equalTo(CGSizeMake(90, 15));
    }];
    
}

- (UILabel *)fromLabel {
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.text = @"from:";
        _fromLabel.font = [UIFont systemFontOfSize:10.0];
        _fromLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _fromLabel;
}

- (UIButton *)fromBtn {
    if (!_fromBtn) {
        _fromBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_fromBtn setTitle:@"片刻生活馆" forState:(UIControlStateNormal)];
        [_fromBtn setTitleColor:RGB(119, 182, 69) forState:UIControlStateNormal];
        _fromBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    }
    return _fromBtn;
}

- (UIButton *)MoreBtn {
    if (!_MoreBtn) {
        _MoreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_MoreBtn setTitle:@"More·小组" forState:(UIControlStateNormal)];
        _MoreBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [_MoreBtn setTitleColor:RGB(119, 182, 69) forState:(UIControlStateNormal)];
        // 按钮文字偏移量
        [_MoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        UIImageView* btnView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 2.5, 10, 10)];
        btnView.image = [UIImage imageNamed:@"绿色箭头"];
        [_MoreBtn addSubview:btnView];
    }
    return _MoreBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:22.0];
    }
    return _titleLabel;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.layer.cornerRadius = 25.0;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:10.0];
    }
    return _timeLabel;
}

@end






















