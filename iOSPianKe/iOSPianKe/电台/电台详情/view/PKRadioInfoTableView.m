//
//  PKRadioInfoTableView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioInfoTableView.h"
#import "Masonry.h"
#import "PKRadioInfoTableViewCell.h"
#import "PkRadioInfoHeaderView.h" // 表格头部view
#import "UIImageView+SDWedImage.h" // 加载网络图片

#import "MJRefresh.h" // MJ刷新公共类
#import "MJChiBaoZiHeader.h" // 头部刷新
#import "MJChiBaoZiFooter2.h" // 底部刷新

@interface PKRadioInfoTableView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) PkRadioInfoHeaderView* infoHeaderView;

@end

@implementation PKRadioInfoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        
        self.separatorStyle = NO;
        // 设置表格头
        [self setTableHeaderView:self.infoHeaderView];
        
        [self registerClass:[PKRadioInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self addRefreshControl];
        
    }
    return self;
}

#pragma mark- MJ刷新
- (void)addRefreshControl {
    // 设置回调(一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader* header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新动画
    self.mj_header = header;
    // 设置上拉加载的动画
    MJChiBaoZiFooter2* footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    // 开启屏幕透明度
    self.mj_footer.automaticallyChangeAlpha = YES;
    self.mj_footer = footer;
}
#pragma mark- UITableView
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countArray.count;
}
// cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"cell";
    
    PKRadioInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    // 表格头部视图
    NSDictionary* headViewDic = self.dataDic[@"radioInfo"];
    
    [self.infoHeaderView.headImage downloadImage:headViewDic[@"coverimg"]];
    [self.infoHeaderView.iconImage downloadImage:[headViewDic[@"userinfo"] valueForKey:@"icon"]];
    self.infoHeaderView.nameLabel.text = [headViewDic[@"userinfo"] valueForKey:@"uname"];
    self.infoHeaderView.countLabel.text = [NSString stringWithFormat:@"%@",headViewDic[@"musicvisitnum"]];
    self.infoHeaderView.titleLabel.text = headViewDic[@"desc"];
    
    // 表格视图
    NSDictionary* countDic = self.countArray[indexPath.row];
    [cell.leftImage downloadImage:countDic[@"coverimg"]];
    cell.titleLabel.text = countDic[@"title"];
    cell.countLabel.text = countDic[@"musicVisit"];
    
    
    return cell;
}
// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (PkRadioInfoHeaderView *)infoHeaderView {
    if (!_infoHeaderView) {
        _infoHeaderView = [[PkRadioInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 250)];
    }
    return _infoHeaderView;
}
// 下拉刷新
- (void)loadMoreData {
    if (_MoreDataBlock) {
        _MoreDataBlock();
    }
}
// 上拉加载
- (void)loadNewData{
    if (_NewDataBlock) {
        _NewDataBlock();
    }
}

@end






