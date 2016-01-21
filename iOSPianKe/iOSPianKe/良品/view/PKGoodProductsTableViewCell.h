//
//  PKGoodProductsTableViewCell.h
//  iOSPianKe
//
//  Created by ma c on 16/1/21.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKGoodProductsTableViewCell : UITableViewCell
// 图片
@property (strong, nonatomic)               UIImageView *contentImage;
// 介绍
@property (strong, nonatomic)               UILabel *contentLabel;
// 立即购买Btn
@property (strong, nonatomic)               UIButton* bugBtn;
// 底部线
@property (strong, nonatomic)               UILabel *lineLabel;

@end
