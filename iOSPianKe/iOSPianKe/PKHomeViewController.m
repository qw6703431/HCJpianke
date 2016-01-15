//
//  PKHomeViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKHomeViewController.h"
#import "PKLeftMenuViewController.h"
#import "RESideMenu.h"

@interface PKHomeViewController ()

@end

@implementation PKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // 自定义导航栏左边按钮样式
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setFrame:CGRectMake(0, 0, 70, 40)];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn setTitle:@"goback" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    // 设置左侧按钮
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    // Do any additional setup after loading the view.
}

- (void)leftAction:(id)sender {
    // 跳到抽屉
    [self presentLeftMenuViewController:nil];
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
