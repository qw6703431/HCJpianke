//
//  PkRadioInfoHeaderView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PkRadioInfoHeaderView : UIView
// 头部imageView
@property (strong, nonatomic) UIImageView* headImage;
// 头像
@property (strong, nonatomic) UIImageView* iconImage;
// 昵称
@property (strong, nonatomic) UILabel* nameLabel;
// 收听量image
@property (strong, nonatomic) UIImageView* countImage;
// 收听量label
@property (strong, nonatomic) UILabel* countLabel;
// title
@property (strong, nonatomic) UILabel* titleLabel;

@end
