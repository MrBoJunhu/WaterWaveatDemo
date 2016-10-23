//
//  JoinSoundsTogetherHelper.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "JoinSoundsTogetherHelper.h"
#import <AVFoundation/AVFoundation.h>

@implementation JoinSoundsTogetherHelper {
    
    AVAudioPlayer *audioPlayer;
    
}


+ (JoinSoundsTogetherHelper *)shareJoinSoundsTogetherHelper {
    
    static JoinSoundsTogetherHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        helper = [[self alloc] init];
        
    });
    
    return helper;
    
}

- (void)joinSoundsTogetherWithSoundFileNames:(NSArray *)soundsFileNameArray soundsFileType:(NSString *)fileType {
    
    // 创建音频轨道
    AVMutableComposition *composition = [AVMutableComposition composition];
    
    for ( int i  = 0; i < soundsFileNameArray.count; i ++) {
       
        NSString *fileName = soundsFileNameArray[i];
        
        [self createAudioTrackWithFileName:fileName fileType:fileType avMutableComposition:composition];

    }
    
    [self outPutJoinTogether:composition];
    
}

// filepath
- (NSString *)getSoundsFilePath:(NSString *)fileName fileType:(NSString *)fileType {
    
   return [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
}

// URL
- (NSURL *)getNSURLFileName:(NSString *)fileName  fileType:(NSString *)fileType{
    
    return  [NSURL URLWithString:[self getSoundsFilePath:fileName fileType:fileType]];
    
}

// 获得音频素材
- (AVURLAsset *)getAVURLAssetWithFileName:(NSString *)fileName fileType:(NSString *)fileType {

    return [AVURLAsset assetWithURL:[self getNSURLFileName:fileName fileType:fileType]];
    
}

// 创建音频轨道
- (void)createAudioTrackWithFileName:(NSString *)fileName fileType:(NSString *)fileType  avMutableComposition:(AVMutableComposition *)avComposition{
   
    // 创建音频轨道，并获取工程中音频素材的轨道
    AVURLAsset *avAsset = [self getAVURLAssetWithFileName:fileName fileType:fileType];
    
    AVMutableCompositionTrack *audioCompositionTrack = [avComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
    
    AVAssetTrack *assetTrack = [avAsset tracksWithMediaType:AVMediaTypeAudio].firstObject;
    
    // 音频合并
    [audioCompositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, avAsset.duration) ofTrack:assetTrack atTime:kCMTimeZero error:nil];
    
}

- (void)outPutJoinTogether:(AVMutableComposition *)avComposition {
    
    // 合并后的文件导出 - 音频文件目前只找到合成m4a类型的
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avComposition presetName:AVAssetExportPresetAppleM4A];
    
    NSString *outFilePath = [self filePathWithName:@"player.M4A"];
    
    
    exportSession.outputURL = [NSURL URLWithString:outFilePath];
    
    exportSession.outputFileType = AVFileTypeAppleM4A;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        
        NSLog(@"合并完成了,开始播放");
        NSLog(@"outFilePath输出: %@", outFilePath);

        [self playSoundsWithFilePath:outFilePath];
        
    }];

    
}

#pragma mark - 音频拼接
/**
 *  音频的拼接(实质上是转化成NSData, 拼接播放)
 *
 *  @param fileNames 要拼接的文件名
 *  @param type      文件类型
 */

- (void)audioStitchingWithSoundsNames:(NSArray *)fileNames soundType:(NSString *)type {
    
    NSMutableData *mutableSoundsData = [[NSMutableData alloc] init];
    
    for (int i = 0; i < fileNames.count;  i ++ ) {
        
        NSString  *name = fileNames[i];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        
        NSData *soundData = [[NSData alloc] initWithContentsOfFile:filePath];
        
        [mutableSoundsData appendData:soundData];
        
    }
    
//    NSString *outputResourceName = [NSString stringWithFormat:@"output.%@", type];
   
    NSString *outputResourceName = @"output.mp3";
    
    NSString *filePlayPath = [self filePathWithName:outputResourceName];
    
    [mutableSoundsData writeToFile:filePlayPath atomically:YES];
    
    [self playSoundsWithFilePath:filePlayPath];

}

- (NSString *)filePathWithName:(NSString *)filename {
    
    NSString *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return [paths stringByAppendingPathComponent:filename];
    
}



- (void)playSoundsWithFilePath:(NSString *)filePath {
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:filePath] error:nil];
    
    if (audioPlayer != nil) {
        
        [audioPlayer play];
        
    }
    
}


- (void)playFileWithFileName:(NSString *)fileName fileType:(NSString *)type {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:filePath] error:nil];
    
    if (audioPlayer != nil) {
        
        [audioPlayer play];
        
    }
    
}

- (void)pausePlay {
  
    [audioPlayer pause];
    
}

@end

