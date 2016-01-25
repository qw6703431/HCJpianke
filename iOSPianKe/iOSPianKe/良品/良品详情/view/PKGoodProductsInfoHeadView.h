//
//  PKGoodProductsInfoHeadView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKGoodProductsInfoHeadView : UIView

// 这四个控件内容都是从网络请求返回而来的，所以要给外界提供接口
// 标题
@property (strong, nonatomic) UILabel* titleLabel;
// 头像
@property (strong, nonatomic) UIImageView* iconImage;
// 昵称
@property (strong, nonatomic) UILabel* nameLabel;
// 时间
@property (strong, nonatomic) UILabel* timeLabel;

@property (strong, nonatomic) NSDictionary* dic;

@end
