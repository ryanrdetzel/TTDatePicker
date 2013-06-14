//
//  TTDateTimePicker.h
//  TalkTo
//
//  Created by Ryan on 6/13/13.
//  Copyright (c) 2013 TalkTo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTDateTimePickerDelegate <NSObject>
@optional
    -(void)hourChanged:(NSString *)hour;
    -(void)minuteChanged:(NSString *)minute;
    -(void)periodChanged:(NSString *)period;
    -(void)dateChanged:(NSString *)date;
    -(void)dateTimeChanged:(NSDate *)dateTime;
@end


@interface TTDateTimePicker : UIView <UITableViewDataSource, UITableViewDelegate>{
    UILabel *atLabel;
}

@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIImageView *fade;

@property (nonatomic, retain, readonly) NSDate *date;
@property (nonatomic, retain, readonly) NSString *dateString;
@property (nonatomic, retain, readonly) NSString *hour;
@property (nonatomic, retain, readonly) NSString *minute;
@property (nonatomic, retain, readonly) NSString *period;

@property (nonatomic, retain) NSArray *dateData;
@property (nonatomic, retain) NSArray *hourData;
@property (nonatomic, retain) NSArray *minuteData;
@property (nonatomic, retain) NSArray *periodData;

@property (nonatomic, retain) UITableView *datePicker;
@property (nonatomic, retain) UITableView *hourPicker;
@property (nonatomic, retain) UITableView *minutePicker;
@property (nonatomic, retain) UITableView *periodPicker;

@property (nonatomic, assign) id <TTDateTimePickerDelegate> delegate;

-(NSString *)dateSuffix:(int)n;
-(NSDate *)dateTime;

-(NSArray *)initialDateData;
-(NSArray *)initialHourData;
-(NSArray *)initialMinuteData;
-(NSArray *)initialPeriodData;

-(void)scroll:(UITableView *)tableView to:(int)index;
-(void)updateColors:(UIColor *)textColor backgroundColor:(UIColor *)bgColor;

@end
