//
//  UITabBar+UITabBar_Badge.m
//  LaiApp_OC
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 Softtek. All rights reserved.
//

#import "UITabBar+UITabBar_Badge.h"

@implementation UITabBar (UITabBar_Badge)


- (void)showBadgeOnItemIndex:(int)index totalTabbarItemNums:(int)barItemNums {
  
    [self removeBadgeOnItemIndex:index];
    
    CGRect tabBarFrame = self.frame;
    
    UILabel *badgeLB = [[UILabel alloc] init];
    
    badgeLB.tag = 400 + index;
    
    badgeLB.layer.masksToBounds = YES;
    
    badgeLB.layer.cornerRadius = 5;
    
    badgeLB.backgroundColor = [UIColor redColor];
        
    // 确定小红点的位置
    CGFloat persentX = (index + 0.6f) / barItemNums;
    
    CGFloat badge_X = ceilf(persentX * tabBarFrame.size.width);
    
    CGFloat badge_Y = ceilf(0.1 * tabBarFrame.size.height);
    
    badgeLB.frame = CGRectMake(badge_X, badge_Y, badgeLB.layer.cornerRadius * 2, badgeLB.layer.cornerRadius * 2);
    
    [self addSubview:badgeLB];
    
}

- (void)showBadgeOnItemIndex:(int)index WithMessageNums:(NSString *)msgNums totalTabbarItemNums:(int)barItemNums{
    
    [self removeBadgeOnItemIndex:index];
    
    CGRect tabBarFrame = self.frame;
    
    UILabel *badgeLB = [[UILabel alloc] init];
    
    badgeLB.tag = 400 + index;
    
    badgeLB.layer.masksToBounds = YES;
    
    badgeLB.layer.cornerRadius = 8;
    
    badgeLB.backgroundColor = [UIColor redColor];
    
    badgeLB.font =[msgNums intValue] > 99 ? [UIFont systemFontOfSize:8] : [UIFont systemFontOfSize:10];
    
    badgeLB.textColor = [UIColor whiteColor];
    
    badgeLB.textAlignment = NSTextAlignmentCenter;
    
    msgNums = [msgNums intValue] > 98 ? @"99+" : msgNums;
    
    badgeLB.text = msgNums;
    
    CGFloat persentX = (index + 0.6f) / barItemNums;
    
    CGFloat badge_X = ceilf(persentX * tabBarFrame.size.width);
    
    CGFloat badge_Y = ceilf(0.1 * tabBarFrame.size.height);
    
    badgeLB.frame = CGRectMake(badge_X, badge_Y, badgeLB.layer.cornerRadius * 2, badgeLB.layer.cornerRadius * 2);
    
    [self addSubview:badgeLB];
}


- (void)showBadgeOnItemIndex:(int)index WithMessageNums:(NSString *)msgNums totalTabbarItemNums:(int)barItemNums badgeCornerRaidus:(CGFloat)badgeCornerRadius messageTextFontSize:(CGFloat)messageFonstSize{
    
    [self removeBadgeOnItemIndex:index];
    
    CGRect tabBarFrame = self.frame;
    
    UILabel *badgeLB = [[UILabel alloc] init];
    
    badgeLB.tag = 400 + index;
    
    badgeLB.layer.masksToBounds = YES;
    
    badgeLB.layer.cornerRadius = badgeCornerRadius;
    
    badgeLB.backgroundColor = [UIColor redColor];
    
    badgeLB.font = [UIFont systemFontOfSize:messageFonstSize];
    
    badgeLB.textColor = [UIColor whiteColor];
    
    badgeLB.textAlignment = NSTextAlignmentCenter;
    
    msgNums = [msgNums intValue] > 98 ? @"99+" : msgNums;
    
    badgeLB.text = msgNums;
    
    CGFloat persentX = (index + 0.6f) / barItemNums;
    
    CGFloat badge_X = ceilf(persentX * tabBarFrame.size.width);
    
    CGFloat badge_Y = ceilf(0.1 * tabBarFrame.size.height);
    
    badgeLB.frame = CGRectMake(badge_X, badge_Y, badgeCornerRadius * 2, badgeCornerRadius * 2);
    
    [self addSubview:badgeLB];
    
}


- (void)hiddenBadgeOnItemIndex:(int)index {
    
    [self removeBadgeOnItemIndex:index];
    
}


- (void)removeBadgeOnItemIndex:(int)index {
    
    for (UIView *subV in self.subviews) {
        
        if (subV.tag == 400 + index) {
            
            [subV removeFromSuperview];
            
        }
        
    }
    
    
}
@end
