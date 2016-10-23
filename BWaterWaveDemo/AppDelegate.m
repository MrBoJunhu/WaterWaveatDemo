//
//  AppDelegate.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
    // 程序将要进入后台
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setActive:YES error:nil];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    // 程序将要进入后台
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setActive:YES error:nil];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
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
