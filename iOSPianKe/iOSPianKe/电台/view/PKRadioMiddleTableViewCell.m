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
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        
        [self addAutoLayout];
    }
    return self;
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.mas_left).offset(5);
//        make.height.equalTo(weakSelf.imageView1.mas_width);
        make.width.equalTo(weakSelf.btn2.mas_width);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.btn1.mas_right).offset(3);
//        make.height.equalTo(weakSelf.imageView2.mas_width);
        make.width.equalTo(weakSelf.btn3.mas_width);
    }];
    
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
        make.left.equalTo(weakSelf.btn2.mas_right).offset(3);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
//        make.height.equalTo(weakSelf.imageView3.mas_width);
        make.width.equalTo(weakSelf.btn1.mas_width);
    }];
    
}

- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _btn1;
}

- (UIButton *)btn2 {
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _btn2;
}

- (UIButton *)btn3 {
    if (!_btn3) {
        _btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _btn3;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end








