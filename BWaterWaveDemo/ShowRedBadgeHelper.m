//
//  ShowRedBadgeHelper.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "ShowRedBadgeHelper.h"

@implementation ShowRedBadgeHelper

+ (ShowRedBadgeHelper *)shareShowRedBadgeHelper {
    
    static  ShowRedBadgeHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc] init];
        
    });
    
    return helper;
    
}


- (void)showRedBadge:(BOOL)show userInfo:(id)userInfo{
    
    if (show) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:App_HasNewMsg object:nil userInfo:userInfo];
    
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:App_HasNoMsg object:nil userInfo:userInfo];
        
    }
    
}

@end
