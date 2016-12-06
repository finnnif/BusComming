//
//  ColorConstant.h
//  YOYO
//
//  Created by wdd on 15/11/4.
//  Copyright © 2015年 wdd. All rights reserved.
//  柚柚视觉宏定义

#ifndef YOYOVisualMacro_h
#define YOYOVisualMacro_h

#define UISreenWidthScale   SCREEN_WIDTH / 320

/**
 *  new_define
 */
#define YOYODefaultFontName   @"HiraginoSansGB-W3"//@"HiraginoSans-W3"
#define YOYODefaultBlodFontName   @"HiraginoSansGB-W6"//@"HiraginoSans-W6"

#define YOYOBLOD_FONT(s)    [UIFont fontWithName:YOYODefaultBlodFontName size:(s)]
#define YOYODEFAULT_FONT(s) [UIFont fontWithName:YOYODefaultFontName size:(s)]

#define SYSTEM_BLOD_FONT(s)     [UIFont boldSystemFontOfSize:s]
#define SYSTEM_DEFAULT_FONT(s)  [UIFont systemFontOfSize:s]

#define YOYORandomColor [UIColor colorWithHue:(arc4random() % 256 / 256.0) saturation:((arc4random() % 128 / 256.0) + 0.5) brightness:((arc4random() % 128 / 256.0) + 0.5) alpha:1]

#define YOYOFONTNO0_FONT    [UIFont fontWithName:YOYODefaultBlodFontName size:20]
#define YOYOFONTNO0_COLOR   UIColorFromHex(0x000000)

#define YOYOFONTNO1_FONT    [UIFont fontWithName:YOYODefaultFontName size:17]
#define YOYOFONTNO1_COLOR   UIColorFromHex(0x000000)

#define YOYOFONTNO2_FONT    [UIFont fontWithName:YOYODefaultFontName size:16]
#define YOYOFONTNO2_COLOR   UIColorFromHex(0x555555)

#define YOYOFONTNO3_FONT    [UIFont fontWithName:YOYODefaultBlodFontName size:15]
#define YOYOFONTNO3_COLOR   UIColorFromHex(0x333333)

#define YOYOFONTNO4_FONT    [UIFont fontWithName:YOYODefaultFontName size:14]
#define YOYOFONTNO4_COLOR   UIColorFromHex(0x000000)

#define YOYOFONTNO5_FONT    [UIFont fontWithName:YOYODefaultFontName size:15]
#define YOYOFONTNO5_COLOR   UIColorFromHex(0x555555)

#define YOYOFONTNO6_FONT    [UIFont fontWithName:YOYODefaultFontName size:12]
#define YOYOFONTNO6_COLOR   UIColorFromHex(0x7D728B)

#define YOYOFONTNO7_FONT    [UIFont fontWithName:YOYODefaultFontName size:11]
#define YOYOFONTNO7_COLOR   UIColorFromHex(0x999999)

#define YOYOFONTNO8_FONT    [UIFont fontWithName:YOYODefaultFontName size:14]
#define YOYOFONTNO8_COLOR   UIColorFromHex(0xFF4C4C)

#define YOYOFONTNO9_FONT    [UIFont fontWithName:YOYODefaultFontName size:12]
#define YOYOFONTNO9_COLOR   UIColorFromHex(0xFF4C4C)

#define YOYOFONTNO11_FONT    [UIFont fontWithName:YOYODefaultBlodFontName size:17]
#define YOYOFONTNO11_COLOR   UIColorFromHex(0xFFFFFF)

#define YOYOFONTNO12_FONT    [UIFont fontWithName:YOYODefaultFontName size:15]
#define YOYOFONTNO12_COLOR   UIColorFromHex(0xFFFFFF)

#define YOYOFONTNO13_FONT    [UIFont fontWithName:YOYODefaultFontName size:12]
#define YOYOFONTNO13_COLOR   UIColorFromHex(0xFFFFFF)

#define YOYOFONTNO14_FONT    [UIFont fontWithName:YOYODefaultFontName size:12]
#define YOYOFONTNO14_COLOR   UIColorFromHexWithAlpha(0xFFFFFF, 0.7)

#define YOYO_LIST_PRESS_COLOR UIColorFromHex(0xFAF8FA) //列表点击效果

#define YOYO_PADDING     15

#define YOYO_BORDER_LINE_COLOR    UIColorFromHex(0xF0F0F0)
#define YOYO_BORDER_LINE_HEIGHT    0.5
#define YOYO_BUTTON_COLOR         UIColorFromHex(0xFF4C4C)//0xFE71A1

#define YOYO_PINK_COLOR      UIColorFromRGB(254, 113, 161)
#define YOYO_MAIN_COLOR      UIColorFromHex(0xFF4C4C)
#define YOYO_BACK_COLOR      UIColorFromHex(0xF4F4F4)
#define YOYO_PRESS_COLOR     UIColorFromHex(0xFAF8FA)
#define YOYO_CANCEL_COLOR    UIColorFromHex(0xE6DCE6)
#define YOYO_BACK_COLOR_NO2    UIColorFromHex(0xFF6B9E)


#define YOYO_TAG_HOT_COLOR       UIColorFromHex(0xFF4C4C)  //热度标签背景色
#define YOYO_TAG_EXTEN_COLOR      UIColorFromHex(0xFFC800) //推广标签背景色
#define YOYO_TAG_ACTIVITY_COLOR   UIColorFromHex(0xFE71A1) //活动标签背景色
#define YOYO_TAG_SPEC_COLOR       UIColorFromHex(0x46C17A)    //专辑标签背景色

#define YOYO_CORNERRADIUS    5 //按钮圆角半径
#define YOYO_CELL_PADDING    5 //cell间距

#define YOYO_TOP_SEGEMENT_HEIGHT  35 //选择控件高度

#define YOYO_CYCLE_IMAGE_RATE 0.375 //轮播图长宽比例

#define YOYO_CELAR_BACK_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

#define YOYO_ALERT_BACK_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]
/**
 *  old_define
 */
#define TINT_COLOR                  UIColorFromHex(0xFF5E56)
#define THEME_COLOR                 UIColorFromHex(0xF0F0F0)
#define LINE_COLOR                  UIColorFromHex(0xE6E6E6)

#define GROUP_TABLE_SEPARATOR_COLOR UIColorFromHex(0xDBD8D0)

//Cell

#define NAME_FONT            [UIFont systemFontOfSize:12]
#define LEVEL_FONT           [UIFont boldSystemFontOfSize:8]
#define TIME_FONT            [UIFont systemFontOfSize:10]
#define BABY_AGE_Font        [UIFont systemFontOfSize:12]
#define ANSWER_QUANTITY_FONT [UIFont systemFontOfSize:10]
#define DELETE_FONT          [UIFont systemFontOfSize:12]
#define QUESTION_FONT        [UIFont systemFontOfSize:15]
#define ANSWER_FONT          [UIFont systemFontOfSize:15]
#define MESSAGE_FONT         [UIFont systemFontOfSize:14]
#define REFERENCE_FONT       [UIFont systemFontOfSize:12]
#define PRONUMBER_FONT       [UIFont boldSystemFontOfSize:20]
#define PROWORD_FONT         [UIFont systemFontOfSize:12]
#define LISTTITLE_FONT       [UIFont systemFontOfSize:15]
#define DETAILTITLE_FONT     [UIFont systemFontOfSize:16]

#define NAME_COLOR                  GRAY_3
#define TIME_COLOR                  UIColorFromHex(0xB2B2B2)
#define BABY_AGE_COLOR              UIColorFromHex(0x7f8a9f)
#define ANSWER_QUANTITY_COLOR       UIColorFromHex(0xB2B2B2)
#define DELETE_COLOR                UIColorFromHex(0x53738C)
#define LEVEL_COLOR                 UIColorFromHex(0xDA6363)
#define QUESTION_COLOR              GRAY_2
#define ANSWER_COLOR                GRAY_2
#define MESSAGE_COLOR               GRAY_3
#define REFERENCE_COLOR             UIColorFromHex(0x777270)
#define REFERENCE_BACKGROUND_COLOR  UIColorFromHex(0xf5f5f5)
#define BUTTON_TITLE_COLOR          UIColorFromHex(0xB2B2B2)
#define BUTTON_BORDER_COLOR         UIColorFromHex(0xE58989)
#define PRONUMBER_COLOR             UIColorFromHex(0xFF6767)
#define PROWORD_COLOR               GRAY_3


#define YOYOGRAY_COLOR(g)           UIColorFromRGB((g), (g), (g))
#define GRAY_1                      UIColorFromHex(0x111111)
#define GRAY_2                      UIColorFromHex(0x222222)
#define GRAY_3                      UIColorFromHex(0x333333)
#define GRAY_4                      UIColorFromHex(0x444444)
#define GRAY_5                      UIColorFromHex(0x555555)
#define GRAY_6                      UIColorFromHex(0x666666)
#define GRAY_7                      UIColorFromHex(0x777777)
#define GRAY_8                      UIColorFromHex(0x888888)
#define GRAY_9                      UIColorFromHex(0x999999)

#endif
