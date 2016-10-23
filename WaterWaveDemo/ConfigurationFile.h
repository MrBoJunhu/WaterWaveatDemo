//
//  ConfigurationFile.h
//  WaterWaveDemo
//
//  Created by bill on 16/10/16.
//  Copyright © 2016年 bill. All rights reserved.
//

#ifndef ConfigurationFile_h
#define ConfigurationFile_h

#define NSNotificationCenter_HasNewMsg @"HaveNewUnreadMessage"
#define NSNotificationCenter_NoMsgToRead @"HaveNoMessageToRead"


//#define debug

#ifdef debug    //如果有宏 debug  则编译程序段1, 否则编译程序段2

#define MapString @"有宏#define debug"  // 程序段1

#else

#define MapString @"没有#define debug" //程序段2


#endif


#endif /* ConfigurationFile_h */
