//
//  PKLandingViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/15.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLandingViewController.h"
#import "Masonry.h"
#import "PKHeadLandingView.h" // 上面
#import "PKMiddleLandingView.h" // 中间
#import "PKThirdLandingView.h" // 下面合作界面

@interface PKLandingViewController ()

@property (strong, nonatomic) PKHeadLandingView* headLandingView;

@property (strong, nonatomic) PKMiddleLandingView* middleLandingView;

@property (strong, nonatomic) PKThirdLandingView* thirdLandingView;

@end

@implementation PKLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.thirdLandingView];
    [self.view addSubview:self.middleLandingView];
    [self.view addSubview:self.headLandingView];
    
    
    WS(weakSelf);
    [_headLandingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.middleLandingView.mas_top);
        make.top.equalTo(weakSelf.view.mas_top);
    }];
    
    [_middleLandingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.thirdLandingView.mas_top);
        make.height.equalTo(170);
    }];
    
    [_thirdLandingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.height.equalTo(105);
    }];
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 上面
- (PKHeadLandingView*)headLandingView {
    if (!_headLandingView) {
        _headLandingView = [[PKHeadLandingView alloc] init];
        [_headLandingView.returnBtn addTarget:self action:@selector(pushToLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headLandingView;
}
// 中间
- (PKMiddleLandingView*)middleLandingView {
    if (!_middleLandingView) {
        _middleLandingView = [[PKMiddleLandingView alloc] init];
    }
    return _middleLandingView;
}

// 下面合作界面
- (PKThirdLandingView*)thirdLandingView {
    if (!_thirdLandingView) {
        _thirdLandingView = [[PKThirdLandingView alloc] init];
    }
    return _thirdLandingView;
}

- (void)pushToLandingViewController {
    // 回到上一视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

//// 点击屏幕触发方法
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 回到上一视图
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
