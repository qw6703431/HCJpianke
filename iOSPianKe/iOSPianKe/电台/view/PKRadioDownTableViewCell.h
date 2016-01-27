//
//  PKRadioDownTableViewCell.h
//  iOSPianKe
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKRadioDownTableViewCell : UITableViewCell

// 左边图像
@property (strong, nonatomic) UIImageView* leftImageView;
// 标题
@property (strong, nonatomic) UILabel* titleLabel;
// by: label
@property (strong, nonatomic) UILabel* byLabel;
// 名字
@property (strong, nonatomic) UILabel* nameLabel;
// 名字下详情
@property (strong, nonatomic) UILabel* descLabel;
// 收听量前面的image
@property (strong, nonatomic) UIImageView* countImageView;
// 收听量
@property (strong, nonatomic) UILabel* countLabel;
// 线
@property (strong, nonatomic) UILabel* lineLabel;

@end
