//
//  PKMiddleLandingView.h
//  iOSPianKe
//
//  Created by ma c on 16/1/15.
//  Copyright © 2016年 赵金鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKMiddleLandingView : UIView<UITextFieldDelegate>


@property (strong, nonatomic) UILabel* lineLabel1; // 邮箱下线条
@property (strong, nonatomic) UILabel* lineLabel2; // 密码下线条
@property (strong, nonatomic) UILabel* tostLabel1; // 邮箱label
@property (strong, nonatomic) UILabel* tostLabel2; // 密码label
@property (strong, nonatomic) UITextField* emailText; // 邮箱text
@property (strong, nonatomic) UITextField* passwordText; // 密码text
@property (strong, nonatomic) UIButton* landingBtn; // 登陆按钮

@end
