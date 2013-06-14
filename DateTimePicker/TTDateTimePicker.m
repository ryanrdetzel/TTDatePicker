//
//  TTDateTimePicker.m
//  TalkTo
//
//  Created by Ryan on 6/13/13.
//  Copyright (c) 2013 TalkTo, LLC. All rights reserved.
//

#import "TTDateTimePicker.h"

@implementation TTDateTimePicker

@synthesize periodPicker, datePicker, hourPicker, minutePicker;
@synthesize dateData, hourData, minuteData, periodData;
@synthesize date, hour, minute, period, dateString;
@synthesize delegate;

-(id)init{
    return [self initWithFrame:CGRectMake(0,0,320,150)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /* Init some data */
        dateData = [self initialDateData];
        hourData = [self initialHourData];
        minuteData = [self initialMinuteData];
        periodData = [self initialPeriodData];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIColor * greenColor = [UIColor colorWithRed:75/255.0f green:196/255.0f blue:59/255.0f alpha:1.0f];
        datePicker = [[UITableView alloc] initWithFrame:CGRectMake(0,0,120,150)];
        datePicker.dataSource = self;
        datePicker.delegate = self;
        datePicker.backgroundColor = greenColor;
        datePicker.separatorStyle = UITableViewCellSeparatorStyleNone;

        UILabel *at = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 30, 150)];
        [at setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [at setBackgroundColor:greenColor];
        [at setTextColor:[UIColor whiteColor]];
        [at setText:@"@"];
        
        hourPicker = [[UITableView alloc] initWithFrame:CGRectMake(150,0,50,150)];
        hourPicker.dataSource = self;
        hourPicker.delegate = self;
        hourPicker.backgroundColor = greenColor;
        hourPicker.separatorStyle = UITableViewCellSeparatorStyleNone;

        minutePicker = [[UITableView alloc] initWithFrame:CGRectMake(202,0,50,150)];
        minutePicker.dataSource = self;
        minutePicker.delegate = self;
        minutePicker.backgroundColor = greenColor;
        minutePicker.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        periodPicker = [[UITableView alloc] initWithFrame:CGRectMake(254,0,70,150)];
        periodPicker.dataSource = self;
        periodPicker.delegate = self;
        periodPicker.backgroundColor = greenColor;
        periodPicker.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *fade = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,150)];
        [fade setImage:[UIImage imageNamed:@"transparent.png"]];
        [fade setContentMode:UIViewContentModeCenter];
        
        [self addSubview:datePicker];
        [self addSubview:at];
        [self addSubview:hourPicker];
        [self addSubview:minutePicker];
        [self addSubview:periodPicker];
        [self addSubview:fade];
        
        // Set some defaults
        date = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:date];
        
        hour = [NSString stringWithFormat:@"%ld", (long)components.hour];
        minute = [NSString stringWithFormat:@"%ld", (long)components.minute];
        period = @"PM";
        
        [self scroll:hourPicker to:5];
        [self scroll:minutePicker to:6];
        [self scroll:periodPicker to:1];
    }

    return self;
}

-(NSArray *)initialPeriodData{
    return [[NSArray alloc] initWithObjects:@"AM", @"PM", nil];
}

-(NSArray *)initialHourData{
    NSMutableArray *hours = [[NSMutableArray alloc] initWithCapacity:12];
    for (int h=1;h<=12;h++){
        [hours addObject:[NSNumber numberWithInt:h]];
    }
    return hours;
}

-(NSArray *)initialMinuteData{
    NSMutableArray *minutes = [[NSMutableArray alloc] initWithCapacity:12];
    for (int h=0;h<12;h++){
        [minutes addObject:[NSNumber numberWithInt:h * 5]];
    }
    return minutes;
}

-(NSArray *)initialDateData{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int d=0;d<=20;d++){
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"MMM d"];
        
        NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
        dayComponent.day = d;
        
        NSCalendar *theCalendar = [NSCalendar currentCalendar];
        NSDate *dateToBeIncremented = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
        NSDateComponents* comp = [theCalendar components:NSDayCalendarUnit fromDate:dateToBeIncremented];
        
        
        
        NSString *_dateString = [NSString stringWithFormat:@"%@%@",
                          [DateFormatter stringFromDate:dateToBeIncremented],
                          [self dateSuffix:(int)comp.day]];
        
        NSDateFormatter *DOYFormatter=[[NSDateFormatter alloc] init];
        [DOYFormatter setDateFormat:@"EEEE"];
        
        NSString *dow = @"Today";
        if (d > 0){
            dow = [DOYFormatter stringFromDate:dateToBeIncremented];
        }
        
        NSArray *objects = [[NSArray alloc] initWithObjects:dow, _dateString, dateToBeIncremented, nil];
        NSArray *keys = [[NSArray alloc] initWithObjects:@"dowLabel", @"dateLabel", @"date", nil];

        NSDictionary *data = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
        [dataArray addObject:data];
    }
    return dataArray;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView {
    [tableView scrollToRowAtIndexPath:[tableView indexPathForRowAtPoint: CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y+tableView.rowHeight/2)] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString *)dateSuffix:(int)n{
    if (n >= 11 && n <= 13) {
        return @"th";
    }
    switch (n % 10) {
        case 1:  return @"st";
        case 2:  return @"nd";
        case 3:  return @"rd";
        default: return @"th";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView == datePicker){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TTDateTimePickerDateCell"];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TTDateTimePickerDateCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        if (indexPath.row <= 0 || indexPath.row > [dateData count]){
            [(UILabel *)[cell viewWithTag:1] setText:@""];
            [(UILabel *)[cell viewWithTag:2] setText:@""];
        }else{
            [(UILabel *)[cell viewWithTag:1] setText:[[dateData objectAtIndex:indexPath.row-1] objectForKey:@"dowLabel"]];
            [(UILabel *)[cell viewWithTag:2] setText:[[dateData objectAtIndex:indexPath.row-1] objectForKey:@"dateLabel"]];
        }
    }
    else if (tableView == hourPicker){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TTDateTimePickerDateCell"];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TTDateTimePickerDateCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:1];
        }
        if (indexPath.row <= 0 || indexPath.row > [hourData count]){
            [(UILabel *)[cell viewWithTag:1] setText:@""];
        }
        else{
            [(UILabel *)[cell viewWithTag:1] setText:[NSString stringWithFormat:@"%@",[hourData objectAtIndex:indexPath.row-1]]];
        }
    }
    else if (tableView == minutePicker){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TTDateTimePickerDateCell"];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TTDateTimePickerDateCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:2];
        }
        if (indexPath.row <= 0 || indexPath.row > [minuteData count]){
            [(UILabel *)[cell viewWithTag:1] setText:@""];
        }
        else{
            // Pad 0 and 5 with a leading zero
            NSString *zero = @"";
            if (indexPath.row <= 2){
                zero = @"0";
            }
            NSString *minuteString = [minuteData objectAtIndex:indexPath.row - 1];
            [(UILabel *)[cell viewWithTag:1] setText:[NSString stringWithFormat:@"%@%@",zero,minuteString]];
        }
    }
    else if (tableView == periodPicker){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TTDateTimePickerDateCell"];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TTDateTimePickerDateCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:3];
        }
        if (indexPath.row <= 0 || indexPath.row > [periodData count]){
            [(UILabel *)[cell viewWithTag:1] setText:@""];
        }
        else{
            [(UILabel *)[cell viewWithTag:1] setText:[periodData objectAtIndex:indexPath.row - 1]];
        }
    }
    return cell;
}

-(void)scroll:(UITableView *)tableView to:(int)index{
    /* 
        Scroll the tableview to this index
        TODO: Accept a string and scan the data to find that position instead of accepting an index
     */
    CGPoint point = CGPointMake(0, index * 50);
    [tableView setContentOffset:point];
}

-(NSDate *)dateTime{
    /* Returns the full date time */
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSLog(@"Current date: %@", date);
    NSDateComponents* comp = [theCalendar components:NSMinuteCalendarUnit | NSHourCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    int _hour = [hour integerValue];
    if ([period isEqualToString:@"PM"]){
        _hour += 12;
    }
    [comp setHour:_hour];
    [comp setMinute:[minute integerValue]];

    return [theCalendar dateFromComponents:comp];
}

-(NSString *)dateTimeString{
    NSDate *_date = [self dateTime];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"EEEE MMMM d HH:MM"];
    return [DateFormatter stringFromDate:_date];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float position = scrollView.contentOffset.y;
    int num = position / 50;
    
    if (scrollView == datePicker){
        if (num >= 0 && num <= [dateData count]-1){
            NSDictionary *data = [dateData objectAtIndex:num];
            NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
            [DateFormatter setDateFormat:@"EEEE MMMM d"];
            
            NSDate *_date = [data objectForKey:@"date"];
            NSString *_dateString = [DateFormatter stringFromDate:[data objectForKey:@"date"]];

            if (![dateString isEqualToString:_dateString]){
                date = _date;
                dateString = _dateString;
                if([delegate respondsToSelector:@selector(dateChanged:)]){
                    [delegate dateChanged:dateString];
                }
                if([delegate respondsToSelector:@selector(dateTimeChanged:)]){
                    [delegate dateTimeChanged:[self dateTime]];
                }
            }
        }
    }
    else if (scrollView == hourPicker){
        if (num >= 0 && num <= [hourData count]-1){
            NSString *_hour = [NSString stringWithFormat:@"%@",[hourData objectAtIndex:num]];
            if (![hour isEqualToString:_hour]){
                hour = _hour;
                if([delegate respondsToSelector:@selector(hourChanged:)]){
                    [delegate hourChanged:hour];
                }
                if([delegate respondsToSelector:@selector(dateTimeChanged:)]){
                    [delegate dateTimeChanged:[self dateTime]];
                }
            }
        }

    }
    else if (scrollView == minutePicker){
        if (num >= 0 && num <= [minuteData count]-1){
            NSString *_minute = [NSString stringWithFormat:@"%@",[minuteData objectAtIndex:num]];
            if (![minute isEqualToString:_minute]){
                minute = _minute;
                if([delegate respondsToSelector:@selector(minuteChanged:)]){
                    [delegate minuteChanged:minute];
                }
                if([delegate respondsToSelector:@selector(dateTimeChanged:)]){
                    [delegate dateTimeChanged:[self dateTime]];
                }
            }
        }
    }
    else if (scrollView == periodPicker){
        if (num >= 0 && num <= [periodData count]-1){
            NSString *_period = [NSString stringWithFormat:@"%@",[periodData objectAtIndex:num]];
            if (![period isEqualToString:_period]){
                period = _period;
                if([delegate respondsToSelector:@selector(periodChanged:)]){
                    [delegate periodChanged:period];
                }
                if([delegate respondsToSelector:@selector(dateTimeChanged:)]){
                    [delegate dateTimeChanged:[self dateTime]];
                }
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /* The +2 is to provide a buffer (padding) at the top and bottom of the list. It was the easier
        way I could think of */
    
    if (tableView == hourPicker){
        return [hourData count] + 2;
    }
    else if (tableView == minutePicker){
        return [minuteData count] + 2;
    }
    else if (tableView == periodPicker){
        return [periodData count] + 2;
    }
    // dates
    return [dateData count] + 2;
}


@end
