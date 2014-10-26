//
//  HDTimeSlider.m
//  HaidoraTimeSlider
//
//  Created by DaiLingchi on 14-10-20.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "HDTimeSlider.h"

#pragma mark
#pragma mark HDTimeSliderButton

@interface HDTimeSliderButton : UIButton

@property (nonatomic, assign) BOOL buttonState;
/**
 *  Default is White
 */
@property (nonatomic, strong) UIColor *normalColor;
/**
 *  Default is TintColor
 */
@property (nonatomic, strong) UIColor *highlightedColor;
/**
 *  Default is TintColor
 */
@property (nonatomic, strong) UIColor *borderColor;
/**
 *  Default is 1
 */
@property (nonatomic, assign) CGFloat borderWidth;

- (id)initWithTitle:(NSString *)title;

@end

@implementation HDTimeSliderButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        [self commonInit];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)commonInit
{
    _buttonState = NO;
}

#pragma mark
#pragma mark Getter
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cornerRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2;
    // setup layer
    self.layer.backgroundColor = self.backgroundColor.CGColor;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat cornerRadius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) / 2;
    if (_buttonState)
    {
        UIBezierPath *path = [UIBezierPath
            bezierPathWithRoundedRect:CGRectInset(rect, self.borderWidth, self.borderWidth)
                         cornerRadius:cornerRadius];
        [_highlightedColor setFill];
        [path fill];
    }
    else
    {
        UIBezierPath *path = [UIBezierPath
            bezierPathWithRoundedRect:CGRectInset(rect, self.borderWidth, self.borderWidth)
                         cornerRadius:cornerRadius];
        [_normalColor setFill];
        [path fill];
    }
}

@end

#pragma mark
#pragma mark HDTimeSlider

@interface HDTimeSlider ()

@property (nonatomic, strong) NSMutableArray *buttonViews;
@property (nonatomic, strong) NSMutableArray *sepViews;

@end

@implementation HDTimeSlider

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self)
    {
        [self commonInit];
        self.items = items;
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];

    _currentIndex = 0;
    _normalColor = [UIColor colorWithRed:0.682 green:0.682 blue:0.682 alpha:1];
    _highlightedColor = [UIColor colorWithRed:0.094 green:0.643 blue:0.290 alpha:1];
    _borderColor = [UIColor whiteColor];
    _borderWidth = 2;
    _fontSize = 9;
    _font = [UIFont systemFontOfSize:_fontSize];

    _sepViews = [NSMutableArray array];
    _buttonViews = [NSMutableArray array];

    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 2;
    // TODO: Test
    _items = @[ @"1km", @"2km", @"3km" ];
    [self updateItems];
}

#pragma mark
#pragma mark Renders

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    CGRect frame = self.frame;
    if (frame.size.height == 0)
    {
        frame.size.height = 30;
    }
    if (frame.size.width == 0)
    {
        frame.size.width = CGRectGetWidth(newSuperview.bounds);
    }
    self.frame = frame;
}

- (void)layoutSubviews
{
    //    self.backgroundColor = [UIColor blueColor];
    __weak typeof(self) weakSelf = self;
    NSInteger count = _items.count;
    CGFloat width = CGRectGetWidth(self.bounds);
    //    CGFloat itemWidth = (width - (count - 1) * _itemMargin) / count;
    CGFloat itemHeight = CGRectGetHeight(self.bounds);
    CGFloat itemWidth = itemHeight;
    CGFloat itemMargin = (width - count * itemWidth) / (count - 1);

    __block CGFloat posX = 0;
    //    CGFloat posY = (CGRectGetHeight(self.bounds) - itemHeight) / 2;
    CGFloat posY = 0;
    [_buttonViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        HDTimeSliderButton *button = obj;
        button.normalColor = weakSelf.normalColor;
        button.highlightedColor = weakSelf.highlightedColor;
        button.borderWidth = weakSelf.borderWidth;
        button.borderColor = weakSelf.borderColor;
        button.titleLabel.font = weakSelf.font;
        if (idx <= weakSelf.currentIndex)
        {
            [button setButtonState:YES];
        }
        else
        {
            [button setButtonState:NO];
        }
        button.frame = CGRectMake(posX, posY, itemWidth, itemHeight);
        [button setNeedsDisplay];
        posX += itemWidth + itemMargin;
    }];

    CGFloat marginWidth = 1;
    posX = itemWidth - _borderWidth - marginWidth;
    posY = (itemHeight - itemWidth / 3) / 2;
    [_sepViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        if (idx < weakSelf.currentIndex)
        {
            view.backgroundColor = weakSelf.highlightedColor;
        }
        else
        {
            view.backgroundColor = weakSelf.borderColor;
        }
        view.frame = CGRectMake(posX, posY, itemMargin + 2 * weakSelf.borderWidth + marginWidth * 2,
                                itemWidth / 3);
        posX += itemWidth + itemMargin;
    }];
}

- (void)updateItems
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_sepViews removeAllObjects];
    [_buttonViews removeAllObjects];

    NSInteger count = _items.count;
    for (int i = 0; i < count; i++)
    {
        HDTimeSliderButton *button = [[HDTimeSliderButton alloc] initWithTitle:_items[i]];
        button.tag = i;
        [button addTarget:self
                      action:@selector(clickAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttonViews addObject:button];
        if (i < (count - 1))
        {
            UIView *view = [[UIView alloc] init];
            view.userInteractionEnabled = NO;
            [_sepViews addObject:view];
        }
    }

    for (int i = 0; i < _sepViews.count; i++)
    {
        [self addSubview:_sepViews[i]];
    }

    [self setNeedsLayout];
}

#pragma mark
#pragma mark Setter

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self updateItems];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = MIN(MAX(0, currentIndex), _items.count);
    [self setNeedsLayout];
}

-(void)setFontSize:(NSInteger)fontSize
{
	_fontSize = fontSize;
	_font = [UIFont systemFontOfSize:_fontSize];
}

#pragma mark
#pragma mark Getter

- (UIColor *)normalColor
{
    if (_normalColor == nil)
    {
        _normalColor = [UIColor whiteColor];
    }
    return _normalColor;
}

- (UIColor *)highlightedColor
{
    if (_highlightedColor == nil)
    {
        _highlightedColor = [UIColor redColor];
    }
    return _highlightedColor;
}

#pragma mark
#pragma mark Action

- (void)clickAction:(UIButton *)button
{
    _currentIndex = button.tag;
    [self setNeedsLayout];
    if (_selectedChangeBlock)
    {
        _selectedChangeBlock(_currentIndex);
    }
}

@end
