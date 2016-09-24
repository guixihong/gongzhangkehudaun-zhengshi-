//
//  SearchViewController.h
//  ForemanAPP
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TYFSencondViewControllerDelegate <NSObject>


//-(void)setOn:(NSString *)isOn With:(NSInteger) index;

-(void)setOn:(NSString *)isOn;

@end
@interface SearchViewController : UIViewController
@property(assign)id<TYFSencondViewControllerDelegate>delegate;
@end
