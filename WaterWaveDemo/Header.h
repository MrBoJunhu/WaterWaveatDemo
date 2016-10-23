//
//  Header.h
//  WaterWaveDemo
//
//  Created by bill on 16/10/13.
//  Copyright © 2016年 bill. All rights reserved.
//

#ifndef Header_h
#define Header_h


#import "ConfigurationFile.h"
#import "UITabBar+UITabBar_Badge.h"
#import "BaseViewController.h"
#import "UIColor+VJExtension.h"

#import "JoinSoundsTogetherHelper.h"

static NSInteger HomepageGreenColor = 0x74bb2a;

#define CreateUIButton(buttonSelf,buttonType, origin_x, origin_y, width, height, buttonTitle, textColor, controlState, controller, selector, event, forView)  UIButton *tempButton = [UIButton buttonWithType:buttonType]; tempButton.frame = CGRectMake(origin_x, origin_y, width, height);  [resetButton setTitleColor:[UIColor textColor] forState:controlState];   [tempButton setTitle:buttonTitle forState:controlState];   [tempButton addTarget:controller action:@selector(selector:) forControlEvents:event];  [forView addSubview:tempButton];buttonSelf =  tempButton;


#endif /* Header_h */
