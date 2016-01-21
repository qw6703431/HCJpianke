//
//  PKLeftTableView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
// 创建代理，接收用户所点界面的行数信息row
@protocol PKLeftTableViewSelectRow <NSObject>

- (void)selectDidWhichRow:(NSInteger)row;

@end

@interface PKLeftTableView : UITableView

@property (strong, nonatomic) id<PKLeftTableViewSelectRow>RowDelegate;

@end
