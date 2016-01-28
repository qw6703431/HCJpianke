//
//  PKRadioInfoTableViewCell.h
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKRadioInfoTableViewCell : UITableViewCell
// 左边image
@property (strong, nonatomic) UIImageView* leftImage;
// title
@property (strong, nonatomic) UILabel* titleLabel;
// 收听量image
@property (strong, nonatomic) UIImageView* countImage;
// 收听量label
@property (strong, nonatomic) UILabel* countLabel;
// 播放Btn
@property (strong, nonatomic) UIButton* playBtn;
// 底部线
@property (strong, nonatomic) UILabel* lineLabel;

@end
