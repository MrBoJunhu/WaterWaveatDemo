//
//  BadgeFirstViewController.m
//  WaterWaveDemo
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "BadgeFirstViewController.h"
#import "AudioPlayerManager.h"

static  NSString *hourString = @"小时";

static  NSString *minuteString = @"分钟";

static NSString *secondsString = @"秒";

static  NSString *kmString = @"公里";

static NSString *userTimeString = @"用时";

static NSString *youHaveMovedSting = @"您已运动";

static NSString *lastUseTimeString = @"最近一公里用时";


typedef NS_ENUM(NSUInteger, TimeStyle) {
    
    TimeHasHourMinuteSecondsStyle, // 时 分钟 秒
    
    TimeHasMinuteSecondsStyle,   // 分钟 秒
    
    TimeHasJustSecondsStyle,  // 秒
};


@interface BadgeFirstViewController ()
#pragma mark - 顺序播放音频文件
@property (nonatomic, strong) NSMutableArray *voiceArray;

@property (nonatomic, strong) NSArray *encourageArray;

@property (nonatomic, assign) TimeStyle voiceTimeStyle;

@end

@implementation BadgeFirstViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationCenter_HasNewMsg object:nil];
    
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    // 小红点提示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRedBradge) name:NSNotificationCenter_HasNewMsg object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenRedBradge) name:NSNotificationCenter_NoMsgToRead object:nil];
    
    //鼓励语
    [self cofigurationFile];
    
}

- (void)showRedBradge{
    
    [self.tabBarController.tabBar showBadgeOnItemIndex:1 totalTabbarItemNums:3];
    
}

- (void)hiddenRedBradge{
    
    [self.tabBarController.tabBar hiddenBadgeOnItemIndex:1];
    
}

#pragma mark - 音频拼接
/**
 *  音频合成测试
 */
- (IBAction)joinTogetherSounds:(id)sender {

//    [[JoinSoundsTogetherHelper shareJoinSoundsTogetherHelper] audioStitchingWithSoundsNames:@[@"Untitled运动准备.wav",@"Untitled倒计时.wav",@"Untitled3.wav", @"Untitled2.wav", @"Untitled1.wav", @"开始运动.wav"] soundType:@"wav"];
    
    
        [[JoinSoundsTogetherHelper shareJoinSoundsTogetherHelper] audioStitchingWithSoundsNames:@[@"时.mp3",@"秒.mp3"] soundType:nil];
    
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"laimusic.mp3" ofType:@"mp3"];
//    [[JoinSoundsTogetherHelper shareJoinSoundsTogetherHelper] playSoundsWithFilePath:filePath];

    
}



/**
 *  创建播放器
 *
 *  @return 音频播放器
 */



- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[JoinSoundsTogetherHelper shareJoinSoundsTogetherHelper] pausePlay];
    
}
- (IBAction)alarmAction:(id)sender {
    /**
     推送的最长显示时间是30s，所以如果要这么长的时间提醒的时候，你可以在播放声音的时候放一个大概是30S的音乐文件即可，闹钟即是用这种方式来实现提醒！
    */
    // 本地通知
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    if (notification != nil) {
        
        NSDate *now = [NSDate new];
        
        // 十秒后通知
        notification.fireDate = [now dateByAddingTimeInterval:5];
        
        // 循环次数 kCFCalendarUnitWeekday 一周一次
        notification.repeatInterval = kCFCalendarUnitWeekday;
        
        notification.timeZone = [NSTimeZone defaultTimeZone];
        
        // 应用的红色数字
        notification.applicationIconBadgeNumber = 1;
        
        // 音效
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        // 提示信息 弹出提示框
        notification.alertBody = @"通知的内容";
        // 提示框按钮
        notification.alertAction = @"打开";
        
        // 是否显示额外的按钮
        notification.hasAction = NO;
        
        // 添加额外的信息
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"额外的一些信息" forKey:@"someKey"];
        
        notification.userInfo = infoDic;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    }
    
    NSLog(@"#ifdef #else #endif \n%@", MapString);
    
}


#pragma mark - 顺序播放音频文件
- (void)cofigurationFile {
    
    _encourageArray = @[@"好棒", @"加油哦", @"坚持哦", @"太棒了", @"真厉害"];
    
    
    
    
}



- (IBAction)playVoiceAciton:(id)sender {
    
    // 随机公里数
    NSUInteger distance = arc4random() % (100 - 1) + 1;

    // 随机时间
    NSUInteger seconds = arc4random() % (10000 - 3600) + 3600;

    // 最近一公里用时随机时间
    NSUInteger lastTime = arc4random() % (3700 - 300) + 300;

    // 播放语音
    [self readMyDistance:distance totalUseTime:seconds andLastUseTime:lastTime];

}

#pragma mark - 播放公里数及耗时
- (void)readMyDistance:(NSUInteger)distance totalUseTime:(NSUInteger)seconds andLastUseTime:(NSUInteger)lastUseTime   {
    NSMutableArray *voiceArray = [NSMutableArray array];
    
    // 你已运动
    [voiceArray addObject:youHaveMovedSting];
    
    // 公里语音
    NSMutableArray *distanceVoiceArray = [self dealWithDistance:distance];
    
    [voiceArray addObjectsFromArray:distanceVoiceArray];
    
    
    //用时
    [voiceArray addObject:userTimeString];
    
    
    // 时间语音
    
    NSMutableArray *timeVoiceArray = [self dealTimeWithSeconds:seconds];
    
    [voiceArray addObjectsFromArray:timeVoiceArray];
    
    //最近一公里
    if (distance > 2) {
        
        [voiceArray addObject:lastUseTimeString];
        
        
        NSMutableArray *lastUseTimeArray = [self dealTimeWithSeconds:lastUseTime];
        
        [voiceArray addObjectsFromArray:lastUseTimeArray];
        
    }
    
    // 鼓励语句
    int index = arc4random() % 5;
    
    NSString *encourageString = self.encourageArray[index];
    
    [voiceArray addObject:encourageString];
    
    
    [self playVoiceWithVoiceNamesArray:voiceArray];
}


#pragma mark - 对数字处理
- (NSArray *)dealDigital:(NSUInteger)distance {
    
    NSString *firstKLString;
    
    NSString *secondKLString;
    
    if ((distance < 10) || ( distance % 10 == 0)) {
        
        firstKLString = [NSString stringWithFormat:@"%ld", distance];
        
        return  [NSArray arrayWithObjects:firstKLString, nil];
        
    }else{
        
        if (distance < 20) {
            
            firstKLString = [NSString stringWithFormat:@"%d", 10];
            
        }else{
            
            firstKLString = [NSString stringWithFormat:@"%ld", 10 * (distance / 10)];
            
        }
       
        secondKLString = [NSString stringWithFormat:@"%ld", distance % 10 ];
        
        return [NSArray arrayWithObjects:firstKLString, secondKLString, nil];
        
    }
}
#pragma mark - 对公里数处理
- (NSMutableArray *)dealWithDistance:(NSUInteger)distance {
    
    NSMutableArray *distanceVoiceArray = [NSMutableArray array];
    
    NSArray *distanceArray = [self dealDigital:distance];
  
    [distanceVoiceArray addObjectsFromArray:distanceArray];
    
    [distanceVoiceArray addObject:kmString];
    
    return distanceVoiceArray;
}


#pragma mark - 对时间做处理
- (NSMutableArray *)dealTimeWithSeconds:(NSUInteger)timeSeconds {
    
    NSMutableArray *timeArray = [NSMutableArray array];
    
    NSUInteger hour = timeSeconds / 3600;  // 得到小时
    
    NSUInteger  minute = ( timeSeconds - hour * 3600) / 60; //得到分钟
        
    NSUInteger  seconds = timeSeconds - hour * 3600 - 60 * minute; //得到秒数
    
    NSArray *hourArray; //小时
    
    NSArray *minuteArray; //分钟
    
    NSArray *secondsArray; // 秒
    
    if (hour > 0) {
        
        _voiceTimeStyle = TimeHasHourMinuteSecondsStyle;
        
        hourArray = [self dealDigital:hour];
        

        if (minute > 0) {
            
            minuteArray = [self dealDigital:minute];

        }
        
        secondsArray = [self dealDigital:seconds];
        
        hourArray.count > 0 ? [timeArray addObject:hourArray] : nil;
        
        minuteArray.count > 0 ? [timeArray addObject:minuteArray] : nil;
        
        secondsArray.count > 0 ? [timeArray addObject:secondsArray] : nil;
        
    }else{
        
        if (minute > 0) {
            
            _voiceTimeStyle = TimeHasMinuteSecondsStyle;
           
            minuteArray = [self dealDigital:minute];
            
            secondsArray = [self dealDigital:seconds];
            
            minuteArray.count > 0 ? [timeArray addObject:minuteArray] : nil;
            
            secondsArray.count > 0 ? [timeArray addObject:secondsArray] : nil;
            
            
        }else{
            
            _voiceTimeStyle = TimeHasJustSecondsStyle;
            
            secondsArray = [self dealDigital:seconds];
           
            secondsArray.count > 0 ? [timeArray addObject:secondsArray] : nil;
            
        }
        
    }
    
    //需要读取的时间
    NSMutableArray *timeVoiceArray = [NSMutableArray array];
    
    if (_voiceTimeStyle == TimeHasHourMinuteSecondsStyle) {
        // 读时分秒
        for (int i = 0; i < timeArray.count; i ++) {
            
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:timeArray[i]];
            
            if (i == 0) {
                // 小时
                [timeVoiceArray addObjectsFromArray:tempArray];
                
                [timeVoiceArray addObject:hourString];
                
            }else if (i == 1){
                //分钟
                
                [timeVoiceArray addObjectsFromArray:tempArray];
                
                if (minute > 0) {
                    
                    [timeVoiceArray addObject:minuteString];
                    
                }else{
                 
                    [timeVoiceArray addObject:secondsString];
                
                }
                
            }else{
                //秒
                [timeVoiceArray addObjectsFromArray:tempArray];
                
                [timeVoiceArray addObject:secondsString];
            }
            
        }
        
        
    }else if (_voiceTimeStyle == TimeHasMinuteSecondsStyle){
        // 读分钟秒
        for (int i = 0; i < timeArray.count; i ++) {
            
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:timeArray[i]];
            
            if (i == 0) {
                
                if (tempArray.count > 0) {
                   
                    [timeVoiceArray addObjectsFromArray:tempArray];
                    
                    if (minute > 0) {
                       
                        [timeVoiceArray addObject:minuteString];

                    }else{
                        
                        [timeVoiceArray addObject:secondsString];
                        
                    }
                    
                }
                
            }else{
                
                [timeVoiceArray addObjectsFromArray:tempArray];
                
                [timeVoiceArray addObject:secondsString];
                
            }
            
        }
        
    }else{
        //只读秒
        for (int i = 0 ; i < timeArray.count; i ++) {
           
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:timeArray[i]];
            [timeVoiceArray addObjectsFromArray:tempArray];
            
            [timeVoiceArray addObject:secondsString];
            
        }
        
    }
    
    return timeVoiceArray;
    
}



- (void)playVoiceWithVoiceNamesArray:(NSMutableArray *)voiceArray {
    
    [[AudioPlayerManager defaultAudioPlayerManager] playAudioWithNames:voiceArray];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
