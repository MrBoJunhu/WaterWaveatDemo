//
//  UIColor+VJExtension.h
//  LaiApp_OC
//
//  Created by Victor on 16/3/23.
//  Copyright © 2016年 Softtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (VJExtension)

/**
 *  16进制转换成UIColor对象，透明度默认为1
 *
 *  @param hex 16进制值
 *
 *  @return UIColor对象
 */
+ (UIColor *)vj_colorWithHex:(NSInteger)hex;

/**
 *  16进制转换成UIColor对象
 *
 *  @param hex   16进制值
 *  @param alpha 透明度
 *
 *  @return UIColor对象
 */
+ (UIColor *)vj_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
/**
 *  16进制转换成UIColor对象
 *
 *  @param color 字符串表示的16进制
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
/**
 *  16进制转换成UIColor对象
 *
 *  @param color 字符串表示的16进制
 *  @param alpha 透明度
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
