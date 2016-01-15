//
//  PKLeftTableViewCell.m
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLeftTableViewCell.h"
#import "Masonry.h"

@implementation PKLeftTableViewCell

// 代码实现自定义Cell,就是重写这个方法。
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIImageView* imageView = [[UIImageView alloc] init];
//        UILabel* label = [[UILabel alloc] init];
//        label.textColor = [UIColor whiteColor];
//        
//        CGFloat centerY = ((VIEW_HEIGHT-180-60)/6-25)/2;
//        
//        imageView.frame = CGRectMake((VIEW_WIDTH-125)/5, centerY, 25, 25);
//        label.frame = CGRectMake((VIEW_WIDTH-125)/5+50, centerY, 50, 25);
        self.backgroundColor = RGB(51, 51, 51);
        
        [self addSubview:self.leftImage];
        [self addSubview:self.label];
        
        
//        self.leftImage = imageView;
//        self.label = label;
        
    }
    return self;
}
// 每次创建cell都会自动调用 (自动布局子视图)
- (void)layoutSubviews {
    WS(weakSelf);
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(25, 25));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(20);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImage.mas_right).offset(30);
        make.size.equalTo(CGSizeMake(50, 20));
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

- (UIImageView*)leftImage {
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] init];
    }
    return _leftImage;
}

- (UILabel*)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:14.0];
    }
    return _label;
}

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

@end
