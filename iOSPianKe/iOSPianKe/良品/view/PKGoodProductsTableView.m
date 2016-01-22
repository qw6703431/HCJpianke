//
//  PKGoodProductsTableView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/21.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsTableView.h"
#import "PKGoodProductsTableViewCell.h"

#import "UIImageView+SDWedImage.h" // 加载网络图片

#import "MJRefresh.h" // MJ刷新公共类
#import "MJChiBaoZiHeader.h" // 头部刷新
#import "MJChiBaoZiFooter2.h" // 底部刷新
#import "PKGoodProductsInfoController.h" // 良品详情

@interface PKGoodProductsTableView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* imageSizeArray;

@property (strong, nonatomic) NSArray* imageHeArray;

@end

@implementation PKGoodProductsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        // 注册代码实现的cell ，要使用registerClass
        [self registerClass:[PKGoodProductsTableViewCell class] forCellReuseIdentifier:@"cell"];
        // 关闭表格的分割线
        self.separatorStyle = NO;

        self.backgroundColor = [UIColor whiteColor];
        //添加mj刷新
        [self addRefreshControl];
    }
    return self;
}
#pragma mark- MJ刷新
- (void)addRefreshControl {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader* header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
    self.mj_header = header;
    // 设置上拉加载的动画
    MJChiBaoZiFooter2* footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    // 开启屏幕透明度
    self.mj_footer.automaticallyChangeAlpha = YES;
    self.mj_footer = footer;
}

#pragma mark - Table view data source
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
// cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"cell";
    PKGoodProductsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    // 关闭表格的选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary* dic = self.dataArray[indexPath.row];
    [cell.contentImage downloadImage:dic[@"coverimg"]];
    cell.contentLabel.text = dic[@"title"];
    
    return cell;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220.0;
}
// 获取用户当前点击的行数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PKGoodProductsInfoController* info = [[PKGoodProductsInfoController alloc] init];
    info.contentID = [self.dataArray[indexPath.row] valueForKey:@"contentid"];
    
    [_controller.navigationController pushViewController:info animated:YES];
}
// 获取用户上次点击的行数
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
// 下拉刷新全部数据
- (void)loadMoreData{
    if (_MoreDataBlock) {
        _MoreDataBlock();
    }
}
// 上拉加载更多数据
- (void)loadNewData{
    if (_NewDataBlock) {
        _NewDataBlock();
    }
}

@end
