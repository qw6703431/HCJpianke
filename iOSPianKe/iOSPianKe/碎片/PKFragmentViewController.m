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
@end

@implementation PKFragmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.fragmentTableView];
    [self addAutoLayout];
    
    [self POSTHttpFragment:0];
   

    // Do any additional setup after loading the view.
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
