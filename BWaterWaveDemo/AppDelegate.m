//
//  AppDelegate.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (assign, nonatomic)UIBackgroundTaskIdentifier bgTaskId;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
    //开启后台处理多媒体事件
    NSLog(@"激活了准备播放");
    //    AVAudioSession *session = [AVAudioSession sharedInstance];
    //    [session setActive:YES error:nil];
    //    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //    AVAudioSession *session=[AVAudioSession sharedInstance];
    //    [session setActive:YES error:nil];
    //    //后台播放
    //    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    self.bgTaskId=[AppDelegate backgroundPlayerID:self.bgTaskId];
    //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
}

+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId {
    
    //设置并激活音频会话类别
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    //允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if(newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
