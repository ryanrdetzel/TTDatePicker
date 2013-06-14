## A custom date and time picker for iOS. 

The built in one is ugly and I couldn't find a solution I liked so I wrote my own. Feel free to copy or change this but if you find bugs hit me up so I can fix them.

You can pull out the following files into your project.

- TTDateTimePicker.h
- TTDateTimePicker.m
- TTDateTimePickerDateCell.xib
- transparent.png

The following delegates are called:

-(void)hourChanged:(NSString *)hour;
-(void)minuteChanged:(NSString *)minute;
-(void)periodChanged:(NSString *)period;
-(void)dateChanged:(NSString *)date;
-(void)dateTimeChanged:(NSDate *)dateTime;


All the cells are in the xib file and the transparent.png just give it a little depth.

An example of what it looks like but everything can be changed since they're just UIViews.

![Image](screenshot.png?raw=true)
