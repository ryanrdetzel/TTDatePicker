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
    
    TTDateTimePicker *picker = [[TTDateTimePicker alloc] init];
    [self.view addSubview:picker];
    [picker setDelegate:self];
}

- (void)hourChanged:(NSString *)hour{
    NSLog(@"HOUR CHANGED: %@", hour);
}

- (void)minuteChanged:(NSString *)hour{
    NSLog(@"Minute CHANGED: %@", hour);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
