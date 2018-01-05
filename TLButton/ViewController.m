//
//  ViewController.m
//  TLButton
//
//  Created by yishu on 2018/1/5.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+TLButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.frame = CGRectMake(50, 100, 50, 50);
    btn0.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn0];
    [btn0 addTarget:self action:@selector(click0) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(200, 100, 50, 50);
    btn1.cs_acceptEventInterval = 1;
    btn1.titleRect = CGRectMake(0, 0, 25, 50);
    [btn1 setTitle:@"123" forState:UIControlStateNormal];
    btn1.imageRect = CGRectMake(25, 0, 25, 50);
    [btn1 setImage:[UIImage imageNamed:@"demo.png"] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click0{
    NSLog(@"点击btn0");
}
- (void)click1{
    NSLog(@"点击btn1");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
