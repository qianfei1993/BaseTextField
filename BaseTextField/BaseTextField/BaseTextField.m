//
//  TextFieldTool.m
//  
//  Created by damai on 2018/8/30.
//  Copyright © 2018年 damai. All rights reserved.

#import "BaseTextField.h"
#define kMoney  @"0123456789."
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
    
    NSString *tmpRegex = @"^[\\u4e00-\\u9fa5]+$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 字母
- (BOOL)isLetter{
    
    NSString *tmpRegex = @"^[A-Za-z]+$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 数字
- (BOOL)isNumber{
    
    NSString *tmpRegex = @"^[0-9]+$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 标点符号
- (BOOL)isPunctuation{
    
    NSString *tmpRegex = @"^[[:punct:]]+$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 限制条件
- (BOOL)isPrice{
 
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kMoney] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

#pragma mark - 输入校验
// 密码
- (BOOL)isPassword{

    //NSString *tmpRegex = @"^[a-zA-Z]\\w{6,}$";必须字母开始
    //NSString *tmpRegex = @"^[0-9A-Za-z]{6,18}$";
    NSString *tmpRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 验证码
- (BOOL)isVerificationCode{
    
    NSString *tmpRegex = @"^[0-9]{6}$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 邮箱
- (BOOL)isEmail{

    //NSString *tmpRegex = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
    NSString *tmpRegex = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 浮点数
- (BOOL)isFloat{
    
    NSString *tmpRegex = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 电话
- (BOOL)isTel{
    
    NSString *tmpRegex = @"^((\\(\\d{2,3}\\))|(\\d{3}\\-))?(\\(0\\d{2,3}\\)|0\\d{2,3}-)?[1-9]\\d{6,7}(\\-\\d{1,4})?$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:self];
}

// 手机
- (BOOL)isPhone{
    
    if (self.length != 11){ return NO; }
    //NSString *MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSString *MOBILE = @"^(1[3456789][0-9])\\d{8}";
    NSPredicate *regextestmm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmm evaluateWithObject:self];
}

// 金额
- (BOOL)isMoney{
    
    NSString *reg = @"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$";
    NSPredicate *regextestmm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [regextestmm evaluateWithObject:self];
}

// 身份证
- (BOOL)isIDCard{
    
    NSString *reg = @"^\\d{15}|\\d{18}|\\d{17}(\\d|X|x)";
    NSPredicate *regextestmm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [regextestmm evaluateWithObject:self];
}

//中英文数字
-(BOOL)isCHZNOrNumberOrLetter{
    NSString *reg = @"/^[\u4e00-\u9fa5_a-zA-Z0-9]+$/";
    //NSString *reg = @"/^[A-Za-z0-9\u4e00-\u9fa5]+$/";
    NSPredicate *regextestmm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [regextestmm evaluateWithObject:self];
}

//对系统键盘做判断
-(BOOL)isSystem{
    
    if ([@"➋➌➏➎➍➐➑➒" containsString:self]) {
        return YES;
    }
    return NO;
}

-(BOOL)isRightChar:(int)a{
    NSLog(@"%d",a);
    
    if ((a >= 0x4e00 && a <= 0x9fa5) || (a>=65 && a<91) || (a>=97 && a<123) || (a>=48 && a<58)) {
        return YES;
    }
    return NO;
}
@end

@interface BaseTextField()<UITextFieldDelegate>

@property(nonatomic, assign)LimitType limitType;
@property(nonatomic, assign)CheckState checkState;

@end
@implementation BaseTextField


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
    self.checkType = CheckNone;
    self.textAlignment = NSTextAlignmentLeft;
    
    //设置边框和颜色
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.font = [UIFont systemFontOfSize:14];
    
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.delegate = self;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    [self setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

// 效验输入类型 1.确定键盘类型，2.输入类型限制，3.输入长度限制
-(void)setCheckType:(CheckType)checkType{
    
    _checkType = checkType;
    self.secureTextEntry = NO;
    switch (_checkType) {
        case CheckNone:
            self.limitType = LimitTypeNone;
            self.keyboardType = UIKeyboardTypeDefault;
            break;
        case CheckTypePhoneNumber:
            self.maxLength = 11;
            self.limitType = LimitTypeNumber;
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case CheckTypePassword:
            self.minLength = 6;
            self.maxLength = 18;
            self.limitType = LimitTypeNumber | LimitTypeLetter;
            self.keyboardType = UIKeyboardTypeASCIICapable;
            self.secureTextEntry = YES;
            break;
        case CheckTypeVerificatioCode:
            self.maxLength = 6;
            self.limitType = LimitTypeNumber;
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case CheckTypeMoney:
            self.limitType = LimitTypeMoney;
            self.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        case CheckTypeIdCard:
            self.limitType = LimitTypeLetter | LimitTypeNumber;
            self.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        case CheckTypeEmail:
            self.limitType = LimitTypeLetter | LimitTypeNumber | LimitTypePunctuation;
            self.keyboardType = UIKeyboardTypeASCIICapable;
            break;
        case CheckTypeCHZNOrNumberOrLetter:
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
// 更新正则校验状态
-(void)updateCheckState{
    // 1.空字符串
    if (self.text.length <= 0) {
        self.checkState = CheckStateEmpty;
        return ;
    }
    // 2.超出限制范围
    if (self.maxLength > 0 && (self.text.length < self.minLength || self.text.length > self.maxLength)) {
        self.checkState = CheckStateNotInLimit;
        return ;
    }
    // 3.正则校验
    if ((self.checkType == CheckTypePhoneNumber && ![self.text isPhone]) ||
        (self.checkType == CheckTypePassword  && ![self.text isPassword]) ||
        (self.checkType == CheckTypeVerificatioCode  && ![self.text isVerificationCode]) ||
        (self.checkType == CheckTypeCHZNOrNumberOrLetter && ![self.text isCHZNOrNumberOrLetter]) || (self.checkType == CheckTypeMoney && ![self.text isMoney]) || (self.checkType == CheckTypeIdCard && ![self.text isIDCard]) || (self.checkType == CheckTypeEmail && ![self.text isEmail])){
        self.checkState = CheckStateNotRegular;
        return;
    }
    self.checkState = CheckStateNormal;
}


// 是否允许输入
-(BOOL)suitableInput:(NSString *)text{
    
    if (self.limitType == LimitTypeNone) {
        return YES;
    }
    if ((self.limitType & LimitTypeCHZN) == LimitTypeCHZN) {
        if ([text isCHZN] || [text isSystem]) {
            return YES;
        }
    }
    if ((self.limitType & LimitTypeLetter) == LimitTypeLetter) {
        if ([text isLetter]) {
            return YES;
        }
    }
    if ((self.limitType & LimitTypeNumber) == LimitTypeNumber) {
        if ([text isNumber]) {
            return YES;
        }
    }
    if ((self.limitType & LimitTypeMoney) == LimitTypeMoney) {
        if ([text isPrice]) {
            return YES;
        }
    }
    if ((self.limitType & LimitTypePunctuation) == LimitTypePunctuation) {
        if ([text isPunctuation]) {
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
    //验证字符串合法性
    if (self.block) {
        self.block(textField.text, self.checkState);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0){
    
    //校验输入结果
    [self updateCheckState];
    if (self.didEndEditingBlock) {
        self.didEndEditingBlock(textField);
    }
    //验证字符串合法性
    if (self.block) {
        self.block(textField.text, self.checkState);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //校验输入结果
    [self updateCheckState];
    if (self.shouldChangeCharactersInRangeBlock) {
       return self.shouldChangeCharactersInRangeBlock(textField, range, string);
    }
    //允许回车，不然回车健用不了；允许空字符串，不然删除健用不了
    if ([string isEqualToString:@"\n"] || [string isEqualToString:@""]){
        return YES;
    }
    
    //金额判断
    if (self.checkType == CheckTypeMoney) {
        
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

@end
