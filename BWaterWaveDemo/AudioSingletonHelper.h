//
//  AudioSingletonHelper.h
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioSingletonHelper : NSObject

+(AudioSingletonHelper *)shareAudioHelper;

- (void)playVoiceWithFileNames:(NSMutableArray *)fileNames;

@end
