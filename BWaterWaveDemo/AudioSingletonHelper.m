//
//  AudioSingletonHelper.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "AudioSingletonHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioSingletonHelper()<AVAudioPlayerDelegate>{
    
    AVAudioPlayer *audioPlayer;
    
    NSMutableArray *tempArray;
    
}

@end


@implementation AudioSingletonHelper

+ (AudioSingletonHelper *)shareAudioHelper {
    
    static AudioSingletonHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc] init];
        
    });
    
    return helper;
    
}


- (void)playVoiceWithFileNames:(NSMutableArray *)fileNames {
    
    tempArray = [NSMutableArray arrayWithArray:fileNames];
    

    if (tempArray.count > 0) {
        
        [self playCurrentVoice];
        
    }
    
    
}

- (void)playCurrentVoice {
    
    NSString *fileName = tempArray[0];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    
    audioPlayer.delegate = self;
    
    [audioPlayer prepareToPlay];
    
    [audioPlayer play];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [tempArray removeObjectAtIndex:0];
    
    if (tempArray.count > 0) {
        
        [self playCurrentVoice];
        
    }
    
    
    
}


@end
