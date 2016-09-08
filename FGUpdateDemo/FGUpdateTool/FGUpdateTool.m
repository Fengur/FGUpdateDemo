//
//  FGUpdateTool.m
//  FGUpdateDemo
//
//  Created by Fengur on 16/9/8.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#define AppVersionKeyStr @"softwareVersion"
#define AppStoreUrl @"https://itunes.apple.com/cn/app/id"
#define AppH5Tag @"//span"

#import "FGUpdateTool.h"
#import "FGVersionModel.h"
#import "TFHpple.h"

@implementation FGUpdateTool

+ (NSString *)getLatestAppVersionCodeWithAppId:(NSString *)appId {
    NSData *versionData = [NSData
        dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", AppStoreUrl,
                                                                              appId]]];
    NSString *lastestVersionCode = @"";
    TFHpple *versionDoc = [[TFHpple alloc] initWithHTMLData:versionData];
    NSArray *elements = [versionDoc searchWithXPathQuery:AppH5Tag];
    for (TFHppleElement *tempElement in elements) {
        if ([tempElement.raw containsString:AppVersionKeyStr]) {
            lastestVersionCode = tempElement.content;
        }
    }
    return lastestVersionCode;
}

- (void)checkCurrentVersion {
    /**
     *  此处更新处理方案一般有两种：
        1.应用后端架设有对版本号的校验机制
        2.应用后盾没有获取版本号的接口,此机制见getLatestAppVersionCodeWithAppId方法,此方法主要服务于第一种
     */

    /*进行网络请求，拿到服务端最新版本信息*/
    /*此Model旨在模拟服务端返回数据*/

    FGVersionModel *versionModel = [[FGVersionModel alloc] init];
    _versionModel = [FGVersionModel new];
    versionModel.enforceFlag = NO;
    versionModel.desc = @"应用已有新版本，是否更新";
    versionModel.downloadUrl = @"https://itunes.apple.com/cn/app/id917670924";
    versionModel.versionName = @"3.8.5";

    _versionModel = versionModel;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if ([versionModel.versionName compare:currentVersion] == NSOrderedDescending) {
        versionModel.canUpdate = YES;
    } else {
        versionModel.canUpdate = NO;
    }

    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(updateWithLatestVersionModel:)]) {
        [self.delegate updateWithLatestVersionModel:versionModel];
    }
}

@end
