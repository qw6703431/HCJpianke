//
//  PKGoodProductsViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsViewController.h"

@interface PKGoodProductsViewController ()

@end

@implementation PKGoodProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"良品";
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
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
