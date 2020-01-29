//
//  AddItemViewController.m
//  MyToDoList
//
//  Created by Jesper Stenlund on 2020-01-21.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

#import "AddItemViewController.h"
#import "MyTableViewController.h"
#import "SaveAndRetrieveData.h"

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
    SaveAndRetrieveData *saveAndRetrieve = [[SaveAndRetrieveData alloc]init];
    
    self.data = [saveAndRetrieve retrieveData:@"data"];
    
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
    
    [saveAndRetrieve saveData:self.data andkey:@"data"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
