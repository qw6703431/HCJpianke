//
//  PKHomeViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/14.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKHomeViewController.h"
#import "PKLeftMenuViewController.h" // 左侧菜单
#import "RESideMenu.h" // 抽屉第三方
#import "Masonry.h" // 自动适配第三方
#import "PKFragmentView.h" // 碎片View
#import "PKRadioView.h" // 电台View
#import "PKGoodView.h" // 良品View

@interface PKHomeViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) PKFragmentView* fragmenView;

@property (strong, nonatomic) PKRadioView* radioView;

@property (strong, nonatomic) PKGoodView* goodView;

@property (strong, nonatomic) UIScrollView* scrollView;
// nav左面的按钮和lebel
@property (strong, nonatomic) UIButton* leftBtn;
@property (strong, nonatomic) UILabel* leftLabel;
// nav右面的三个btn
@property (strong, nonatomic) UIButton* btn1;
@property (strong, nonatomic) UIButton* btn2;
@property (strong, nonatomic) UIButton* btn3;

@end

@implementation PKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationBtn];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:self.fragmenView];
    [_scrollView addSubview:self.radioView];
    [_scrollView addSubview:self.goodView];

    // 开启用户交互
    _scrollView.userInteractionEnabled = YES;
    // 开启分页效果
    _scrollView.pagingEnabled = YES;
    // 关闭界面反弹效果
    [_scrollView setBounces:NO];
    // 设置横向滚动条关闭
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    // 设置scollView内容视图的大小
    _scrollView.contentSize = CGSizeMake(VIEW_WIDTH*3, VIEW_HEIGHT-64);
    // 当前视图位置
    self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    self.scrollView.delegate = self;
  
    [self.view addSubview:self.scrollView];
    [self addAutoLayout];
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
    
    [_fragmenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.scrollView.mas_left);
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.height.equalTo(VIEW_HEIGHT-64);
        make.width.equalTo(VIEW_WIDTH);
    }];
    
    [_radioView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.fragmenView.mas_right);
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.height.equalTo(VIEW_HEIGHT-64);
        make.width.equalTo(VIEW_WIDTH);
    }];
    
    [_goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.radioView.mas_right);
        make.top.equalTo(weakSelf.scrollView.mas_top);
        make.height.equalTo(VIEW_HEIGHT-64);
        make.width.equalTo(VIEW_WIDTH);
    }];
    
}
// 碎片视图
- (PKFragmentView *)fragmenView {
    if (!_fragmenView) {
        _fragmenView = [[PKFragmentView alloc] init];
    }
    return _fragmenView;
}
// 电台视图
- (PKRadioView *)radioView {
    if (!_radioView) {
        _radioView = [[PKRadioView alloc] init];
    }
    return _radioView;
}
// 良品视图
- (PKGoodView *)goodView {
    if (!_goodView) {
        _goodView = [[PKGoodView alloc] init];
    }
    return _goodView;
}
// 自定义导航栏
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
    _leftLabel.text = @"19/jan.";
    _leftLabel.font = [UIFont systemFontOfSize:15.0];
    UIBarButtonItem* leftLa = [[UIBarButtonItem alloc] initWithCustomView:_leftLabel];
    
    // 设置左侧按钮
    [self.navigationItem setLeftBarButtonItems:@[leftBtn,leftLa] animated:YES];
    
    /***********************************************************/
    /************************自定义右侧按钮***********************/
    /***********************************************************/
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn1 setImage:[UIImage imageNamed:@"nav碎片"] forState:(UIControlStateNormal)];
    [_btn1 setImage:[UIImage imageNamed:@"nav碎片_sel"] forState:(UIControlStateSelected)];
    _btn1.selected = NO;
    [_btn1 setFrame:CGRectMake(0, 0, 40, 20)];
    
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn2 setImage:[UIImage imageNamed:@"nav旗1"] forState:(UIControlStateNormal)];
    [_btn2 setImage:[UIImage imageNamed:@"nav旗1_sel"] forState:(UIControlStateSelected)];
    _btn2.selected = YES;
    [_btn2 setFrame:CGRectMake(0, 0, 40, 20)];
    
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn3 setImage:[UIImage imageNamed:@"nav雷电"] forState:(UIControlStateNormal)];
    [_btn3 setImage:[UIImage imageNamed:@"nav雷电_sel"] forState:(UIControlStateSelected)];
    _btn3.selected = NO;
    [_btn3 setFrame:CGRectMake(0, 0, 40, 20)];
    
    UIBarButtonItem* rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:_btn1];
    UIBarButtonItem* rightBtn2 = [[UIBarButtonItem alloc] initWithCustomView:_btn2];
    UIBarButtonItem* rightBtn3 = [[UIBarButtonItem alloc] initWithCustomView:_btn3];
    
    // 绑定点击状态事件
    [self.btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    // 右侧设置多个按钮
    [self.navigationItem setRightBarButtonItems:@[rightBtn3,rightBtn2,rightBtn1] animated:YES];

}
// 按钮事件
- (void)btnPress:(UIButton*)sender {
    // 把当前的按钮变为选中状态
    sender.selected = YES;
    // 找到所有按钮，把按钮的选中状态取消
    for (UIButton* btn in [sender.superview subviews]) {
        if ([btn isKindOfClass:[UIButton class]] && btn != sender) {
            btn.selected = NO;
        }
    }
    
    if (sender == self.btn1) {
        self.leftLabel.text = @"碎片";
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
    } else if (sender == self.btn2) {
        self.leftLabel.text = @"19/jan.";
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
        }];
    } else {
        self.leftLabel.text = @"动态";
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = CGPointMake(VIEW_WIDTH*2, 0);
        }];
    }
    // 每次触发事件调用都切换按钮的选中状态和普通状态
    //    btn.selected = !btn.selected;
}
#pragma mark- 当scrollView滑动停止时所响应的代理事件
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 确定当前偏移位置
    NSInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    if (index == 0) {
        // 设置当前位置btn高亮
        [self btnPress:self.btn1];
        // 当前label显示内容
        self.leftLabel.text = @"碎片";
    } else if (index == 1) {
        [self btnPress:self.btn2];
        self.leftLabel.text = @"19/jan.";
    } else if (index == 2) {
        [self btnPress:self.btn3];
        self.leftLabel.text = @"动态";
    }
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
