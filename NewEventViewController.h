//
//  NewEventViewController.h
//  ToDoList
//
//  Created by Мариам Б. on 22.04.15.
//  Copyright (c) 2015 Мариам Б. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewEventViewController : UIViewController <UITextFieldDelegate>
@property (assign,nonatomic) BOOL isNewEvent;
@property (strong,nonatomic) NSString * string_EventName;
@property (strong,nonatomic) NSDate * date_of_Event;
@end
