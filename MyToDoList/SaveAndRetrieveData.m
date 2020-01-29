//
//  SaveAndRetrieveData.m
//  MyToDoList
//
//  Created by Jesper Stenlund on 2020-01-24.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

#import "SaveAndRetrieveData.h"

@implementation SaveAndRetrieveData

-(void)saveData:(NSMutableArray *)arr andkey:(NSString *)key
{
    NSUserDefaults *myData = [NSUserDefaults standardUserDefaults];

    [myData setObject:arr forKey:key];
    [myData synchronize];
}

-(NSMutableArray*) retrieveData:(NSString*)key
{
    NSUserDefaults *myData = [NSUserDefaults standardUserDefaults];
      
    NSMutableArray *data = [[myData objectForKey:key] mutableCopy];
      
    if(data == NULL)
    {
          data = [[NSMutableArray alloc] init];
    }
    
    return data;
}

@end
