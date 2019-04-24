//
//  ViewController.m
//  QFTextField
//
//  Created by damai on 2018/9/4.
//  Copyright © 2018年 personal. All rights reserved.
//

#import "ViewController.h"
#import "BaseTextField.h"
@interface ViewController ()

// 不做验证
@property (weak, nonatomic) IBOutlet BaseTextField *typeNoneTextField;

// 自定义验证类型
@property (weak, nonatomic) IBOutlet BaseTextField *typeCustomTextField;

// 手机号输入验证
@property (weak, nonatomic) IBOutlet BaseTextField *typePhoneNumTextField;

// 密码输入验证
@property (weak, nonatomic) IBOutlet BaseTextField *typePasswordTextField;

// 金额输入验证
@property (weak, nonatomic) IBOutlet BaseTextField *typeMoneyTextField;

// 身份证输入验证
@property (weak, nonatomic) IBOutlet BaseTextField *typeIdCardTextField;

// 邮箱输入验证
@property (weak, nonatomic) IBOutlet BaseTextField *typeEmailTextField;

// 限制输入中文-字母-数字
@property (weak, nonatomic) IBOutlet BaseTextField *typeCHTextField;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不做验证
    self.typeNoneTextField.inputType = InputTypeNone;
    
    // 自定义验证类型
    //输入类型
    self.typeCustomTextField.inputType = InputTypeNone;
    //placeholder内容
    self.typeCustomTextField.placeholder = @"我不是默认Placeholder";
    //placeholder颜色
    self.typeCustomTextField.placeholderColor = [UIColor redColor];
    //允许输入的最小值
    self.typeCustomTextField.minLength = 5;
    //允许输入的最大值
    self.typeCustomTextField.maxLength = 16;
    
    
    // 手机号输入验证
    self.typePhoneNumTextField.inputType = InputTypePhoneNumber;
    
   
    // 密码输入验证
    self.typePasswordTextField.inputType = InputTypePassword;
    
    // 金额输入验证
    self.typeMoneyTextField.inputType = InputTypeMoney;
    
    // 身份证输入验证
    self.typeIdCardTextField.inputType = InputTypeIdCard;
    
    // 邮箱输入验证
    self.typeEmailTextField.inputType = InputTypeEmail;
    
    // 限制输入中文-字母-数字
    self.typeCHTextField.inputType = InputTypeCHZNOrNumberOrLetter;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    // 手动验证手机号码输入合法性
    BOOL isLegal = [self isLegal];
}


- (BOOL)isLegal{
    // 手动验证手机号码输入合法性
    CheckState state = [self.typePhoneNumTextField legalWithRegex:nil];
    if (state == CheckStateNormal) {
        self.resultLabel.text = @"输入内容合法";
        return YES;
    }
    if (state == CheckStateEmpty) {
        self.resultLabel.text = @"输入内容为空";
    }
    if (state == CheckStateNotInLimit) {
        self.resultLabel.text = @"输入内容必须在限制字以内";
    }
    if (state == CheckStateNotRegular) {
        self.resultLabel.text = @"输入内容不合法";
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
