//
//  ViewController.m
//  ToDoList
//
//  Created by Мариам Б. on 22.04.15.
//  Copyright (c) 2015 Мариам Б. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong,nonatomic) NSMutableArray * array_Events;
- (IBAction)Button_AddNewEvent:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self show_Notifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show_Notifications) name:@"NewEvent" object:nil];
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) show_Notifications {
    
    [self.array_Events removeAllObjects];
    [self reloadTableView];
    NSArray * array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.array_Events = [[NSMutableArray alloc]initWithArray:array];
    [self reloadTableView];
}

- (void) reloadTableView {
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array_Events.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    UILocalNotification * notif = [self.array_Events objectAtIndex:indexPath.row];
    cell.textLabel.text = [notif.userInfo objectForKey: @"event"];
    cell.detailTextLabel.text = [notif.userInfo objectForKey: @"date_event"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UILocalNotification * notif = [self.array_Events objectAtIndex:indexPath.row];
        [self.array_Events removeObjectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] cancelLocalNotification:notif];
        [self reloadTableView];
    }
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UILocalNotification * notif = [self.array_Events objectAtIndex:indexPath.row];
    
    NewEventViewController * eventView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewEvent"];
    eventView.isNewEvent = NO;
    eventView.string_EventName = [notif.userInfo objectForKey:@"event"];
    eventView.date_of_Event = notif.fireDate;
    [self.navigationController pushViewController: eventView animated:YES];  

}

- (IBAction)Button_AddNewEvent:(id)sender {
    NewEventViewController * eventView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewEvent"];
    eventView.isNewEvent = YES;
    [self.navigationController pushViewController: eventView animated:YES];
    
}
@end
