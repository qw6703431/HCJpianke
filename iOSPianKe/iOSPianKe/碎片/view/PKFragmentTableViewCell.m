//
//  PKFragmentTableViewCell.m
//  iOSPianKe
//
//  Created by ma c on 16/1/20.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKFragmentTableViewCell.h"
#import "Masonry.h"

@implementation PKFragmentTableViewCell

// 代码实现自定义Cell,就是重写这个方法。
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.bigImage];
        [self addSubview:self.newsLabel];
        [self addSubview:self.commentBtn];
        [self addSubview:self.commentLabel];
        [self addSubview:self.likeBtn];
        [self addSubview:self.likeLabel];
        [self addSubview:self.lineLabel];
        
        [self addAutoLayout];
        
    }
    return self;
}
// 自适应
- (void)addAutoLayout {
    WS(weakSelf);
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.height.equalTo(CGSizeMake(100, 20));
    }];

    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.centerY.equalTo(weakSelf.iconImage.mas_centerY);
        make.size.equalTo(CGSizeMake(60, 20));
    }];
    
    
    
    [_bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.top.equalTo(weakSelf.iconImage.mas_bottom).offset(10);
    }];

    [_newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bigImage.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(-20);
        make.bottom.equalTo(weakSelf.likeLabel.mas_top).offset(-20);
    }];
    
    
    
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-5);
        make.bottom.equalTo(weakSelf.lineLabel.mas_top).offset(-20);
        make.size.equalTo(CGSizeMake(40, 12));
    }];
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.likeLabel.mas_left).offset(-5);
        make.centerY.equalTo(weakSelf.likeLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.likeBtn.mas_left).offset(-10);
        make.centerY.equalTo(weakSelf.likeLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(40, 12));
    }];
    
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.commentLabel.mas_left).offset(-5);
        make.centerY.equalTo(weakSelf.likeLabel.mas_centerY);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.equalTo(1);
    }];
    
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.layer.cornerRadius = 15;
        _iconImage.layer.masksToBounds = YES;
    }
    return _iconImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UIImageView *)bigImage {
    if (!_bigImage) {
        _bigImage = [[UIImageView alloc] init];
    }
    return _bigImage;
}

- (UILabel *)newsLabel {
    if (!_newsLabel) {
        _newsLabel = [[UILabel alloc] init];
        _newsLabel.font = [UIFont systemFontOfSize:16.0];
        _newsLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _newsLabel.numberOfLines = 0;
    }
    return _newsLabel;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:(UIControlStateNormal)];
//        [_commentBtn setImage:[UIImage imageNamed:@"nav碎片_sel"] forState:(UIControlStateSelected)];
    }
    return _commentBtn;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:10.0];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.textColor = [UIColor grayColor];
    }
    return _commentLabel;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_likeBtn setImage:[UIImage imageNamed:@"喜欢"] forState:(UIControlStateNormal)];
        //        [_likeBtn setImage:[UIImage imageNamed:@"nav碎片_sel"] forState:(UIControlStateSelected)];
    }
    return _likeBtn;
}

- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.font = [UIFont systemFontOfSize:10.0];
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        _likeLabel.textColor = [UIColor grayColor];
    }
    return _likeLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = [UIColor grayColor];
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
