//
//  JoinSoundsTogetherHelper.h
//  WaterWaveDemo
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoinSoundsTogetherHelper : NSObject

+ (JoinSoundsTogetherHelper *)shareJoinSoundsTogetherHelper;

- (NSURL *)getNSURLFileName:(NSString *)fileName  fileType:(NSString *)fileType;

- (void)joinSoundsTogetherWithSoundFileNames:(NSArray *)soundsFileNameArray soundsFileType:(NSString *)fileType;


- (void)playSoundsWithFilePath:(NSString *)filePath;


- (void)audioStitchingWithSoundsNames:(NSArray *)fileNames soundType:(NSString *)type;


- (void)playFileWithFileName:(NSString *)fileName fileType:(NSString *)type;


- (void)pausePlay;

@end
