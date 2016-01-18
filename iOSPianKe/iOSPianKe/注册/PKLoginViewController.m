//
//  PKLoginViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/18.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLoginViewController.h"
#import "Masonry.h"
#import "PKLoginView.h" // 头像下的所有view
#import "PKLoginHeadView.h" // 头部view

@interface PKLoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) PKLoginView* loginView;

@property (strong, nonatomic) PKLoginHeadView* loginHeadView;

@end

@implementation PKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loginHeadView];
    [self.view addSubview:self.loginView];
    
    WS(weakSelf);
    [_loginHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top);
        make.bottom.equalTo(weakSelf.loginView.mas_top);
    }];
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-35);
        make.height.equalTo(330);
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PKLoginHeadView *)loginHeadView {
    if (!_loginHeadView) {
        _loginHeadView = [[PKLoginHeadView alloc] init];
        [_loginHeadView.returnBtn addTarget:self action:@selector(returnLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginHeadView;
}

- (PKLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[PKLoginView alloc] init];
        _loginView.userNameText.delegate = self;
        _loginView.emailText.delegate = self;
        _loginView.passwordText.delegate = self;
    }
    return _loginView;
}
// 返回按钮响应方法
- (void)returnLandingViewController {
    // 回到上一视图
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 当文本框将要进行编辑的时候调用这个方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    WS(weakSelf);
    if (textField == _loginView.emailText) {
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
    [_loginView.userNameText resignFirstResponder];
    [_loginView.emailText resignFirstResponder];
    [_loginView.passwordText resignFirstResponder];
    
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
    [_loginView.userNameText resignFirstResponder];
    [_loginView.emailText resignFirstResponder];
    [_loginView.passwordText resignFirstResponder];
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
