//
//  ViewController.m
//  FGUpdateDemo
//
//  Created by Fengur on 16/9/8.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "ViewController.h"
#import "FGUpdateTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    NSString *sougouKeyBoardAppID = @"917670924";
    NSString *job51AppID = @"415443644";
    [super viewDidLoad];
    
    NSString *sogouKeyBoardVersion = [FGUpdateTool getLatestAppVersionCodeWithAppId:sougouKeyBoardAppID];
    NSString *job51Version = [FGUpdateTool getLatestAppVersionCodeWithAppId:job51AppID];
    
    NSLog(@"\n\tsogouVerson %@\n\tjob51Version %@",sogouKeyBoardVersion,job51Version);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
