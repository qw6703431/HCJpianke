//
//  PKRadioTableView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKRadioTableView : UITableView

// 提供给外界一个接口，用来接收数据
@property (strong, nonatomic) NSDictionary* dataDic;

@end
