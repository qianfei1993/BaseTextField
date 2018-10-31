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
@property (weak, nonatomic) IBOutlet BaseTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet BaseTextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //手机号输入
    //效验手机号类型
    self.phoneTextField.checkType = CheckTypePhoneNumber;
    //效验结果
    self.phoneTextField.block = ^(NSString *string, NSInteger CheckState) {
        NSLog(@"%@",string);
        if (CheckState == CheckStateEmpty) {
            self.resultLabel.text = @"输入内容为空";
        }else if (CheckState == CheckStateNotInLimit) {
            self.resultLabel.text = @"输入内容必须在限制字以内";
        }else if (CheckState == CheckStateNotRegular) {
            self.resultLabel.text = @"输入内容不合法";
        }else if (CheckState == CheckStateNormal) {
            self.resultLabel.text = @"输入内容合法";
        }
    };
    
    
    //效验类型
    self.textField.checkType = CheckNone;
    //placeholder颜色
    self.textField.placeholderColor = [UIColor redColor];
    //允许输入的最小值
    self.textField.minLength = 5;
    //允许输入的最大值
    self.textField.maxLength = 16;
    //回调结果   输入内容：string，效验结果：CheckState
    self.textField.block = ^(NSString *string, NSInteger CheckState) {
        NSLog(@"%@",string);
        if (CheckState == CheckStateEmpty) {
            self.resultLabel.text = @"输入内容为空";
        }else if (CheckState == CheckStateNotInLimit) {
            self.resultLabel.text = @"输入内容必须在限制字以内";
        }else if (CheckState == CheckStateNotRegular) {
            self.resultLabel.text = @"输入内容不合法";
        }else if (CheckState == CheckStateNormal) {
            self.resultLabel.text = @"输入内容合法";
        }
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneTextField resignFirstResponder];
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
