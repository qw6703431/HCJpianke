//
//  PKGoodProductsViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsViewController.h"
#import "Masonry.h"
#import "PKGoodProductsTableView.h" // 良品TableView
#import "MJRefresh.h" // 公共类

@interface PKGoodProductsViewController ()

@property (strong, nonatomic) PKGoodProductsTableView* goodProductsTableView;

// nav左面的按钮和lebel
@property (strong, nonatomic) UIButton* leftBtn;
@property (strong, nonatomic) UILabel* leftLabel;

@property (strong, nonatomic) NSMutableArray* goodProductArray;

@property (assign, nonatomic) NSInteger start; // 请求参数（从第几行开始）

@end

@implementation PKGoodProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.goodProductsTableView];
    
    // 初始化行数
    _start = 0;
    
    [self POSTHttpGoodProducts:_start];
    
    WS(weakSelf);
    // 下拉刷新的回调
    self.goodProductsTableView.NewDataBlock = ^{
        // 把内容数组中的所有数据移除
        [weakSelf.goodProductArray removeAllObjects];
        // 从0（最新的数据）开始
        [weakSelf POSTHttpGoodProducts:0];
        
    };
    // 上拉加载的回调
    self.goodProductsTableView.MoreDataBlock = ^{
        // 将已经自增10个数的start传到POST请求方法里去
        [weakSelf POSTHttpGoodProducts:weakSelf.start];
    };
    
    [self navigationBtn];
    
    [self addAutoLayout];
    
    
    // Do any additional setup after loading the view.
}
// 自适应
- (void)addAutoLayout {
    WS(weakSelf);
    [_goodProductsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
}
// post请求
- (void)POSTHttpGoodProducts:(NSInteger )start{
    //制作请求参数
    NSDictionary *requestDic = @{@"auth":@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                                 @"client":@"1",
                                 @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                                 @"limit":@"10",
                                 @"start":[NSString stringWithFormat:@"%d",start],
                                 @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/pub/shop"
                      dic:requestDic
             successBalck:^(id JSON) {
                 
                 NSDictionary *returnDic = JSON;
                 if ([returnDic[@"result"] integerValue] == 1) {
                     if (weakSelf.goodProductArray == nil) {
                         weakSelf.goodProductArray = [NSMutableArray array];
                     }
                     [weakSelf.goodProductArray addObjectsFromArray:[returnDic[@"data"] valueForKey:@"list"]];
                     
                     weakSelf.goodProductsTableView.dataArray = weakSelf.goodProductArray;
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [weakSelf.goodProductsTableView reloadData];
                     });
                     // start 自增10 为下拉加载数据做准备
                     _start += 10;
                     // 结束底部上拉加载动画
                     [self.goodProductsTableView.mj_header endRefreshing];
                     // 结束顶部下拉刷新动画
                     [self.goodProductsTableView.mj_footer endRefreshing];
                 }
                 
             } errorBlock:^(NSError *error) {
                 
             }];
}
// 自定义导航按钮
- (void)navigationBtn {
    // 自定义导航栏左边按钮样式
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
    [_leftBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [_leftBtn setImage:[UIImage imageNamed:@"菜单"] forState:(UIControlStateNormal)];
    // 导航栏按钮图片的偏移量
    [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    // 导航栏按钮文字的偏移量
    //    [_leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    
    UIView* leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor grayColor];
    leftView.frame = CGRectMake(35, -2, 1, 44);
    [_leftBtn addSubview:leftView];
    
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    _leftLabel.text = @"良品";
    _leftLabel.font = [UIFont systemFontOfSize:15.0];
    UIBarButtonItem* leftLa = [[UIBarButtonItem alloc] initWithCustomView:_leftLabel];
    
    // 设置左侧按钮
    [self.navigationItem setLeftBarButtonItems:@[leftBtn,leftLa] animated:YES];
}
// nav左边按钮所响应的事件
- (void)leftAction:(id)sender {
    // 跳到抽屉
    [self presentLeftMenuViewController:nil];
}

// 良品TableView
- (PKGoodProductsTableView *)goodProductsTableView {
    if (!_goodProductsTableView) {
        _goodProductsTableView = [[PKGoodProductsTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
        _goodProductsTableView.controller = self;
    }
    return _goodProductsTableView;
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
