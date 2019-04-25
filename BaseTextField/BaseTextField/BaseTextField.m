//
//  TextFieldTool.m
//  
//  Created by damai on 2018/8/30.
//  Copyright © 2018年 damai. All rights reserved.

#import "BaseTextField.h"
// 输入限制
typedef NS_ENUM(NSInteger, LimitType){
    LimitTypeNone             = 0,              // 全字符
    LimitTypeCHZN             = 1 << 0,         // 只能输入中文
    LimitTypeLetter           = 1 << 1,         // 只能输入字母
    LimitTypeNumber           = 1 << 2,         // 只能输入数字
    LimitTypeMoney           = 1 << 3,          // 只能输入数字和.
    LimitTypePunctuation      = 1 << 4,         // 只能输入标点
    LimitTypeCHZNOrNumOrLetter      = 1 << 5,   // 只能输入中文英文数字
};

@implementation NSString (Validate)

#pragma mark - 输入限制
// 中文
- (BOOL)isCHZN{
    
    NSString *regexStr = @"^[\\u4e00-\\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 字母
- (BOOL)isLetter{
    
    NSString *regexStr = @"^[A-Za-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 数字
- (BOOL)isNumber{
    
    NSString *regexStr = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 标点符号
- (BOOL)isPunctuation{
    
    NSString *regexStr = @"^[[:punct:]]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 输入金额
- (BOOL)isPrice{
 
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

#pragma mark - 输入校验
// 密码
- (BOOL)isPassword{

    //NSString *tmpRegex = @"^[a-zA-Z]\\w{6,18}$";必须字母开始
    //NSString *tmpRegex = @"^[0-9A-Za-z]{6,18}$";
    NSString *regexStr = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 验证码（6位）
- (BOOL)isVerificationCode{
    
    NSString *regexStr = @"^[0-9]{6}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 邮箱
- (BOOL)isEmail{

    NSString *regexStr = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}


// 电话
- (BOOL)isTel{
    
    NSString *regexStr = @"^((\\(\\d{2,3}\\))|(\\d{3}\\-))?(\\(0\\d{2,3}\\)|0\\d{2,3}-)?[1-9]\\d{6,7}(\\-\\d{1,4})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 手机
- (BOOL)isPhone{
    
    if (self.length != 11){ return NO; }
    NSString *regexStr = @"^(1[3456789][0-9])\\d{8}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 金额
- (BOOL)isMoney{
    
    NSString *regexStr = @"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

// 身份证
- (BOOL)isIDCard{
    
    NSString *regexStr = @"^\\d{15}|\\d{18}|\\d{17}(\\d|X|x)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

//中英文数字
-(BOOL)isCHZNOrNumberOrLetter{
    NSString *regexStr = @"/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/";
    //NSString *reg = @"/^[A-Za-z0-9\u4e00-\u9fa5]+$/";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}

//对系统键盘做判断
-(BOOL)isSystem{
    
    if ([@"➋➌➏➎➍➐➑➒" containsString:self]) {
        return YES;
    }
    return NO;
}

-(BOOL)isRightChar:(int)a{
    
    if ((a >= 0x4e00 && a <= 0x9fa5) || (a>=65 && a<91) || (a>=97 && a<123) || (a>=48 && a<58)) {
        return YES;
    }
    return NO;
}
@end

@interface BaseTextField()<UITextFieldDelegate>

@property(nonatomic, assign)LimitType limitType;

@end
@implementation BaseTextField

- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initialize];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
    //设置默认值
    self.inputType = InputTypeNone;
    self.secureTextEntry = NO;
    self.delegate = self;
    self.textAlignment = NSTextAlignmentLeft;
    //设置边框和颜色
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.font = [UIFont systemFontOfSize:15];
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

// 占位文字颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    [self setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}


// 设置输入类型 1.确定键盘类型，2.输入类型限制，3.输入长度限制
- (void)setInputType:(InputType)inputType{
    _inputType = inputType;
    switch (_inputType) {
        case InputTypeNone:
            self.placeholder = @"请输入内容";
            self.limitType = LimitTypeNone;
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case InputTypePhoneNumber:
            self.maxLength = 11;
            self.placeholder = @"请输入手机号码";
            self.limitType = LimitTypeNumber;
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case InputTypePassword:
            self.minLength = 6;
            self.maxLength = 18;
            self.placeholder = @"请输入密码";
            self.limitType = LimitTypeNumber | LimitTypeLetter;
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.secureTextEntry = YES;
            break;
        case InputTypeVerifyCode:
            self.maxLength = 4;
            self.placeholder = @"请输入验证码";
            self.limitType = LimitTypeNumber;
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case InputTypeMoney:
            self.placeholder = @"请输入金额";
            self.limitType = LimitTypeMoney;
            self.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case InputTypeIdCard:
            self.placeholder = @"请输入身份证号码";
            self.limitType = LimitTypeLetter | LimitTypeNumber;
            self.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        case InputTypeEmail:
            self.placeholder = @"请输入邮箱";
            self.limitType = LimitTypeLetter | LimitTypeNumber | LimitTypePunctuation;
            self.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        case InputTypeCHZNOrNumberOrLetter:
            self.placeholder = @"请输入内容";
            self.limitType = LimitTypeCHZNOrNumOrLetter;
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        default:
            break;
    }
}

//监听输入变化
-(void)textFieldDidChange:(UITextField*)textField {
    
    if (!self.isFirstResponder) return ;
    if (self.textFieldDidChangeBlock) {
        self.textFieldDidChangeBlock(textField.text);
    }
    NSString *tempString = textField.text;
    if (textField.markedTextRange == nil && tempString.length > self.maxLength && self.maxLength > 0){
        textField.text = [tempString substringToIndex:self.maxLength];
    }
}

#pragma mark - private
// 是否允许输入
-(BOOL)suitableInput:(NSString *)text{
    
    // 全字符
    if (self.limitType == LimitTypeNone) {
        return YES;
    }
    // 输入中文
    if ((self.limitType & LimitTypeCHZN) == LimitTypeCHZN) {
        if ([text isCHZN] || [text isSystem]) {
            return YES;
        }
    }
    // 输入字母
    if ((self.limitType & LimitTypeLetter) == LimitTypeLetter) {
        if ([text isLetter]) {
            return YES;
        }
    }
    // 输入数字
    if ((self.limitType & LimitTypeNumber) == LimitTypeNumber) {
        if ([text isNumber]) {
            return YES;
        }
    }
    // 输入数字和.
    if ((self.limitType & LimitTypeMoney) == LimitTypeMoney) {
        if ([text isPrice]) {
            return YES;
        }
    }
    // 输入标点符号
    if ((self.limitType & LimitTypePunctuation) == LimitTypePunctuation) {
        if ([text isPunctuation]) {
            return YES;
        }
    }
    // 输入中文英文数字
    if ((self.limitType & LimitTypeCHZNOrNumOrLetter) == LimitTypeCHZNOrNumOrLetter) {
        if ([text isNumber] || [text isCHZN] || [text isSystem] || [text isLetter]) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - TextField代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.shouldBeginEditing) {
        return self.shouldBeginEditing(textField);
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (self.didBeginEditingBlock) {
        self.didBeginEditingBlock(textField);
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (self.shouldEndEditingBlock) {
       return self.shouldEndEditingBlock(textField);
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.didEndEditingBlock) {
        self.didEndEditingBlock(textField);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0){
    
    if (self.didEndEditingBlock) {
        self.didEndEditingBlock(textField);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.shouldChangeCharactersInRangeBlock) {
       return self.shouldChangeCharactersInRangeBlock(textField, range, string);
    }
    //允许回车，不然回车健用不了；允许空字符串，不然删除健用不了
    if ([string isEqualToString:@"\n"] || [string isEqualToString:@""]){
        return YES;
    }
    //输入限制
    if (!self.markedTextRange) {
        if (self.maxLength > 0 && textField.text.length > self.maxLength) {
            return NO;
        }
    }
    
    //金额输入
    if (self.inputType == InputTypeMoney) {
        
        if ([string length] > 0) {
            
            unichar single = [string characterAtIndex:0];
            if ([self suitableInput:string]) {
                
                //首字母为0和小数点时自动补齐
                if([textField.text length] == 0){
                    if(single == '.') {
                        textField.text = @"0.";
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    if (single == '0') {
                        textField.text = @"0.";
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                //输入的字符是否是小数点
                if (single == '.') {
                    //输入的字符是否已包含小数点
                    if([self isMoneyDot:textField.text]){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if ([self isMoneyDot:textField.text]) {//存在小数点
                        //判断小数点的位数
                        NSRange ran = [textField.text rangeOfString:@"."];
                        if (range.location - ran.location <= 2) {
                            return YES;
                        }else{
                            
                            return NO;
                        }
                    }else{
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }else{
            return YES;
        }
    }
    
    if (!self.markedTextRange) {
        NSString *text = [self.text stringByReplacingCharactersInRange:range withString:string];
        if (self.maxLength > 0 && text.length > self.maxLength) {
            return NO;
        }
    }
     return [self suitableInput:string];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if (self.shouldClearBlock) {
        return self.shouldClearBlock(textField);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    if (self.shouldReturnBlock) {
        return self.shouldReturnBlock(textField);
    }
    return YES;
}

//判断包含.
- (BOOL)isMoneyDot:(NSString*)text{
    if([text rangeOfString:@"."].location !=NSNotFound){
        return YES;
    }else{
        return NO;
    }
}

/**
 *手动效验字符串合法性
 *regex : 正则字符串，为空则使用默认正则验证，不为空使用传入的正则验证
 *
 */
- (CheckState)legalWithRegex:(NSString*)regex{
    
    // 1.空字符串
    if (self.text.length <= 0) {
        return CheckStateEmpty;
    }
    // 2.超出限制范围
    if (self.maxLength > 0 && (self.text.length < self.minLength || self.text.length > self.maxLength)) {
        return CheckStateNotInLimit;
    }
    
    // 自定义正则效验
    if (regex) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if (![predicate evaluateWithObject:self.text]) {
            return CheckStateNotRegular;
        }
    }
    
    // 3.正则校验
    if ((self.inputType == InputTypePhoneNumber && ![self.text isPhone]) ||
        (self.inputType == InputTypePassword  && ![self.text isPassword]) ||
        (self.inputType == InputTypeVerifyCode  && ![self.text isVerificationCode]) ||
        (self.inputType == InputTypeCHZNOrNumberOrLetter && ![self.text isCHZNOrNumberOrLetter]) || (self.inputType == InputTypeMoney && ![self.text isMoney]) || (self.inputType == InputTypeIdCard && ![self.text isIDCard]) || (self.inputType == InputTypeEmail && ![self.text isEmail])){
        return CheckStateNotRegular;;
    }
    return CheckStateNormal;
}



@end
