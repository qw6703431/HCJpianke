//
//  PKRadioDownTableViewCell.m
//  iOSPianKe
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioDownTableViewCell.h"
#import "Masonry.h"

@implementation PKRadioDownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.leftImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.byLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.countImageView];
        [self addSubview:self.countLabel];
        [self addSubview:self.lineLabel];
        
        [self addAutoLayout];
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(5);
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.size.equalTo(CGSizeMake(70, 70));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(17);
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(5);
        make.size.equalTo(CGSizeMake(150, 16));
    }];
    
    [_byLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.leftImageView.mas_centerY).offset(3);
        make.size.equalTo(CGSizeMake(15, 11));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.byLabel.mas_right).offset(3);
        make.centerY.equalTo(weakSelf.byLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(100, 11));
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(5);
        make.bottom.equalTo(weakSelf.leftImageView.mas_bottom).offset(-5);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
        make.height.equalTo(11);
    }];
    
    [_countImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.countLabel.mas_left);
        make.centerY.equalTo(weakSelf.countLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(8, 13));
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-7);
        make.centerY.equalTo(weakSelf.titleLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(50, 11));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(5);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(1);
    }];
    
}

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

- (UILabel *)byLabel {
    if (!_byLabel) {
        _byLabel = [[UILabel alloc] init];
        _byLabel.textAlignment = NSTextAlignmentLeft;
        _byLabel.font = [UIFont systemFontOfSize:10.0];
        _byLabel.text = @"by:";
        _byLabel.textColor = RGB(63, 110, 116);
    }
    return _byLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:10.0];
        _nameLabel.textColor = RGB(63, 110, 116);
    }
    return _nameLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.font = [UIFont systemFontOfSize:10.0];
        _descLabel.textColor = [UIColor grayColor];
    }
    return _descLabel;
}

- (UIImageView *)countImageView {
    if (!_countImageView) {
        _countImageView = [[UIImageView alloc] init];
        _countImageView.image = [UIImage imageNamed:@"收听量"];
    }
    return _countImageView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont systemFontOfSize:10.0];
        _countLabel.textColor = [UIColor grayColor];
    }
    return _countLabel;
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
