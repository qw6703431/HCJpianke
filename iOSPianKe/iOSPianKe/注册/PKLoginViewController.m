//
//  PKLoginViewController.m
//  iOSPianKe
//
//  Created by ma c on 16/1/18.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import "PKLoginViewController.h"
#import "Masonry.h"
#import "PKLoginView.h" // 头像下的所有view
#import "PKLoginHeadView.h" // 头部view
#import "PKLandingViewController.h" // 登陆界面

@interface PKLoginViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) PKLandingViewController* landingViewController;

@property (strong, nonatomic) PKLoginView* loginView;

@property (strong, nonatomic) PKLoginHeadView* loginHeadView;

@property (strong, nonatomic) NSString* imageFiled;

@end

@implementation PKLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loginHeadView];
    [self.view addSubview:self.loginView];
    
    WS(weakSelf);
    [_loginHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top);
        make.bottom.equalTo(weakSelf.loginView.mas_top);
    }];
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-35);
        make.height.equalTo(330);
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PKLoginHeadView *)loginHeadView {
    if (!_loginHeadView) {
        _loginHeadView = [[PKLoginHeadView alloc] init];
        [_loginHeadView.returnBtn addTarget:self action:@selector(returnLandingViewController) forControlEvents:(UIControlEventTouchUpInside)];
        [_loginHeadView.iconImageBtn addTarget:self action:@selector(imageBtnMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginHeadView;
}
// 返回按钮响应方法
- (void)returnLandingViewController {
    // 回到上一视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (PKLoginView *)loginView {
    if (!_loginView) {
        _loginView = [[PKLoginView alloc] init];
        _loginView.userNameText.delegate = self;
        _loginView.emailText.delegate = self;
        _loginView.passwordText.delegate = self;
        [_loginView.finishBtn addTarget:self action:@selector(loginHttpRequest) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginView;
}
- (void)loginHttpRequest {
    // 点击完成的时候隐藏键盘
        [self disMissKeyboard];
    // 判断文本框是否有值
    if ([_loginView.userNameText.text isEmptyString]) {
        // 一个显示view 前面为显示内容中间未显示时间最后为显示位置
        // top（顶部）center（中间）bottom（底部）
        [self.view makeToast:@"昵称不能为空" duration:1 position:@"center"];
    } else if ([_loginView.emailText.text isEmptyString]) {
        [self.view makeToast:@"邮箱不能为空" duration:1 position:@"center"];
    } else if ([_loginView.passwordText.text isEmptyString]) {
        [self.view makeToast:@"密码不能为空" duration:1 position:@"center"];
        
    } else if (// 判断头像是否是原图（是否被更改过）
               [_loginHeadView.iconImageBtn.currentImage isEqual:[UIImage imageNamed:@"上传图片"]]) {
        [self.view makeToast:@"头像不能为空" duration:1 position:@"center"];
    } else {
        WS(weakSelf);
        [ZJPBaseHttpTool postImagePath:@"http://api2.pianke.me/user/reg" params:[self makeLoginRequestDic] image:_imageFiled success:^(id JSON) {
            NSDictionary *returnDic = JSON;
            //判断是否成功，如果result为 1 ，注册成功，result为0，查看返回字典中data字段中msg的错误原因
            if ([returnDic[@"result"] integerValue] == 1) {
                //成功后的提示框，方法在 UIView+Toast 中，第一个参数是提示的内容，第二个是显示时间，第三个是显示位置，一共有三个
                [_landingViewController.view makeToast:@"注册成功" duration:1 position:@"center"];
                // 返回登陆界面
//                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
               [weakSelf.view makeToast:[returnDic[@"data"] valueForKey:@"msg"] duration:1 position:@"center"];
            }
        } failure:^(NSError *error) {
            [weakSelf.view makeToast:@"注册失败" duration:1 position:@"center"];
        }];
    }
}

- (NSDictionary*)makeLoginRequestDic{
        NSDictionary* dic = @{@"client":@"1",
                                                        @"deviceid":@"A55AF7DB-88C8-408D-B983-D0B9C9CA0B36",
                                                         @"email":_loginView.emailText.text,
                                                        @"gender":@"1",
                                                        @"passwd":_loginView.passwordText.text,
                                                         @"uname":_loginView.userNameText.text,
                                                         @"version":@"3.0.6",
                                                        @"auth":@"",
                                                        @"iconfile":_imageFiled};
        return dic;
}
#pragma mark - 调用相机相册
//判断是从相册还是相机获取图片
- (void)imageBtnMethod{
    UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选择", nil];
    //设置哪一个显示红色文字提示4225836921
    sheet.destructiveButtonIndex = -1;
    [sheet showInView:self.view];
}
//actionSheet的代理方法，每一个buttonindex的点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 相机拍照
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if (buttonIndex == 1){
        // 相册选择
        UIImagePickerController* imagePicker=[[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
        imagePicker.allowsEditing=YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
// 当文本框将要进行编辑的时候调用这个方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    WS(weakSelf);
    if (textField == _loginView.emailText) {
        // 第一个参数是时间
        // block体是屏幕上移或下移的方法
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 50;
            weakSelf.view.bounds = rect;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = weakSelf.view.bounds;
            rect.origin.y = 100;
            weakSelf.view.bounds = rect;
        }];
    }
    return YES;
}
//UIImagePickerController的代理方法，选择好照片后会调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 获得图片
    UIImage* editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    // 获取沙盒目录
    NSString* homePath = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
//    NSLog(@"------------%@",homePath);
    // 将图片名字拼接到路径后面
    NSString* imageViews   = [homePath stringByAppendingFormat:@"/%d.png", arc4random_uniform(1000000)];
    // 将图片写入沙盒
    [UIImageJPEGRepresentation(editedImage, 1.0f) writeToFile:imageViews atomically:YES];
    // 将图片路径保存下来，因为在上传图片的时候会用到
    self.imageFiled = imageViews;
    // 更新imageBtn的图片
    [_loginHeadView.iconImageBtn setImage:editedImage forState:(UIControlStateNormal)];
    // 关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 点击return隐藏键盘（前提是textField遵从代理方法UITextFieldDelegate）
- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [_loginView.userNameText resignFirstResponder];
    [_loginView.emailText resignFirstResponder];
    [_loginView.passwordText resignFirstResponder];
    
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
    return YES;
}
// 点击空白隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_loginView.userNameText resignFirstResponder];
    [_loginView.emailText resignFirstResponder];
    [_loginView.passwordText resignFirstResponder];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = weakSelf.view.bounds;
        rect.origin.y = 0;
        weakSelf.view.bounds = rect;
    }];
}
//隐藏键盘的方法
- (void)disMissKeyboard{
    [_loginView.emailText resignFirstResponder];
    [_loginView.passwordText resignFirstResponder];
    [_loginView.userNameText resignFirstResponder];
}
//// 点击屏幕触发方法
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    // 回到上一视图
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


@end
