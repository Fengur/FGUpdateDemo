//
//  AppDelegate.m
//  FGUpdateDemo
//
//  Created by Fengur on 16/9/8.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "AppDelegate.h"
#import "FGUpdateTool.h"
#import "FGVersionModel.h"
#import "ViewController.h"

@interface AppDelegate ()<FGUpdateToolDelegate> {
    FGUpdateTool *_updateTool;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    ViewController *rootVC = [[ViewController alloc] init];
    _window.rootViewController = rootVC;
    [self setUpdateStep];
    return YES;
}

- (void)setUpdateStep {
    _updateTool = [FGUpdateTool new];
    _updateTool.delegate = self;
    [_updateTool checkCurrentVersion];
}

- (void)updateWithLatestVersionModel:(FGVersionModel *)versionModel {
    if (versionModel.canUpdate) {
        NSLog(@"需要更新");
        UIAlertController *alertController =
            [UIAlertController alertControllerWithTitle:nil
                                                message:versionModel.desc
                                         preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
            actionWithTitle:@"取消"
                      style:UIAlertActionStyleCancel
                    handler:^(UIAlertAction *_Nonnull action) {
                        if (versionModel.enforceFlag) {
                            //强制更新处理，可以选择不更新就杀死，也可以进入不可使用状态.一般进入强制更新都是因为有重大BUG，或者有Api兼容问题
                            [UIView animateWithDuration:0.5f
                                animations:^{
                                    _window.transform = CGAffineTransformMakeScale(1, 0.01);
                                }
                                completion:^(BOOL finished) {
                                    exit(0);
                                }];
                        }
                    }];

        UIAlertAction *okAction =
            [UIAlertAction actionWithTitle:@"更新"
                                     style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *_Nonnull action) {
                                       [[UIApplication sharedApplication]
                                           openURL:[NSURL URLWithString:versionModel.downloadUrl]];
                                   }];

        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [_window.rootViewController presentViewController:alertController
                                                 animated:YES
                                               completion:nil];

    } else {
        NSLog(@"不需要更新");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /**
     *  强制更新需在应用从后台进入前提时，做出处理,因为用户跳转到appStore后，可能未更新就已经返回
     */
    if (_updateTool.versionModel.enforceFlag) {
        [_updateTool checkCurrentVersion];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
