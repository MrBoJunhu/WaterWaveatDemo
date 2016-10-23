//
//  RipplesView.h
//  WaterWaveDemo
//
//  Created by bill on 16/10/12.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RipplesView : UIView

@property (nonatomic, strong) UIColor *backGroundDefaultColor;

@property (nonatomic, strong)  UIColor * borderColor;

@property (nonatomic, assign) NSInteger circleCount;

@property (nonatomic, assign) CGFloat animationTime;

@property (nonatomic, assign) BOOL isRandomColor;

@end
