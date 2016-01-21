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
#import "PKLandingViewController.h" // 登陆界面
#import "ZJPNavigationController.h" // 导航
#import "PKSettingViewController.h" // 设置
#import "PKGoodProductsViewController.h" // 良品
#import "PKCommunityViewController.h" // 社区
#import "PKReadViewController.h" // 阅读
#import "PKRadioViewController.h" // 电台
#import "PKFragmentViewController.h" // 碎片
#import "PKHomeViewController.h" // 首页

@interface PKLeftMenuViewController ()<PKLeftTableViewSelectRow>

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
        make.right.equalTo(weakSelf.view.mas_right).offset(-45);
        make.top.equalTo(weakSelf.leftheadView.mas_bottom);
        make.height.equalTo(height);
    }];
    [_leftdownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right).offset(-45);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.top.equalTo(weakSelf.leftTableView.mas_bottom);
    }];
    
    // Do any additional setup after loading the view.
}
// 头部view
- (PKLeftHeadView*)leftheadView {
    if (!_leftheadView) {
        _leftheadView = [[PKLeftHeadView alloc] init];
        // 添加事件，跳转到登陆界面
        [_leftheadView.iconImageBtn addTarget:self action:@selector(pushToLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
        [_leftheadView.userNameBtn addTarget:self action:@selector(pushToLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _leftheadView;
}
// 中间cell
- (PKLeftTableView*)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[PKLeftTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        
        _leftTableView.RowDelegate = self;
    }
    return _leftTableView;
}
// 底部view
- (PKLeftDownView*)leftdownView {
    if (!_leftdownView) {
        _leftdownView = [[PKLeftDownView alloc] init];
    }
    return _leftdownView;
}
#pragma mark - RowDelegate
//执行跳转的代理方法
- (void)selectDidWhichRow:(NSInteger)row{
//    NSLog(@"xxxxxxxooooooooooo%d",row);
    switch (row) {
        case 0:
        {
            // 初始化页面
            PKHomeViewController *homeController = [[PKHomeViewController alloc]init];
            // 设置根视图
            ZJPNavigationController *homeNav = [[ZJPNavigationController alloc]initWithRootViewController:homeController];
            // 进行页面跳转
            [self.sideMenuViewController setContentViewController:homeNav animated:YES];
            // 隐藏侧边菜单
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 1:
        {
            PKRadioViewController *radioController = [[PKRadioViewController alloc]init];
            ZJPNavigationController *radioNav = [[ZJPNavigationController alloc]initWithRootViewController:radioController];
            [self.sideMenuViewController setContentViewController:radioNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 2:
        {
            PKReadViewController *readController = [[PKReadViewController alloc]init];
            ZJPNavigationController *readNav = [[ZJPNavigationController alloc]initWithRootViewController:readController];
            [self.sideMenuViewController setContentViewController:readNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 3:
        {
            PKCommunityViewController *CommunityController = [[PKCommunityViewController alloc]init];
            ZJPNavigationController *CommunityNav = [[ZJPNavigationController alloc]initWithRootViewController:CommunityController];
            [self.sideMenuViewController setContentViewController:CommunityNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 4:
        {
            PKFragmentViewController *FragmentController = [[PKFragmentViewController alloc]init];
            ZJPNavigationController *FragmentNav = [[ZJPNavigationController alloc]initWithRootViewController:FragmentController];
            [self.sideMenuViewController setContentViewController:FragmentNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 5:
        {
            PKGoodProductsViewController *GoodProductsController = [[PKGoodProductsViewController alloc]init];
            ZJPNavigationController *GoodProductsNav = [[ZJPNavigationController alloc]initWithRootViewController:GoodProductsController];
            [self.sideMenuViewController setContentViewController:GoodProductsNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 6:
        {
            PKSettingViewController *SettingeController = [[PKSettingViewController alloc]init];
            ZJPNavigationController *SettingNav = [[ZJPNavigationController alloc]initWithRootViewController:SettingeController];
            [self.sideMenuViewController setContentViewController:SettingNav animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;

    }
}
- (void)pushToLandingViewController {
    PKLandingViewController* landing = [[PKLandingViewController alloc] init];
    // 模态化视图跳转->登陆界面
    [self presentViewController:landing animated:YES completion:nil];
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















