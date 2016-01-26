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


@interface PKRadioTableView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PKRadioTableView

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
        
    }
    return self;
}

#pragma mark- UITableView
// 返回分区的总数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 9;
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
        [((PKRadioMiddleTableViewCell*)cell).imageView1 downloadImage:[arr[0] valueForKey:@"coverimg"]];
        [((PKRadioMiddleTableViewCell*)cell).imageView2 downloadImage:[arr[1] valueForKey:@"coverimg"]];
        [((PKRadioMiddleTableViewCell*)cell).imageView3 downloadImage:[arr[2] valueForKey:@"coverimg"]];
    } else {
        NSArray* arr = self.dataDic[@"alllist"];
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
// 分区头
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 25)];
    UILabel* lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, VIEW_WIDTH-5, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 100, 11)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:10.0];
    titleLabel.text = @"全部电台·ALL Radios";
    titleLabel.textColor = [UIColor grayColor];
    
    [headView addSubview:lineLabel];
    [headView addSubview:titleLabel];
    return headView;
}
// 返回分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 25;
    }
    return 0.0;
}

@end















