//
//  PKGoodProductsTableViewCell.m
//  iOSPianKe
//
//  Created by ma c on 16/1/21.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsTableViewCell.h"
#import "Masonry.h"

@implementation PKGoodProductsTableViewCell

// 代码实现自定义Cell,就是重写这个方法。
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.contentImage];
        [self addSubview:self.contentLabel];
        [self addSubview:self.bugBtn];
        [self addSubview:self.lineLabel];
        
        [self addAutoLayout];
    }
    return self;
}
// 自适应方法
- (void)addAutoLayout {
    WS(weakSelf);
    [_contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.bottom.equalTo(weakSelf.contentLabel.mas_top).offset(-15);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.bugBtn.mas_left).offset(-20);
        make.bottom.equalTo(weakSelf.lineLabel.mas_top).offset(-15);
        make.height.equalTo(25);
    }];
    
    [_bugBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.contentLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(70, 25));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(1);
    }];
    
}

- (UIImageView *)contentImage {
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc] init];
    }
    return _contentImage;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:15.0];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

- (UIButton *)bugBtn {
    if (!_bugBtn) {
        _bugBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _bugBtn.backgroundColor = RGB(119, 182, 69);
        [_bugBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
        _bugBtn.titleLabel.textColor = [UIColor whiteColor];
        _bugBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _bugBtn.layer.masksToBounds = YES;
        _bugBtn.layer.cornerRadius = 10.0;
        _bugBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bugBtn;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
