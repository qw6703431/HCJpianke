//
//  PKRadioInfoController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioInfoController.h"
#import "Masonry.h"
#import "PKRadioInfoTableView.h"

#import "MJRefresh.h" // 公共类

@interface PKRadioInfoController ()

@property (strong, nonatomic) PKRadioInfoTableView* radioInfoTableView;
// 保存回传参数
@property (strong, nonatomic) NSDictionary* dataDic;
// 保存头部view的各项参数
@property (strong, nonatomic) NSDictionary* headDic;
// 导航栏titleLabel
@property (strong, nonatomic) UILabel* titleLabel;
// 请求参数（从第几行开始）
@property (assign, nonatomic) NSInteger start;

@end

@implementation PKRadioInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.radioInfoTableView];
    
    [self addAutoLayout];
    [self navigationBtn];
    
    // 初始化行数
    _start = 10;
    
    [self POSTHttpRadioInof];
    
    WS(weakSelf);
    // 下拉刷新的回调
    weakSelf.radioInfoTableView.NewDataBlock = ^{
        // 将数据字典置为空
        weakSelf.dataDic = nil;
        // 清空长度数组
        [weakSelf.radioInfoTableView.countArray removeAllObjects];
        // 重新调用请求方法
        [self POSTHttpRadioInof];
    };
    // 上拉加载的回调
    weakSelf.radioInfoTableView.MoreDataBlock = ^{
        // 调用加载方法，并将已经自增的start传进去
        [weakSelf POSTUpLoda:weakSelf.start];
    };
    
    // Do any additional setup after loading the view.
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_radioInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}
// POST
- (void)POSTHttpRadioInof {
    // 制作请求参数
    NSDictionary* dic = @{@"auth":	@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                          @"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"radioid":self.contentID,
                          @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/ting/radio_detail" dic:dic successBalck:^(id JSON) {
        NSDictionary* returnDic = JSON;
        if ([returnDic[@"result"] integerValue] == 1) {
            if (weakSelf.dataDic == nil) {
                weakSelf.dataDic = [[NSDictionary alloc] init];
            }
            weakSelf.dataDic = returnDic[@"data"];
            weakSelf.radioInfoTableView.dataDic = weakSelf.dataDic;
            weakSelf.titleLabel.text = [weakSelf.dataDic[@"radioInfo"] valueForKey:@"title"];
            if (weakSelf.radioInfoTableView.countArray == nil) {
                weakSelf.radioInfoTableView.countArray = [[NSMutableArray alloc] init];
            }
            [weakSelf.radioInfoTableView.countArray addObjectsFromArray:weakSelf.dataDic[@"list"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.radioInfoTableView reloadData];
            });
            // 结束顶部下拉刷新动画
            [self.radioInfoTableView.mj_header endRefreshing];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
// 上拉加载的POST请求
- (void)POSTUpLoda:(NSInteger)start {
    // 制作请求参数
    NSDictionary* dic = @{@"auth":	@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                          @"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"limit":@"10",
                          @"radioid":@"56580dad723125d1178b45c7",
                          @"start":[NSString stringWithFormat:@"%d",start],
                          @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/ting/radio_detail_list" dic:dic successBalck:^(id JSON) {
        NSDictionary* returnDic = JSON;
        if ([returnDic[@"result"] floatValue] == 1) {
            // 保存上拉加载的数据
            [weakSelf.radioInfoTableView.countArray addObjectsFromArray:[returnDic[@"data"] valueForKey:@"list"]];
            // 刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.radioInfoTableView reloadData];
            });
            // start 自增10 为上拉加载数据做准备
            _start += 10;
            // 结束底部上拉加载动画
            [self.radioInfoTableView.mj_footer endRefreshing];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
}

- (PKRadioInfoTableView *)radioInfoTableView {
    if (!_radioInfoTableView) {
        _radioInfoTableView = [[PKRadioInfoTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    }
    return _radioInfoTableView;
}

// 自定义导航栏左右按钮样式
- (void)navigationBtn {
    // 左边的按钮和线
    UIButton* returnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [returnBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    [returnBtn setFrame:CGRectMake(0, 0, 40, 40)];
    // 按钮上面图片的偏移量
    [returnBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    // 绑定事件
    [returnBtn addTarget:self action:@selector(returnUpView) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem* returnBar = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
    
    UIView* lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.frame = CGRectMake(35, -2, 1, 44);
    [returnBtn addSubview:lineView];
    // 显示label
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:15.0];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UIBarButtonItem* labelBar = [[UIBarButtonItem alloc] initWithCustomView:_titleLabel];
    // 添加
    [self.navigationItem setLeftBarButtonItems:@[returnBar,labelBar] animated:YES];
//    [self.navigationItem setLeftBarButtonItem:returnBar];
    
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
