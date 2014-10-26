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

// IB_DESIGNABLE
@interface HDTimeSlider : UIView

@property (nonatomic, strong) NSArray *items;
/**
 *  Default is zero.
 */
@property (nonatomic, assign) IBInspectable NSInteger currentIndex;

@property (nonatomic, strong) IBInspectable UIColor *normalColor;

@property (nonatomic, strong) IBInspectable UIColor *highlightedColor;

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
/**
 *  Default is 12
 */
@property (nonatomic, assign) IBInspectable NSInteger fontSize;

/**
 *  Default is [UIFont systemFontOfSize:fontSize]
 */
@property (nonatomic, strong) UIFont *font;
/**
 *  Default is 2
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (nonatomic, copy) void (^selectedChangeBlock)(NSInteger index);

- (id)initWithItems:(NSArray *)items;

@end
