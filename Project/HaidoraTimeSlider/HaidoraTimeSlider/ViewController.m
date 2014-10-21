//
//  ViewController.m
//  HaidoraTimeSlider
//
//  Created by DaiLingchi on 14-10-20.
//  Copyright (c) 2014年 Haidora. All rights reserved.
//

#import "ViewController.h"
#import "HDTimeSlider.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBUtton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    HDTimeSliderButton *button = [[HDTimeSliderButton alloc] initWithTitle:@"100KM"];
    //    //    button.backgroundColor = [UIColor grayColor];
    //    button.frame = CGRectMake(50, 50, 100, 100);
    //    //    [button setTitle:@"dfdsfdsf" forState:UIControlStateNormal];
    //    //    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    //    [self.view addSubview:button];
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 100; i < 107; i++)
    {
        //        HDTimeSliderButton *button =
        //            [[HDTimeSliderButton alloc] initWithTitle:[NSString stringWithFormat:@"%dKM",
        //            i]];
        //        button.borderWidth = 5;
        [items addObject:[NSString stringWithFormat:@"%dKM", i]];
    }
    HDTimeSlider *slider = [[HDTimeSlider alloc] initWithItems:items];
    slider.frame = CGRectMake(0, 50, CGRectGetWidth(self.view.bounds), 30);
    slider.currentIndex = 0;
    //	slider.itemMargin = 20;
    //	slider.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:slider];

    _testBUtton.layer.cornerRadius = 40;
    _testBUtton.layer.borderWidth = 14;
    _testBUtton.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
