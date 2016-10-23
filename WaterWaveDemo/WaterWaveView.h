//
//  WaterWaveView.h
//  WaterWaveDemo
//
//  Created by bill on 16/10/12.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterWaveView : UIView
/**
 *  达到后是否恢复水平面
 */
@property (nonatomic, assign) BOOL restoreLevel;

- (void)startWaveToPercent:(CGFloat)percent;

- (void)setWaveGrowSpeed:(CGFloat)waveGrowSpeed;   // 设置上升速度

- (void)setGradientColors:(NSArray *)colors;    // 设置渐变色

@end
