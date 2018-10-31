//
//  TextFieldTool.h
//  
//
//  Created by damai on 2018/8/30.
//  Copyright © 2018年 damai. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^textFieldBlock)(NSString *string,NSInteger CheckState);
@interface BaseTextField : UITextField

/**
 * TextField效验类型
 *
 */
typedef NS_ENUM(NSInteger, CheckType){
    CheckNone,                      // 不做校验(默认)
    CheckTypePhoneNumber,           // 手机号码效验 （默认11位数字）
    CheckTypePassword,              // 密码(字母和数字的组合，不能使用特殊字符，默认长度6-18)
    CheckTypeVerificatioCode,       // 验证码（默认6位数字）
    CheckTypeMoney,                 // 人民币金额验证（小数点后最多两位，第一位输入0或.自动补齐）
    CheckTypeIdCard,                // 身份证验证
    CheckTypeEmail,                 // 邮箱验证
    CheckTypeCHZNOrNumberOrLetter,  // 限制输入中文-字母-数字
};

/**
 * TextField效验结果
 *
 */
typedef NS_ENUM(NSInteger, CheckState){
    CheckStateEmpty,            //空内容
    CheckStateNormal,           //合法
    CheckStateNotInLimit,       //不符合输入限制
    CheckStateNotRegular,       //不符合正则验证
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
 * 设置正则匹配模式（如果设置正则模式，则忽略其他格式限制）
 *
 */
//@property (nonatomic, copy) NSString * pattern;

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
 *设置效验类型
 *
 */
@property(nonatomic, assign)CheckType checkType;

/**
 *输入完成
 *
 */
@property(nonatomic, copy)textFieldBlock block;

/**
 *textField内容发生改变block回调
 *
 */
@property (nonatomic, copy) void (^textFieldDidChangeBlock)(NSString *text);


@end
