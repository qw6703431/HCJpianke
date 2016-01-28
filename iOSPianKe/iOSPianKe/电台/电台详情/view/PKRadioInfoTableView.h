//
//  PKRadioInfoTableView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loadNewDataBlock)(); // 加载新数据
typedef void (^loadMoreDataBlock)(); // 加载更多数据

@interface PKRadioInfoTableView : UITableView

// 接收数据
@property (strong, nonatomic) NSDictionary* dataDic;
// 表格数据
@property (strong, nonatomic) NSMutableArray* countArray;

@property (copy, nonatomic) loadNewDataBlock NewDataBlock;
@property (copy, nonatomic) loadMoreDataBlock MoreDataBlock;

@end
