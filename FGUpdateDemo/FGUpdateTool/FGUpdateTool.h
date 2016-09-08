//
//  FGUpdateTool.h
//  FGUpdateDemo
//
//  Created by Fengur on 16/9/8.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FGVersionModel;
@protocol FGUpdateToolDelegate<NSObject>

- (void)updateWithLatestVersionModel:(FGVersionModel *)versionModel;

@end

@interface FGUpdateTool : NSObject

/**
 *  无后端获取最新版本号弹出更新提示框
 *
 *  @param appId 当前app注册时的appId
 *
 *  @return 当前app的最新版本号
 */
+ (NSString *)getLatestAppVersionCodeWithAppId:(NSString *)appId;

@property (nonatomic, weak) id<FGUpdateToolDelegate> delegate;

/**
 *  检查当前版本是否需要更新
 */
- (void)checkCurrentVersion;

@property (nonatomic, strong) FGVersionModel *versionModel;

@end
