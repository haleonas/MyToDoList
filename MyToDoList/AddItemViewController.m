//
//  AddItemViewController.m
//  MyToDoList
//
//  Created by Jesper Stenlund on 2020-01-21.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

#import "AddItemViewController.h"
#import "MyTableViewController.h"

@interface AddItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textInputField;
@property (weak, nonatomic) IBOutlet UISwitch *isImportantSwitch;
@property (strong,nonatomic) NSMutableArray *data;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc] init];
}
- (IBAction)addItemButton:(UIButton *)sender {
    NSUserDefaults *myData = [NSUserDefaults standardUserDefaults];
    
    self.data = [[myData objectForKey:@"data"] mutableCopy];
    NSLog(@"%@", self.data);
    
    if(self.data == NULL)
    {
        self.data = [[NSMutableArray alloc] init];
    }
    
    NSDate *date = [[NSDate alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateText = [dateFormatter stringFromDate:date];

    NSString *important;
    if(_isImportantSwitch.isOn)
    {
        important = @"YES";
    }
    else
    {
        important = @"NO";
    }
    
    NSDictionary *temp = [[NSDictionary alloc] init];
    temp = @{
        @"text": _textInputField.text,
        @"date": dateText,
        @"important": important,
        @"done": @"NO"
    };
    
    [self.data addObject:temp];
    
    [myData setObject:self.data forKey:@"data"];
    [myData synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
