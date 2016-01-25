//
//  PKGoodProductsInfoController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKGoodProductsInfoController.h"
#import "Masonry.h"
#import "UIImageView+SDWedImage.h" // 加载网络图片

#import "PKGoodProductsViewController.h" // 良品首页
#import "PKGoodProductsInfoHeadView.h" // 头部view

@interface PKGoodProductsInfoController ()<UIScrollViewDelegate,UIWebViewDelegate>

// 返回按钮
@property (strong, nonatomic) UIButton* returnBtn;
// 装所有控件的scrollView
@property (strong, nonatomic) UIScrollView* scrollView;
// 头部view
@property (strong, nonatomic) PKGoodProductsInfoHeadView* productsInfoHeadView;
// 下边wab
@property (strong, nonatomic) UIWebView *htmlWebView;
// 存放下载数据的dic
@property (strong, nonatomic) NSDictionary *dataDic;
// 存放数据以便属性赋值
@property (strong, nonatomic) NSDictionary* dic;

@end

@implementation PKGoodProductsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;

    //创建webView并添加到scroller上面
    self.htmlWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 170, VIEW_WIDTH, VIEW_HEIGHT)];
    self.htmlWebView.delegate = self;
    [self.scrollView addSubview:self.htmlWebView];
    [self.scrollView addSubview:self.productsInfoHeadView];

    [self.view addSubview:self.scrollView];
    
    
    [self POSTHttpGoodProductsInfo];
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
        make.size.equalTo(CGSizeMake(VIEW_WIDTH, 170));
    }];
    
}
-(NSDictionary *)dic {
    if (_dic == nil) {
        _dic = [[NSDictionary alloc] init];
        _dic = self.dataDic;
    }
    return _dic;
}
// POST 请求
- (void)POSTHttpGoodProductsInfo {
    //制作请求参数
    NSDictionary* requestDic = @{@"auth":@"W8c8Fivl9flDCsJzH8HukzJxQMrm3N7KP9Wc5WTFjcWP229VKTBRU7vI",
                                 @"client":@"1",
                                 @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                                 @"contentid":self.contentID,
                                 @"version":@"3.0.6"};
    WS(weakSelf);
    [self POSTHttpRequest:@"http://api2.pianke.me/group/posts_info" dic:requestDic successBalck:^(id JSON) {
        NSDictionary *returnDic = JSON;
        if ([returnDic[@"result"] integerValue] == 1) {
            weakSelf.dataDic = [returnDic[@"data"] valueForKey:@"postsinfo"];
        
            // 解析请求成功的参数
            NSDictionary* dic = self.dataDic;
            
            // 属性赋值
            _productsInfoHeadView.timeLabel.text = dic[@"addtime_f"];
            _productsInfoHeadView.titleLabel.text = dic[@"title"];
            _productsInfoHeadView.nameLabel.text = [dic[@"userinfo"] valueForKey:@"uname"];
            [_productsInfoHeadView.iconImage downloadImage:[dic[@"userinfo"] valueForKey:@"icon"]];
//            NSLog(@"%@",_dic);
//            NSLog(@"%@",weakSelf.dataDic);
            NSString *htmlString = [self getHtmlString:weakSelf.dataDic[@"html"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.htmlWebView loadHTMLString:htmlString baseURL:nil];
            });
            
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(NSString*)getHtmlString:(NSString *)routeName{
    
    NSMutableString* tmpMutable = [NSMutableString stringWithString:routeName];
    NSRange range = [tmpMutable rangeOfString:@"<a "];
    while (range.location != NSNotFound) {
        
        [tmpMutable replaceCharactersInRange:range
                                  withString:@"<a style=\"background:green; color:white; line-height:35px; border-radius:5px; height:50x; display:block;\" "];
        range = [tmpMutable rangeOfString:@"<a " options:NSLiteralSearch range:NSMakeRange(range.location+3, routeName.length-range.location-3)];
        
    }
    
    range = [tmpMutable rangeOfString:@"<img"];
    while (range.location != NSNotFound) {
        
        [tmpMutable replaceCharactersInRange:range
                                  withString:@"<img width=100% "];
        range = [tmpMutable rangeOfString:@"<img" options:NSLiteralSearch range:NSMakeRange(range.location+4, routeName.length-range.location-4)];
        
    }
    
    return tmpMutable;
}
// 网页加载完之后事件
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    CGRect frame = webView.frame;
    frame.size.width = VIEW_WIDTH;
    frame.size.height = 1;
    webView.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    
    frame.size.height = webView.scrollView.contentSize.height;
    webView.frame = frame;
    _scrollView.contentSize = CGSizeMake(0, frame.size.height + 170);
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



















