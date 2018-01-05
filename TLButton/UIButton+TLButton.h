//
//  UIButton+TLButton.h
//  TLButton
//
//  Created by yishu on 2018/1/5.
//  Copyright © 2018年 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TLButton)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔
@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;

@property (assign, nonatomic)CGRect   titleRect;
@property (assign, nonatomic)CGRect   imageRect;

@end
