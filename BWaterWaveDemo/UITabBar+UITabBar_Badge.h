//
//  UITabBar+UITabBar_Badge.h
//  LaiApp_OC
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 Softtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (UITabBar_Badge)

- (void)showBadgeOnItemIndex:(int)index totalTabbarItemNums:(int)barItemNums;

- (void)showBadgeOnItemIndex:(int)index WithMessageNums:(NSString *)msgNums totalTabbarItemNums:(int)barItemNums;

- (void)showBadgeOnItemIndex:(int)index WithMessageNums:(NSString *)msgNums totalTabbarItemNums:(int)barItemNums badgeCornerRaidus:(CGFloat)badgeCornerRadius messageTextFontSize:(CGFloat)messageFonstSize;

- (void)hiddenBadgeOnItemIndex:(int)index;

@end
