//
//  UIbarItem.h
//  小不点
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 桂锡鸿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIbarItem : UIView
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image hightimage:(NSString *)hightimage;
@end
