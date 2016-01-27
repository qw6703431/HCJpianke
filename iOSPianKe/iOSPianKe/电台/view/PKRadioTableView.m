//
//  PKRadioTableView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioTableView.h"
#import "PKRadioHeadTableViewCell.h" // 第一分区
#import "PKRadioMiddleTableViewCell.h" // 第二分区
#import "PKRadioDownTableViewCell.h" // 第三分区

#import "UIImageView+SDWedImage.h" // 加载网络图片
#import "UIButton+WebCache.h" // 加载btn上的网络图片

#import "MJRefresh.h" // MJ刷新公共类
#import "MJChiBaoZiHeader.h" // 头部刷新
#import "MJChiBaoZiFooter2.h" // 底部刷新

#import "PKRadioInfoController.h" // 电台详情


@interface PKRadioTableView()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation PKRadioTableView

- (NSMutableArray *)countArray {
    if (_countArray == nil) {
        _countArray = [[NSMutableArray alloc] init];
    }
    return _countArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = NO;
        
        
        [self registerClass:[PKRadioHeadTableViewCell class] forCellReuseIdentifier:@"firstCell"];
        [self registerClass:[PKRadioMiddleTableViewCell class] forCellReuseIdentifier:@"secondCell"];
        [self registerClass:[PKRadioDownTableViewCell class] forCellReuseIdentifier:@"thirdCell"];
        
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
// 返回分区的总数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        // 返回第三分区的长度
        return self.countArray.count;
    }
    return 1;
}
// cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"firstCell";
    if (indexPath.section == 0) {
        identifier = @"firstCell";
    } else if (indexPath.section == 1) {
        identifier = @"secondCell";
    } else {
        identifier = @"thirdCell";
    }
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    // 关闭表格的选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        NSArray* arr = self.dataDic[@"carousel"];
        [((PKRadioHeadTableViewCell*)cell).imageView1 downloadImage:[arr[0] valueForKey:@"img"]];
        [((PKRadioHeadTableViewCell*)cell).imageView2 downloadImage:[arr[1] valueForKey:@"img"]];
        [((PKRadioHeadTableViewCell*)cell).imageView3 downloadImage:[arr[2] valueForKey:@"img"]];
    } else if (indexPath.section == 1) {
        NSArray* arr = self.dataDic[@"hotlist"];
        
        NSString *dtrrty1= [arr[0] valueForKey:@"coverimg"];
        NSURL* url1 = [NSURL URLWithString:dtrrty1];
        // 加载btn上的网络图片所用的方法（URL）
        [((PKRadioMiddleTableViewCell*)cell).btn1 sd_setImageWithURL:url1 forState:(UIControlStateNormal)];
        
        NSString *dtrrty2= [arr[1] valueForKey:@"coverimg"];
        NSURL* url2 = [NSURL URLWithString:dtrrty2];
        [((PKRadioMiddleTableViewCell*)cell).btn2 sd_setImageWithURL:url2 forState:(UIControlStateNormal)];
        
        NSString *dtrrty3= [arr[2] valueForKey:@"coverimg"];
        NSURL* url3 = [NSURL URLWithString:dtrrty3];
        [((PKRadioMiddleTableViewCell*)cell).btn3 sd_setImageWithURL:url3 forState:(UIControlStateNormal)];
       
    } else {
        NSArray* arr = self.countArray;
        [((PKRadioDownTableViewCell*)cell).leftImageView downloadImage:[arr[indexPath.row] valueForKey:@"coverimg"]];
        ((PKRadioDownTableViewCell*)cell).titleLabel.text = [arr[indexPath.row] valueForKey:@"title"];
        ((PKRadioDownTableViewCell*)cell).nameLabel.text = [[arr[indexPath.row] valueForKey:@"userinfo"] valueForKey:@"uname"];
        NSString* string = [NSString stringWithFormat:@"%@",[arr[indexPath.row] valueForKey:@"count"]];
        ((PKRadioDownTableViewCell*)cell).countLabel.text = string;
        ((PKRadioDownTableViewCell*)cell).descLabel.text = [arr[indexPath.row] valueForKey:@"desc"];
    }
    
    return cell;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return (VIEW_WIDTH-15)/3+10;
    } else if (indexPath.section == 2) {
        return 90;
    }
    
    return (VIEW_WIDTH-20)/2;
}
// 分区尾
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 25)];
    UILabel* lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, VIEW_WIDTH-5, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 11)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:10.0];
    titleLabel.text = @"全部电台·ALL Radios";
    titleLabel.textColor = [UIColor grayColor];
    
    [headView addSubview:lineLabel];
    [headView addSubview:titleLabel];
    return headView;
}
// 返回分区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 25.0;
    }
    return 0.0;
}
// 获取用户当前点击的行数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        PKRadioInfoController* info = [[PKRadioInfoController alloc] init];
        // 将当前行的标示（id）传过去
        info.contentID = [self.countArray[indexPath.row] valueForKey:@"radioid"];
        // 压栈
        [_controller.navigationController pushViewController:info animated:YES];
    }
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
// 分区头
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

//}
// 返回分区头的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

//}

@end















