//
//  MineViewController.m
//  BWaterWaveDemo
//
//  Created by bill on 16/10/23.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "MineViewController.h"
#import "AudioSingletonHelper.h"

#import "SecondViewController.h"

#import "ThirdViewController.h"

#import "PictureViewController.h"

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


@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *TBV;

@property (nonatomic, strong) NSArray *dataArray;


#pragma mark - 顺序播放音频文件
@property (nonatomic, strong) NSMutableArray *voiceArray;

@property (nonatomic, strong) NSArray *encourageArray;

@property (nonatomic, assign) TimeStyle voiceTimeStyle;


@end

@implementation MineViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArray = @[@"读取消息", @"语音", @"涟漪", @"波纹", @"图片模糊处理"];
    
    //鼓励语
    [self cofigurationFile];

}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"我的";
}


#pragma mark - tableView datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_name = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_name];
    
    if (cell == nil) {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_name];
        
        cell.textLabel.text = _dataArray[indexPath.row];
        
    }
    
    return cell;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    if (row == 0) {
        
        //隐藏未读消息
        [[ShowRedBadgeHelper shareShowRedBadgeHelper] showRedBadge:NO userInfo:nil];

    }else if (row == 1){
       
        // 语音播报
        [self playVoiceAciton];

    }else if (row == 2){
        
        SecondViewController *waveVC = [[SecondViewController alloc] init];
        
        [self.navigationController pushViewController:waveVC animated:YES];
        
    }else if (row == 3){
        
        ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
        
        [self.navigationController pushViewController:thirdVC animated:YES];
        
    }else if (row == 4){
      
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        PictureViewController *pictureVC = [mainSB instantiateViewControllerWithIdentifier:@"PictureViewController"];
        
        [self.navigationController pushViewController:pictureVC animated:YES];
        
    }
    
}


#pragma mark - 顺序播放音频文件
- (void)cofigurationFile {
    
    _encourageArray = @[@"好棒", @"加油哦", @"坚持哦", @"太棒了", @"真厉害"];
    
    
    
    
}

- (void)playVoiceAciton {
    
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
    
    [[AudioSingletonHelper shareAudioHelper] playVoiceWithFileNames:voiceArray];
    
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
