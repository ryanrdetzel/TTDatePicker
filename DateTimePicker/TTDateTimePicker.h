//
//  TTDateTimePicker.h
//  TalkTo
//
//  Created by Ryan on 6/13/13.
//  Copyright (c) 2013 TalkTo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTDateTimePicker : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain, readonly) NSString *date;
@property (nonatomic, retain, readonly) NSString *hour;
@property (nonatomic, retain, readonly) NSString *minute;
@property (nonatomic, retain, readonly) NSString *period;

@property (nonatomic, retain) NSArray *dateData;
@property (nonatomic, retain) NSArray *hourData;
@property (nonatomic, retain) NSArray *minuteData;

@property (nonatomic, retain) UITableView *datePicker;
@property (nonatomic, retain) UITableView *hourPicker;
@property (nonatomic, retain) UITableView *minutePicker;
@property (nonatomic, retain) UITableView *periodPicker;

-(NSString *)dateSuffix:(int)n;
-(void)scroll:(UITableView *)tableView to:(int)index;

-(NSArray *)initialDateData;
-(NSArray *)initialHourData;
-(NSArray *)initialMinuteData;

@end
