//
//  TextFieldTool.h
//  
//
//  Created by damai on 2018/8/30.
//  Copyright © 2018年 damai. All rights reserved.

#import <UIKit/UIKit.h>

@interface BaseTextField : UITextField

/**
 * TextField限制输入类型
 *
 */
typedef NS_ENUM(NSInteger, InputType){
    InputTypeNone,                  // 不做校验(默认)
    InputTypePhoneNumber,           // 手机号码效验 （默认11位数字）
    InputTypePassword,              // 密码(字母或数字，默认长度6-18)
    InputTypeVerifyCode,            // 验证码（默认6位数字）
    InputTypeMoney,                 // 人民币金额验证（小数点后最多两位，第一位输入0或.自动补齐）
    InputTypeIdCard,                // 身份证验证
    InputTypeEmail,                 // 邮箱验证
    InputTypeCHZNOrNumberOrLetter,  // 限制输入中文-字母-数字
};

/**
 * TextField效验结果类型
 *
 */
typedef NS_ENUM(NSInteger, CheckState){
    CheckStateEmpty,           // 输入内容为空
    CheckStateNotInLimit,      // 输入内容不在限制长度以内
    CheckStateNotRegular,      // 输入内容不合法
    CheckStateNormal           // 输入内容合法
};



/**
 * 代理转block
 *
 */
@property (nonatomic, copy) BOOL (^shouldBeginEditing)(UITextField *textField);

@property (nonatomic, copy) BOOL (^shouldEndEditingBlock)(UITextField *textField);

@property (nonatomic, copy) void (^didBeginEditingBlock)(UITextField *textField);

@property (nonatomic, copy) void (^didEndEditingBlock)(UITextField *textField);

@property (nonatomic, copy) BOOL (^shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);

@property (nonatomic, copy) BOOL (^shouldReturnBlock)(UITextField *textField);

@property (nonatomic, copy) BOOL (^shouldClearBlock)(UITextField *textField);


/**
 *textField允许输入的最小长度 默认 0为空
 *
 */
@property (nonatomic,assign) NSInteger minLength;

/**
 *textField允许输入的最大长度 默认 0不限制
 *
 */
@property (nonatomic,assign) NSInteger maxLength;

/**
 *placeHolder设置颜色
 *
 */
@property (nonatomic,strong) UIColor *placeholderColor;

/**
 *设置输入类型
 *
 */
@property(nonatomic, assign)InputType inputType;


/**
 *textField内容发生改变block回调
 *
 */
@property (nonatomic, copy) void (^textFieldDidChangeBlock)(NSString *text);

/**
 *手动效验字符串合法性
 *regex : 正则字符串，为空则使用默认正则验证，不为空使用传入的正则验证
 *
 */
- (CheckState)legalWithRegex:(NSString*)regex;
@end
