//
//  ViewController.m
//  DateTimePicker
//
//  Created by Ryan on 6/13/13.
//  Copyright (c) 2013 Ryan Detzel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self.view setBackgroundColor:[UIColor blueColor]];
    
    TTDateTimePicker *picker = [[TTDateTimePicker alloc] init];
    [picker setDelegate:self];
    UIColor *blue = [UIColor colorWithRed:75/255.0f green:109/255.0f blue:204/255.0f alpha:1.0f];
    [picker updateColors:[UIColor whiteColor] backgroundColor:blue];
    [[picker fade] setImage:[UIImage imageNamed:@"transparent-blue.png"]];
    [self.view addSubview:picker];

    TTDateTimePicker *picker2 = [[TTDateTimePicker alloc] initWithFrame:CGRectMake(0, 150, 320, 480)];
    [picker2 setDelegate:self];
    [self.view addSubview:picker2];
    
    TTDateTimePicker *picker3 = [[TTDateTimePicker alloc] initWithFrame:CGRectMake(0, 300, 320, 480)];
    [picker3 setDelegate:self];
    UIColor *red = [UIColor colorWithRed:195/255.0f green:32/255.0f blue:67/255.0f alpha:1.0f];
    [picker3 updateColors:[UIColor whiteColor] backgroundColor:red];
    [[picker3 fade] setImage:[UIImage imageNamed:@"transparent-red.png"]];
    [self.view addSubview:picker3];
}

- (void)hourChanged:(NSString *)hour{
    //NSLog(@"HOUR CHANGED: %@", hour);
}

- (void)minuteChanged:(NSString *)minute{
    //NSLog(@"Minute CHANGED: %@", minute);
}

-(void)periodChanged:(NSString *)period{
    //NSLog(@"Period CHANGED: %@", period);
}
-(void)dateChanged:(NSString *)date{
    //NSLog(@"Date CHANGED: %@", date);
}
-(void)dateTimeChanged:(NSDate *)dateTime{
    NSLog(@"DateTime CHANGED: %@", dateTime);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
