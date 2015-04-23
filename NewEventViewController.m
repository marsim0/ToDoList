//
//  NewEventViewController.m
//  ToDoList
//
//  Created by Мариам Б. on 22.04.15.
//  Copyright (c) 2015 Мариам Б. All rights reserved.
//

#import "NewEventViewController.h"

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TextField_NewEvent;
- (IBAction)DatePicker_Event:(UIDatePicker *)sender;
- (IBAction)Button_SaveEvent:(id)sender;
@property (strong, nonatomic) NSDate * date_NewEvent;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datePicker.minimumDate = [NSDate date];
    if (self.isNewEvent) {
        [self.TextField_NewEvent becomeFirstResponder];
    } else {
        self.TextField_NewEvent.text = self.string_EventName;
        self.TextField_NewEvent.userInteractionEnabled = NO;
        self.datePicker.userInteractionEnabled = NO;
        [self performSelector:@selector(set_Date_Current_Event) withObject:nil afterDelay:0.5];
    };
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) set_Date_Current_Event {
    [self.datePicker setDate: self.date_of_Event animated:YES];
}

- (void) set_Notification {
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"dd MMMM yyyy HH:mm";
    NSString * string_date = [format stringFromDate:self.date_NewEvent];
    
    UILocalNotification * notif = [[UILocalNotification alloc]init];
    notif.fireDate = self.date_NewEvent;
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = self.TextField_NewEvent.text;
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.TextField_NewEvent.text, @"event",                           string_date, @"date_event",nil];
    notif.userInfo = dict;
    notif.soundName = UILocalNotificationDefaultSoundName;
    notif.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewEvent" object:nil];
        
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Button_SaveEvent:(id)sender {
        if (!self.date_NewEvent) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Предупреждение" message:@"Вы не выбрали дату события" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"OK", nil];
        [alert show];
    } else if ([self.TextField_NewEvent.text length] == 0){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Предупреждение" message:@"Вы не описали событие" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else {
        [self set_Notification];
    };
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.TextField_NewEvent resignFirstResponder];
    return YES;
}

- (IBAction)DatePicker_Event:(UIDatePicker *)sender {
    self.date_NewEvent = sender.date;
}
@end
