//
//  PKRadioInfoTableViewCell.m
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioInfoTableViewCell.h"
#import "Masonry.h"

@implementation PKRadioInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.leftImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.countImage];
        [self addSubview:self.countLabel];
        [self addSubview:self.playBtn];
        [self addSubview:self.lineLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    WS(weakSelf);
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftImage.mas_top);
        make.left.equalTo(weakSelf.leftImage.mas_right).offset(10);
        make.size.equalTo(CGSizeMake(200, 20));
    }];
    
    [_countImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.leftImage.mas_bottom);
        make.left.equalTo(weakSelf.leftImage.mas_right).offset(10);
        make.size.equalTo(CGSizeMake(8, 13));
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.countImage.mas_centerY);
        make.left.equalTo(weakSelf.countImage.mas_right).offset(5);
        make.size.equalTo(CGSizeMake(50, 11));
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(1);
    }];
    
}

- (UIImageView *)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] init];
    }
    return _leftImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
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
        _countLabel.font = [UIFont systemFontOfSize:10.0];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.textColor = [UIColor grayColor];
    }
    return _countLabel;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_playBtn setImage:[UIImage imageNamed:@"电台播放"] forState:(UIControlStateNormal)];
        _playBtn.layer.cornerRadius = 10.0;
        _playBtn.layer.masksToBounds = YES;
    }
    return _playBtn;
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






