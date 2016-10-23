//
//  AudioPlayerManager.h
//  WaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayerManager : NSObject


+ (AudioPlayerManager *)defaultAudioPlayerManager;


- (void)playAudioWithNames:(NSMutableArray *)namesArray;

@end
