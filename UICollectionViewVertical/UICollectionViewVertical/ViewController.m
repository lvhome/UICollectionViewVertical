//
//  ViewController.m
//  UICollerctionViewHorizontal
//
//  Created by MAC on 2018/11/8.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "LHViewController.h"
#import "LViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = (UIButton *)[self.view viewWithTag:1];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn1 = (UIButton *)[self.view viewWithTag:2];
    [btn1 addTarget:self action:@selector(onClick1) forControlEvents:UIControlEventTouchUpInside];
}


- (void)onClick {
    LHViewController * viewC = [[LHViewController alloc] init];
    [self.navigationController pushViewController:viewC animated:YES];
}

- (void)onClick1 {
    LViewController * viewC = [[LViewController alloc] init];
    [self.navigationController pushViewController:viewC animated:YES];
}


@end
