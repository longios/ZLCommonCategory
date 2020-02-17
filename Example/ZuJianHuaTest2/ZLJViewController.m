//
//  ZLJViewController.m
//  ZuJianHuaTest2
//
//  Created by lq2 on 02/16/2020.
//  Copyright (c) 2020 lq2. All rights reserved.
//

#import "ZLJViewController.h"
#import <ZLJBaseCategory.h>

@interface ZLJViewController ()

@end

@implementation ZLJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *yellowView = [UIView new];
    yellowView.x = 200;
    yellowView.y = 200;
    yellowView.size = CGSizeMake(200, 200);
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    UILabel *testLbl = [UILabel labelWithColor:[UIColor redColor] fontSize:16];
    testLbl.text = @"i am test label";
    [testLbl sizeToFit];
    testLbl.x = 20;
    testLbl.y = yellowView.bottom + 30;
    [self.view addSubview:testLbl];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
