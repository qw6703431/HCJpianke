//
//  PKRadioInfoTableView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioInfoTableView.h"
#import "PKRadioInfoTableViewCell.h"

@interface PKRadioInfoTableView()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation PKRadioInfoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[PKRadioInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}
#pragma mark- UITableView
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"cell";
    
    PKRadioInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSLog(@"se%@",self.dataDic);
    
    return cell;
}

@end






