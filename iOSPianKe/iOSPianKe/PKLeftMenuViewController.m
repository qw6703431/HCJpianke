//
//  PKLeftMenuViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLeftMenuViewController.h"
#import "PKLeftHeadView.h" // 头部view
#import "PKLeftTableView.h" // 中间cell
#import "PKLeftDownView.h" // 底部view

@interface PKLeftMenuViewController ()

@property (strong, nonatomic) PKLeftHeadView* leftheadView;

@property (strong, nonatomic) PKLeftTableView* leftTableView;

@property (strong, nonatomic) PKLeftDownView* leftdownView;

@end

@implementation PKLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(51, 51, 51);
    [self.view addSubview:self.leftheadView];
    [self.view addSubview:self.leftTableView];
    self.leftdownView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.leftdownView];
    
    WS(weakSelf);
    [_leftheadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.height.equalTo(190);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right).offset(-45);
    }];
    CGFloat height = VIEW_HEIGHT-190-60;
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.leftheadView.mas_bottom);
        make.height.equalTo(height);
    }];
    [_leftdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.top.equalTo(weakSelf.leftTableView.mas_bottom);
    }];
    
    // Do any additional setup after loading the view.
}

- (PKLeftHeadView*)leftheadView {
    if (!_leftheadView) {
        _leftheadView = [[PKLeftHeadView alloc] init];
    }
    return _leftheadView;
}

- (PKLeftTableView*)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[PKLeftTableView alloc] init];
    }
    return _leftTableView;
}

- (PKLeftDownView*)leftdownView {
    if (!_leftdownView) {
        _leftdownView = [[PKLeftDownView alloc] init];
    }
    return _leftdownView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end















