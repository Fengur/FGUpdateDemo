//
//  FGVersionModel.h
//  FGUpdateDemo
//
//  Created by Fengur on 16/9/8.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FGVersionModel : NSObject

/**
 *  更新描述话术
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  下载链接
 */
@property (nonatomic, copy) NSString *downloadUrl;
/**
 *  是否强制更新
 */
@property (nonatomic, assign) BOOL enforceFlag;
/**
 *  版本号
 */
@property (nonatomic, assign) NSInteger versionCode;
/**
 *  版本名称
 */
@property (nonatomic, copy) NSString *versionName;
/**
 *  是否可以更新
 */
@property (nonatomic, assign) BOOL canUpdate;

@end
