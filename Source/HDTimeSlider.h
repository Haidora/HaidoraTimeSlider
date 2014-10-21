//
//  HDTimeSlider.h
//  HaidoraTimeSlider
//
//  Created by DaiLingchi on 14-10-20.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark
#pragma mark HDTimeSlider

@interface HDTimeSlider : UIView

@property (nonatomic, strong) NSArray *items;
/**
 *  Default is zero.
 */
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIColor *highlightedColor;

@property (nonatomic, strong) UIColor *borderColor;
/**
 *  Default is 2
 */
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, copy) void (^selectedChangeBlock)(NSInteger index);

- (id)initWithItems:(NSArray *)items;

@end
