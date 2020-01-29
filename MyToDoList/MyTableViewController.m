//
//  MyTableViewController.m
//  MyToDoList
//
//  Created by Jesper Stenlund on 2020-01-21.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

#import "MyTableViewController.h"
#import "SaveAndRetrieveData.h"

@interface MyTableViewController ()

@property (strong, nonatomic) UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *tableViewContainer;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSMutableArray *dataDone;

@end

@implementation MyTableViewController

-(UITableView*)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(x,y,width,height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style: UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataDone = [[NSMutableArray alloc] init];
    
    self.myTableView = [self makeTableView];
    [self.tableViewContainer addSubview:self.myTableView];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section)
       {
           case 0:
               return [self.data count];
               break;
           case 1:
               NSLog(@"%lu", (unsigned long)[self.dataDone count]);
               return [self.dataDone count];
               break;
       }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSString *)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger) section
{
    NSString *sectionName;
    switch(section)
    {
        case 0:
            sectionName = @"To Do";
            break;
        case 1:
            sectionName = @"Done";
            break;
    }
    return sectionName;
}

-(UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDo"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ToDo"];
    }
    
    if(indexPath.section == 0)
    {
        cell.textLabel.text = (self.data[indexPath.row])[@"text"];
        cell.detailTextLabel.text = (self.data[indexPath.row][@"date"]);
        if([(self.data[indexPath.row])[@"important"] isEqualToString:@"YES"])
        {
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = (self.dataDone[indexPath.row])[@"text"];
        cell.detailTextLabel.text = (self.dataDone[indexPath.row][@"date"]);
    }
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithDictionary:self.data[indexPath.row]];
        
        [self.dataDone addObject:temp];
        [self.data removeObjectAtIndex:indexPath.row];
        [self saveData];
        [self.myTableView reloadData];
    }
}

-(void) retrieveData
{
    SaveAndRetrieveData *saveAndRetrieve = [[SaveAndRetrieveData alloc]init];
    self.data = [saveAndRetrieve retrieveData:@"data"];
    self.dataDone = [saveAndRetrieve retrieveData:@"dataDone"];
    [self.myTableView reloadData];
}
-(void)saveData
{
    SaveAndRetrieveData *saveAndRetrieve = [[SaveAndRetrieveData alloc]init];
    [saveAndRetrieve saveData:self.data andkey:@"data"];
    [saveAndRetrieve saveData:self.dataDone andkey:@"dataDone"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self retrieveData];
}

@end
