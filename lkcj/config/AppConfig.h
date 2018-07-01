//
//  AppConfig.h
//  lkcj
//
//  Created by annilq on 2018/6/28.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject
+ (NSString *)getImageFromMoudleType:(NSString *)key ;
+ (NSString *)getImageSelectedFromMoudleType:(NSString *)key;
+ (NSString *)getImageFromformKey:(NSString *)key;
@end
