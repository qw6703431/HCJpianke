//
//  PKRadioTableView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loadNewDataBlock)(); // 加载新数据
typedef void (^loadMoreDataBlock)(); // 加载更多数据

@interface PKRadioTableView : UITableView

// 提供给外界一个接口，用来接收数据
@property (strong, nonatomic) NSDictionary* dataDic;
// 保存第三分区数据的数组
@property (strong, nonatomic) NSMutableArray* countArray;

@property (strong, nonatomic) UIViewController* controller;

@property (copy, nonatomic) loadNewDataBlock NewDataBlock;
@property (copy, nonatomic) loadMoreDataBlock MoreDataBlock;

@end
