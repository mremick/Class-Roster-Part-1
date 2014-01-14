//
//  MMRStudentsTableViewDataSource.h
//  firstDayDemo
//
//  Created by Matt Remick on 1/14/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMRStudentsTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *students;
- (void)initStudents;


@end
