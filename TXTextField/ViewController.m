//
//  ViewController.m
//  TXTextField
//
//  Created by 赵天旭 on 16/10/24.
//  Copyright © 2016年 ZTX. All rights reserved.
//

#import "ViewController.h"
#import "TXTextField.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TXTextField * field = [[TXTextField alloc] initWithFrame:CGRectMake(100, 200, 200, 30) fontSize:12];
    field.placeholder = @"输入邮箱地址";
    field.mailTypeArray = [NSMutableArray arrayWithObjects:@"@qq.com",@"@163.com",@"@126.com",@"@yahoo.com",@"@139.com",@"@henu.com", nil];
//    Field.mailMatchColor = [UIColor redColor];
    field.didPressedReturnCompletion = ^(UITextField * textField){
        NSLog(@"textFieldText%@",textField);
    };
    [self.view addSubview:field];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
