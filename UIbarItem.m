//
//  UIbarItem.m
//  小不点
//
//  Created by MS on 16-1-12.
//  Copyright (c) 2016年 桂锡鸿. All rights reserved.
//

#import "UIbarItem.h"

@implementation UIbarItem

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image hightimage:(NSString *)hightimage
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
       [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightimage] forState:UIControlStateSelected];
    [button setFrame:CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height)];

    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

@end
