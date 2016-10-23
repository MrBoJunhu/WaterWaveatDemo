//
//  BaseViewController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/13.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "BaseViewController.h"

/**
 *  右滑返回
 */
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

static BOOL _isPoping;

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 开启侧滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    _isPoping = NO;
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (!_isPoping) {
        
        _isPoping = YES;
        
        return YES;
        
    }else{
   
        return NO;
   
    }
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
