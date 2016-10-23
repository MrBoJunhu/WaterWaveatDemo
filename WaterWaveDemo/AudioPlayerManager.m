//
//  AudioPlayerManager.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "AudioPlayerManager.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayerManager()<AVAudioPlayerDelegate>

{
   
    AVAudioPlayer *audioPlayer;
    
    NSMutableArray *tempArray;
  
}

@end



@implementation AudioPlayerManager

+ (AudioPlayerManager *)defaultAudioPlayerManager {
    
    static AudioPlayerManager *manager = nil;
    
    static dispatch_once_t onceToken;
   
    dispatch_once(&onceToken, ^{
    
        manager = [[self alloc] init];
    
    });
    
    return manager;
    
}



#pragma mark - 

-(void)playAudioWithNames:(NSMutableArray *)namesArray {
    
    tempArray = [NSMutableArray arrayWithArray:namesArray];
    
    if (tempArray.count > 0) {
        
        [self playVoice];
        
    }
    
}

- (void)playVoice {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:tempArray[0] ofType:@"mp3"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    
    audioPlayer.delegate = self;
    
    [audioPlayer prepareToPlay];
    
    [audioPlayer play];
    
}

#pragma mark - AVAudioPlayer delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    [tempArray removeObjectAtIndex:0];
    
    if (tempArray.count > 0) {
        
        [self playVoice];
        
    }
    
    
}

@end
