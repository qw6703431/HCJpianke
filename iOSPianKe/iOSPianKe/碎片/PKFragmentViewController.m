//
//  PKFragmentViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/19.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKFragmentViewController.h"
#import "Masonry.h"
#import "PKFragmentTableView.h" // 碎片TableView


@interface PKFragmentViewController ()

@property (strong, nonatomic) PKFragmentTableView* fragmentTableView;
@property (strong, nonatomic) NSMutableArray *arr;
// nav左面的按钮和lebel
@property (strong, nonatomic) UIButton* leftBtn;
@property (strong, nonatomic) UILabel* leftLabel;
// 导航栏右边的两个btn
@property (strong, nonatomic) UIButton* commentBtn; // 写评论
@property (strong, nonatomic) UIButton* labelBtn; // 标签

@end

@implementation PKFragmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.fragmentTableView];
    
    [self navigationBtn];
    [self addAutoLayout];
    
    [self POSTHttpFragment:0];
   

    // Do any additional setup after loading the view.
}
- (void)navigationBtn {
    // 自定义导航栏左边按钮样式
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
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
    _leftLabel.text = @"碎片";
    _leftLabel.font = [UIFont systemFontOfSize:15.0];
    UIBarButtonItem* leftLa = [[UIBarButtonItem alloc] initWithCustomView:_leftLabel];
    
    // 设置左侧按钮
    [self.navigationItem setLeftBarButtonItems:@[leftBtn,leftLa] animated:YES];
    
    /***********************************************************/
    /************************自定义右侧按钮***********************/
    /***********************************************************/
    _commentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_commentBtn setImage:[UIImage imageNamed:@"写评论1"] forState:(UIControlStateNormal)];
    [_commentBtn setFrame:CGRectMake(0, 0, 40, 25)];
    
    _labelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_labelBtn setImage:[UIImage imageNamed:@"标签"] forState:(UIControlStateNormal)];
    [_labelBtn setFrame:CGRectMake(0, 0, 40, 25)];
    
    UIBarButtonItem* rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:_commentBtn];
    UIBarButtonItem* rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:_labelBtn];
    // 右侧设置多个按钮
    [self.navigationItem setRightBarButtonItems:@[rightBtn1,rightBtn2] animated:YES];
    
    
}
// nav左边按钮所响应的事件
- (void)leftAction:(id)sender {
    // 跳到抽屉
    [self presentLeftMenuViewController:nil];
}
// 自适应TableView
- (void)addAutoLayout {
    WS(weakSelf);
    [_fragmentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
}

- (void)POSTHttpFragment:(NSInteger)start {
    NSString* start1 = [NSString stringWithFormat:@"%d",start];
    // 创建请求参数
    NSDictionary* dic = @{
                          @"auth":	@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                          @"client":@"1",
                          @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                          @"limit":@"10",
                          @"start":start1,
                          @"version":@"3.0.6"
                          };
    // POST请求数据
    [self POSTHttpRequest:@"http://api2.pianke.me/timeline/list" dic:dic successBalck:^(id JSON) {
//        NSLog(@"%@",JSON);
        NSDictionary* dic = JSON;
        if ([dic[@"result"] integerValue] == 1) {
        NSDictionary* data = dic[@"data"];
        NSArray* list = data[@"list"];

        if(_arr == nil) {
            _arr = [NSMutableArray array];
        }
        [_arr addObjectsFromArray:list];
        self.fragmentTableView.dataArray = self.arr;
        // 刷新UI放到主线程里
        dispatch_async(dispatch_get_main_queue(), ^{
            // 刷新tableView
            [self.fragmentTableView reloadData];
        });
        
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
// 碎片TableView
- (PKFragmentTableView *)fragmentTableView {
    if (!_fragmentTableView) {
        _fragmentTableView = [[PKFragmentTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        
    }
    return _fragmentTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
