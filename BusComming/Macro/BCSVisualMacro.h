//
//  BCSVisualMacro.h
//  BusComming
//
//  Created by wangshuang on 2017/6/29.
//  Copyright © 2017年 wangshuang. All rights reserved.
//

#ifndef BCSVisualMacro_h
#define BCSVisualMacro_h

// font
#define SYSTEM_BLOD_FONT(s)     [UIFont boldSystemFontOfSize:s]
#define SYSTEM_DEFAULT_FONT(s)  [UIFont systemFontOfSize:s]

// color
#define kClearColor  [UIColor clearColor]
#define kWhiteColor  [UIColor whiteColor]
#define kBlackColor  [UIColor blackColor]
#define kGrayColor   [UIColor grayColor]
#define kGray2Color  [UIColor lightGrayColor]
#define kBlueColor   [UIColor blueColor]
#define kRandomColor [UIColor colorWithHue:(arc4random() % 256 / 256.0) saturation:((arc4random() % 128 / 256.0) + 0.5) brightness:((arc4random() % 128 / 256.0) + 0.5) alpha:1]

#endif /* BCSVisualMacro_h */
