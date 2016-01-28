//
//  PKFragmentTableView.m
//  iOSPianKe
//
//  Created by ma c on 16/1/20.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKFragmentTableView.h"
#import "PKFragmentTableViewCell.h" // 自定义cell（碎片）

#import "UIImageView+SDWedImage.h" // 加载网络图片
#import "NSString+Helper.h" // NSString扩展

#import "MJRefresh.h" // MJ刷新公共类
#import "MJChiBaoZiHeader.h" // 头部刷新
#import "MJChiBaoZiFooter2.h" // 底部刷新

@interface PKFragmentTableView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* imageSizeArray;

@property (strong, nonatomic) NSMutableArray* imageHeArray;

@property (strong, nonatomic) NSMutableArray* labelHeArray;

@end

@implementation PKFragmentTableView

- (NSMutableArray *)labelHeArray {
    if (_labelHeArray == nil) {
        _labelHeArray = [[NSMutableArray alloc] init];
        for (NSDictionary* dic in self.dataArray) {
            // 调用NSString扩展类别NSString+Helper.h的方法
            // 该方法是计算label的高度
            CGFloat labelHe = [NSString autoHeightWithString:dic[@"content"] Width:VIEW_HEIGHT-50 Font:[UIFont systemFontOfSize:17.0]];
            NSString* str = [NSString stringWithFormat:@"%f",labelHe];
            [_labelHeArray addObject:str];
        }
    }
    return _labelHeArray;
}

- (NSMutableArray *)imageHeArray {
    if (_imageHeArray == nil) {
        _imageHeArray = [[NSMutableArray alloc] init];
        NSMutableArray* muArray = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<self.imageSizeArray.count; i++) {
            // 如果没有图片将默认高度定位负值
            CGFloat imageH = -10.0;
            // 判断是否为空
            if (![self.imageSizeArray[i] isEmptyString]) {
                NSString *ImageSize = self.imageSizeArray[i];
                // 字符串截取
                NSArray *array = [ImageSize componentsSeparatedByString:@"*"];
                // 根据宽高比计算高度
                imageH = [array[1] floatValue]*((VIEW_WIDTH-40.0)/[array[0] floatValue]);
            } 
            // 转换成number类型存入可变数组
            NSNumber* imageSizeNumber = [NSNumber numberWithFloat:imageH];
            [muArray addObject:imageSizeNumber];
        }
        [_imageHeArray addObjectsFromArray:muArray];
    }
    return _imageHeArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        // 注册代码实现的cell ，要使用registerClass
        [self registerClass:[PKFragmentTableViewCell class] forCellReuseIdentifier:@"cell"];
        // 关闭表格的分割线
        self.separatorStyle = NO;
      
        self.backgroundColor = [UIColor whiteColor];
        //添加mj刷新
        [self addRefreshControl];
      
    }
    return self;
}
#pragma mark- MJ刷新
- (void)addRefreshControl {
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader* header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
    self.mj_header = header;
    // 设置上拉加载的动画
    MJChiBaoZiFooter2* footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    // 开启屏幕透明度
    self.mj_footer.automaticallyChangeAlpha = YES;
    self.mj_footer = footer;
}

#pragma mark - Table view data source
// 分区
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"cell";
    
    PKFragmentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    // 关闭表格选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    // 新建字典接收数组的每个元素
    NSDictionary* dic = self.dataArray[indexPath.row];
    // 拿到字典里的userinfo的key 里面包括头像、id和昵称
    NSDictionary* nameDic = dic[@"userinfo"];
    
    // 加载网络图片方法（UIImageView+SDWedImage中）
    [cell.iconImage downloadImage:nameDic[@"icon"]];
    
    cell.nameLabel.text = nameDic[@"uname"];
    
    // 获取时间
    cell.timeLabel.text = dic[@"addtime_f"];
    // 获取图片coverimg（coverimg_wh 图片尺寸）和文字信息content
    [cell.bigImage downloadImage:dic[@"coverimg"]];
    cell.newsLabel.text = dic[@"content"];
    // 将图片的尺寸放到可变数组里
//    [self.imageSizeArray addObject:dic[@"coverimg_wh"]];
    // 拿到counterList的key 里面包括评论数和喜欢数
    NSDictionary* counterListDic = dic[@"counterList"];
    // 由于返回数据是一个对象 所以要先转换成字符串类型才可以赋值
    NSString* likeString = [NSString stringWithFormat:@"%@",counterListDic[@"like"]];
    NSString* commentString = [NSString stringWithFormat:@"%@",counterListDic[@"comment"]];

    cell.commentBtn.imageView.image = [UIImage imageNamed:@"评论"];
    cell.commentLabel.text = commentString;
    cell.likeBtn.imageView.image = [UIImage imageNamed:@"喜欢"];
    cell.likeLabel.text = likeString;
    return cell;
}
// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.imageSizeArray = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<self.dataArray.count; i++) {
            NSDictionary* dic = self.dataArray[i];
            [self.imageSizeArray addObject:dic[@"coverimg_wh"]];
        }
        // 将图片高度的数组置为空，否则不会执行懒加载
        self.imageHeArray = nil;
        self.labelHeArray = nil;
    }
   
    CGFloat imageH = [self.imageHeArray[indexPath.row] floatValue];
    CGFloat labelH = [self.labelHeArray[indexPath.row] floatValue];
    return 135+imageH+labelH;
}
//下拉刷新全部数据
- (void)loadMoreData{
    if (_MoreDataBlock) {
        _MoreDataBlock();
    }
}
//上拉加载更多数据
- (void)loadNewData{
    if (_NewDataBlock) {
        _NewDataBlock();
    }
}


@end
