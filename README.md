# BaseTextField
## 效果图
![展示](https://github.com/qianfei1993/BaseTextField/blob/master/BaseTextField/image.png)


## 介绍&使用
#### BaseTextField,封装的UITextField基类，配置公共项，设置默认的Placeholder，使用正则限制输入与结果效验，并将常用delegate方法转为block，使用更为简单方便，一行代码满足输入需求；
#### 创建UITextField继承自BaseTextField，配置输入类型即可；
```
#pragma mark —————BaseTextField—————
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不做验证
    self.typeNoneTextField.inputType = InputTypeNone;
    
    // 自定义限制属性
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

// 手动调用，验证输入内容的合法性
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

```

