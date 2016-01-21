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
#import "PKLoginViewController.h" // 注册界面
#import "PKHomeViewController.h" // 首页

@interface PKLandingViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) PKHeadLandingView* headLandingView;

@property (strong, nonatomic) PKMiddleLandingView* middleLandingView;

@property (strong, nonatomic) PKThirdLandingView* thirdLandingView;

//@property (strong, nonatomic) PKHomeViewController* homeView;

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
        [_headLandingView.returnBtn addTarget:self action:@selector(returnLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
        [_headLandingView.registerBtn addTarget:self action:@selector(pushToLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headLandingView;
}
// 中间
- (PKMiddleLandingView*)middleLandingView {
    if (!_middleLandingView) {
        _middleLandingView = [[PKMiddleLandingView alloc] init];
        // 让textField遵从代理方法
        _middleLandingView.emailText.delegate = self;
        _middleLandingView.passwordText.delegate = self;
        [_middleLandingView.landingBtn addTarget:self action:@selector(loginHttpRequest) forControlEvents:(UIControlEventTouchUpInside)];
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
// 跳转到注册界面
- (void)pushToLandingViewController {
    PKLoginViewController* login = [[PKLoginViewController alloc] init];
    // 模态化视图跳转->登陆界面
    [self presentViewController:login animated:YES completion:nil];
}

- (void)returnLandingViewController {
    // 回到上一视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginHttpRequest {
        WS(weakSelf);
        [self POSTHttpRequest:@"http://api2.pianke.me/user/login" dic:[self makeLoginRequestDic]  successBalck:^(id JSON) {
            NSDictionary *returnDic = JSON;
            //判断是否成功，如果result为 1 ，注册成功，result为0，查看返回字典中data字段中msg的错误原因
            if ([returnDic[@"result"] integerValue] == 1) {
                [weakSelf.view makeToast:@"登陆成功" duration:1 position:@"center"];
//                PKHomeViewController* homeView = [[PKHomeViewController alloc] init];
                // 模态化视图跳转->首页
//                [self presentViewController:_homeView animated:YES completion:nil];
            } else {
                [weakSelf.view makeToast:[returnDic[@"data"] valueForKey:@"msg"] duration:1 position:@"center"];
            }
        } errorBlock:^(NSError *error) {
            [weakSelf.view makeToast:@"登陆失败" duration:1 position:@"center"];
        }];
}
// 请求字典
- (NSDictionary*)makeLoginRequestDic {
    NSDictionary* dic = @{
                          @"auth":@"",
                          @"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"email":_middleLandingView.emailText.text,
                          @"passwd":_middleLandingView.passwordText.text,
                          @"version":@"3.0.6"
                          };
    return dic;
}
// 当文本框将要进行编辑的时候调用这个方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    WS(weakSelf);
    if (textField == _middleLandingView.emailText) {
        // 第一个参数是时间
        // block体是屏幕上移或下移的方法
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 50;
            weakSelf.view.bounds = rect;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 100;
            weakSelf.view.bounds = rect;
        }];
    }
    return YES;
}
// 点击return隐藏键盘（前提是textField遵从代理方法UITextFieldDelegate）
- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [_middleLandingView.emailText resignFirstResponder];
    [_middleLandingView.passwordText resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
    return YES;
}
// 点击空白隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_middleLandingView.emailText resignFirstResponder];
    [_middleLandingView.passwordText resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
}

//// 点击屏幕触发方法
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 回到上一视图
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
