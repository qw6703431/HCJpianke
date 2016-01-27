//
//  PKRadioViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKRadioViewController.h"
#import "Masonry.h"

#import "PKRadioTableView.h" // tableView

#import "MJRefresh.h" // 公共类

@interface PKRadioViewController ()

// nav左面的按钮和lebel
@property (strong, nonatomic) UIButton* leftBtn;
@property (strong, nonatomic) UILabel* leftLabel;
// nav右边的按钮
@property (strong, nonatomic) UIButton* rightBtn;

@property (strong, nonatomic) PKRadioTableView* radioTableView;
// 储存请求成功的参数，便于传值
@property (strong, nonatomic) NSDictionary* dataDic;
// 请求参数（从第几行开始）
@property (assign, nonatomic) NSInteger start;

@end

@implementation PKRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.radioTableView];
    
    
    [self navigationBtn];
    [self addAutoLayout];
    
    // 初始化行数
    _start = 9;
    
    [self POSTHttpRadio];
    
    WS(weakSelf);
    // 下拉刷新的回调
    weakSelf.radioTableView.NewDataBlock = ^{
        // 将数据字典置为空
        weakSelf.dataDic = nil;
        // 清空长度数组
        [weakSelf.radioTableView.countArray removeAllObjects];
        // 重新调用请求方法
        [weakSelf POSTHttpRadio];
    };
    // 上拉加载的回调
    weakSelf.radioTableView.MoreDataBlock = ^{
        // 调用加载方法，并将已经自增的start传进去
        [weakSelf POSTUpLoda:weakSelf.start];
    };
    
    // Do any additional setup after loading the view.
}
// 第一次POST请求
- (void)POSTHttpRadio {
    // 制作请求参数
    NSDictionary* dic = @{@"auth":	@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                          @"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/ting/radio" dic:dic successBalck:^(id JSON) {
//        NSLog(@"%@",JSON);
        NSDictionary* jsonDic = JSON;
        if ([jsonDic[@"result"] integerValue] == 1) {
            if (weakSelf.dataDic == nil) {
                weakSelf.dataDic = [[NSDictionary alloc] init];
            }
            
            weakSelf.dataDic = jsonDic;
            weakSelf.radioTableView.dataDic = weakSelf.dataDic[@"data"];
            // 保存第三分区的数据
            [weakSelf.radioTableView.countArray addObjectsFromArray:weakSelf.radioTableView.dataDic[@"alllist"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.radioTableView reloadData];
            });
            // 结束顶部下拉刷新动画
            [self.radioTableView.mj_header endRefreshing];
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
                          @"limit":@"9",
                          @"start":[NSString stringWithFormat:@"%d",start],
                          @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/ting/radio_list" dic:dic successBalck:^(id JSON) {
        NSDictionary* returnDic = JSON;
        if ([returnDic[@"result"] integerValue] == 1) {
            // 保存上拉加载的数据
            [weakSelf.radioTableView.countArray addObjectsFromArray:[returnDic[@"data"] valueForKey:@"list"]];
            // 刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.radioTableView reloadData];
            });
            // start 自增9 为上拉加载数据做准备
            _start += 9;
            // 结束底部上拉加载动画
            [self.radioTableView.mj_footer endRefreshing];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)addAutoLayout {
    WS(weakSelf);
    [_radioTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}
// 电台tableView
- (PKRadioTableView *)radioTableView {
    if (!_radioTableView) {
        _radioTableView = [[PKRadioTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
    }
    return _radioTableView;
}

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
    _leftLabel.text = @"电台";
    _leftLabel.font = [UIFont systemFontOfSize:15.0];
    UIBarButtonItem* leftLa = [[UIBarButtonItem alloc] initWithCustomView:_leftLabel];
    
    // 设置左侧按钮
    [self.navigationItem setLeftBarButtonItems:@[leftBtn,leftLa] animated:YES];
    
    // 自定义右边按钮
    _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [_rightBtn setFrame:CGRectMake(0, 0, 85, 20)];
    
    UIImageView* rightImageView = [[UIImageView alloc] init];
    rightImageView.image = [UIImage imageNamed:@"电台话筒"];
    rightImageView.frame = CGRectMake(0, 0, 20, 20);
    [_rightBtn addSubview:rightImageView];
    
    UILabel* rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 65, 20)];
    rightLabel.text = @"我要当主播";
    rightLabel.textColor = [UIColor grayColor];
    rightLabel.font = [UIFont systemFontOfSize:13.0];
    
    [_rightBtn addSubview:rightLabel];
    
    UIBarButtonItem* rightLa = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    // 设置右侧按钮
    [self.navigationItem setRightBarButtonItem:rightLa];
}
// nav左边按钮所响应的事件
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
