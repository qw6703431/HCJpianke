//
//  PKFragmentTableViewCell.h
//  iOSPianKe
//
//  Created by ma c on 16/1/20.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKFragmentTableViewCell : UITableViewCell

// 头像按钮
@property (strong, nonatomic) UIImageView* iconImage;
// 昵称label
@property (strong, nonatomic) UILabel* nameLabel;
// 时间label
@property (strong, nonatomic) UILabel* timeLabel;
// 大图片image
@property (strong, nonatomic) UIImageView* bigImage;
// 信息图片下的label
@property (strong, nonatomic) UILabel* newsLabel;
// 评论按钮
@property (strong, nonatomic) UIButton* commentBtn;
// 评论label
@property (strong, nonatomic) UILabel* commentLabel;
// 喜欢按钮
@property (strong, nonatomic) UIButton* likeBtn;
// 喜欢label
@property (strong, nonatomic) UILabel* likeLabel;
// 底部线label
@property (strong, nonatomic) UILabel* lineLabel;

@end
