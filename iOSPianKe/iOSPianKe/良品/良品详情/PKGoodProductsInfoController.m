//
//  PKGoodProductsInfoController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsInfoController.h"
#import "Masonry.h"
#import "PKGoodProductsViewController.h" // 良品首页
#import "PKGoodProductsInfoHeadView.h" // 头部view

@interface PKGoodProductsInfoController ()<UIScrollViewDelegate>

@property (strong, nonatomic) PKGoodProductsInfoHeadView* productsInfoHeadView;

// 返回按钮
@property (strong, nonatomic) UIButton* returnBtn;
// 装所有控件的scrollView
@property (strong, nonatomic) UIScrollView* scrollView;
// 头部view

@end

@implementation PKGoodProductsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(VIEW_WIDTH, 1000);
    _scrollView.contentOffset = CGPointMake(0, 64);
    
    [self.scrollView addSubview:self.productsInfoHeadView];
    [self.view addSubview:self.scrollView];
    
    [self addAutoLayout];
    [self navigationBtn];
    
    // Do any additional setup after loading the view.
}
// 自适应
- (void)addAutoLayout {
    WS(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    
    [_productsInfoHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.left.equalTo(weakSelf.scrollView.mas_left);
        make.right.equalTo(weakSelf.scrollView.mas_right);
        make.height.equalTo(170);
    }];
    
}

- (PKGoodProductsInfoHeadView *)productsInfoHeadView {
    if (!_productsInfoHeadView) {
        _productsInfoHeadView  = [[PKGoodProductsInfoHeadView alloc] init];
    }
    return _productsInfoHeadView;
}

// 自定义导航栏左右按钮样式
- (void)navigationBtn {
    // 左边的按钮和线
    _returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_returnBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    [_returnBtn setFrame:CGRectMake(0, 0, 40, 40)];
    // 按钮上面图片的偏移量
    [_returnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    // 绑定事件
    [_returnBtn addTarget:self action:@selector(returnUpView) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem* returnBar = [[UIBarButtonItem alloc] initWithCustomView:_returnBtn];
    
    UIView* lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(35, -2, 1, 44);
    [_returnBtn addSubview:lineView];
    // 添加
    [self.navigationItem setLeftBarButtonItem:returnBar];
    
}
// 返回上一界面
- (void)returnUpView {
    // 返回上一界面(退栈)
    [self.navigationController popViewControllerAnimated:YES];
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



















