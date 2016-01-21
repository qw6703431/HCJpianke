//
//  PKLeftTableView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLeftTableView.h"
#import "PKLeftTableViewCell.h"
#import "PKLeftTableViewBook.h"

@interface PKLeftTableView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray* cellArray;

@end

@implementation PKLeftTableView
static NSString* identifier = @"cell";

- (NSArray*)cellArray {
    if (_cellArray == nil) {
        NSString* fiePath = [[NSBundle mainBundle] pathForResource:@"LeftViewCellPlist" ofType:@"plist"];
        NSArray* cellPlistArray = [[NSArray alloc] initWithContentsOfFile:fiePath];
        NSMutableArray* muArray = [[NSMutableArray alloc] init];
        for (NSDictionary* modelDic in cellPlistArray) {
            PKLeftTableViewBook* book = [[PKLeftTableViewBook alloc] init];
            [book setValuesForKeysWithDictionary:modelDic];
            [muArray addObject:book];
        }
        _cellArray = muArray;
    }
    return _cellArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        // 关闭回弹
//        self.bounces = NO;
        // 注册代码实现的cell ，要使用registerClass
        [self registerClass:[PKLeftTableViewCell class] forCellReuseIdentifier:@"cell"];
        // 关闭表格的分割线
//        self.separatorStyle = NO;
        self.backgroundColor = RGB(51, 51, 51);
    }
    return self;
}
#pragma mark- tabView
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
// cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PKLeftTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    PKLeftTableViewBook* bookModel = self.cellArray[indexPath.row];
    cell.leftImage.image = [UIImage imageNamed:bookModel.imageName];
    cell.label.text = bookModel.label;
//
    return cell;
}
// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}
// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 检测代理能否响应这个方法
    if ([_RowDelegate respondsToSelector:@selector(selectDidWhichRow:)]) {
        [_RowDelegate selectDidWhichRow:indexPath.row];
    }
}
@end









