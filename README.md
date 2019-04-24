# BaseTextField
## 效果图
![展示](https://github.com/qianfei1993/BaseTextField/edit/master/BaseTextField/image.png)


## 介绍&使用
#### BaseTextField,封装的UITextField基类，设置输入限制，结果效验，默认的Placeholder，配置公共项，并将常用delegate方法转为block，使用更为简单方便，一行代码满足输入需求；
#### 创建UITextField继承自BaseTextField，配置输入类型即可；
```
#pragma mark —————BaseTextField—————
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

```

