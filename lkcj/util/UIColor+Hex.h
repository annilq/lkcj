//
//  UIColor+Hex.h
//  lkcj
//
//  Created by annilq on 2018/4/18.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (UIColor *)colorWithHexString: (NSString *)color;
@end
