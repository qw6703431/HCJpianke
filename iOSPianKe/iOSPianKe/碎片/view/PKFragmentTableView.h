//
//  PKFragmentTableView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/20.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadNewDataBlock)();//加载新数据
typedef void(^loadMoreDataBlock)();//加载更多数据

@interface PKFragmentTableView : UITableView

@property (strong, nonatomic) NSMutableArray* dataArray;

@property (copy, nonatomic) loadNewDataBlock NewDataBlock;
@property (copy, nonatomic) loadMoreDataBlock MoreDataBlock;

@end
