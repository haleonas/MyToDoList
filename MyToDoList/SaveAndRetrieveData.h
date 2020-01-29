//
//  SaveAndRetrieveData.h
//  MyToDoList
//
//  Created by Jesper Stenlund on 2020-01-24.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveAndRetrieveData : NSObject
-(void)saveData:(NSMutableArray*)dict andkey:(NSString*)key;
-(NSMutableArray*)retrieveData:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
