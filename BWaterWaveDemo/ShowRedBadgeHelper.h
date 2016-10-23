//
//  ShowRedBadgeHelper.h
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowRedBadgeHelper : NSObject

+ (ShowRedBadgeHelper *)shareShowRedBadgeHelper;

- (void)showRedBadge:(BOOL)show userInfo:(id)userInfo;

@end
