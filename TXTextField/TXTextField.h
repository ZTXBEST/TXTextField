//
//  TXTextField.h
//  TXTextField
//
//  Created by 赵天旭 on 16/10/24.
//  Copyright © 2016年 ZTX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didPressedReturn)(UITextField *);

@interface TXTextField : UITextField

/**
 *  Optional 点击return的回调block 根据自己需求
 */
@property (nonatomic, copy) didPressedReturn didPressedReturnCompletion;

/**
 *  Optional  匹配的邮箱类型后缀默认是RGB为170 170 170的颜色，可自行设置
 */
@property (nonatomic, strong) UIColor * mailMatchColor;

/**
 *  邮箱匹配类型
 */
@property (nonatomic, strong) NSMutableArray *mailTypeArray;

/**
 *  textField外观样式,默认为RoundedRect
 */
@property (nonatomic, assign) UITextBorderStyle style;

/**
 *  通过手写创建textField时候调用
 *
 *  @param frame    frame大小
 *  @param fontSize textField大小
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize;

@end
