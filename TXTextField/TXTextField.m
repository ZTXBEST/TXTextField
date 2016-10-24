//
//  TXTextField.m
//  TXTextField
//
//  Created by 赵天旭 on 16/10/24.
//  Copyright © 2016年 ZTX. All rights reserved.
//

#import "TXTextField.h"


#define RGBA(r,g,b,a)   [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]


@interface TXTextField()<UITextFieldDelegate>
@property(nonatomic, strong)UILabel  *mailLabel;
@property(nonatomic, strong)NSString *email;
@end

@implementation TXTextField

- (instancetype)initWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.font = [UIFont systemFontOfSize:fontSize];
        self.borderStyle=UITextBorderStyleRoundedRect;
        [self configInitMessage];
    }
    return self;
}

- (void)configInitMessage {
    self.delegate = self;
    _email = [[NSMutableString alloc]initWithCapacity:0];
    _mailLabel = [[UILabel alloc] init];
    _mailLabel.textColor = RGBA(170, 170, 170, 1);
    _mailLabel.font = self.font;
    _mailLabel.frame = CGRectMake(5, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 2);
    [self addSubview:_mailLabel];
}

- (void)setMailMatchColor:(UIColor *)mailMatchColor {
    _mailMatchColor=mailMatchColor;
    _mailLabel.textColor=mailMatchColor;
}

/**
 *  匹配邮箱过程
 *
 *  @param range  range
 *  @param string 用户输入string
 */
- (void)configMailMatchingRange:(NSRange)range replacementString:(NSString *)string {
    //1.获取完整的输入文本
    NSString *completeString = [self.text stringByReplacingCharactersInRange:range withString:string];
    //2.以@符号分割文本
    NSArray *tempMailArray = [completeString componentsSeparatedByString:@"@"];
    //3.获取邮箱前缀
    NSString *emailString = [tempMailArray firstObject];
    //4.邮箱匹配 没有输入@符号时 用@匹配
    NSString *matchString = @"@";
    if (tempMailArray.count>1) {
        //如果已经输入了@符号，截取@符号后的字符作为匹配字符
        matchString = [completeString substringFromIndex:emailString.length];
    }
    //匹配邮箱，得到所有跟当前输入匹配的邮箱后缀
    NSMutableArray *suffixArray = [self checkEmailStr:matchString];
    //边界控制，如果没有跟当前输入匹配的后缀置为@“”
    NSString *fixString = suffixArray.count>0 ? [suffixArray firstObject] : @"";
    //将lblEmail部分字段隐藏
    NSInteger cutLenth = suffixArray.count > 0 ? completeString.length : emailString.length;
    //最终的邮箱地址
    self.email = fixString.length > 0 ? [NSString stringWithFormat:@"%@%@",emailString,fixString] : completeString;
    
    //设置lblEmail 的attribute
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",emailString,fixString]];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0,cutLenth)];
    self.mailLabel.attributedText = attributeString;
    
    //清空文本框内容时 隐藏lblEmail
    if(completeString.length == 0){
        self.mailLabel.text = @"";
        self.email = @"";
    }
}

/**
 *  结束输入操作
 */
- (void)didEndEditing
{
    self.text = self.email;
    self.mailLabel.text = @"";
}

/**
 *  替换邮箱匹配类型
 *
 *  @param string 匹配的字段
 *
 *  @return 匹配成功的Array
 */
- (NSMutableArray *)checkEmailStr:(NSString *)string{
    NSMutableArray *filterArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *str in self.mailTypeArray) {
        if([str hasPrefix:string]){
            [filterArray addObject:str];
        }
    }
    return filterArray;
}

#pragma mark - textfield的delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self configMailMatchingRange:range replacementString:string];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self didEndEditing];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.text = self.email;
    self.mailLabel.text = @"";
    if (self.didPressedReturnCompletion) {
        self.didPressedReturnCompletion(self);
    }
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
