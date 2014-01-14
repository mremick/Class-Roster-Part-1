//
//  MMRStudentsTableViewDataSource.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/14/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRStudentsTableViewDataSource.h"
#import "MMRStudent.h"
#import "MMRViewController.h"

@implementation MMRStudentsTableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.students count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    MMRStudent *student = [self.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = student.name;
    
    NSLog(@"cell for row");
    
    return cell;
}

- (void)initStudents
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
    NSArray *studentsFromPlist = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    self.students = [NSMutableArray array];
    
    for (NSDictionary *aStudent in studentsFromPlist) {
        MMRStudent *student = [[MMRStudent alloc] initWithName:[aStudent objectForKey:@"name"]];
        [self.students addObject:student];
    }
    
}

@end
