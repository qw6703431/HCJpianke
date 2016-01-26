//
//  PKRadioMiddleTableViewCell.m
//  iOSPianKe
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioMiddleTableViewCell.h"
#import "Masonry.h"

@implementation PKRadioMiddleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView1];
        [self addSubview:self.imageView2];
        [self addSubview:self.imageView3];
        
        [self addAutoLayout];
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.mas_left).offset(5);
//        make.height.equalTo(weakSelf.imageView1.mas_width);
        make.width.equalTo(weakSelf.imageView2.mas_width);
    }];
    
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.imageView1.mas_right).offset(3);
//        make.height.equalTo(weakSelf.imageView2.mas_width);
        make.width.equalTo(weakSelf.imageView3.mas_width);
    }];
    
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.imageView2.mas_right).offset(3);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
//        make.height.equalTo(weakSelf.imageView3.mas_width);
        make.width.equalTo(weakSelf.imageView1.mas_width);
    }];
    
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] init];
    }
    return _imageView3;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end








