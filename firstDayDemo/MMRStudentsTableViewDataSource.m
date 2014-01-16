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
    
    if (student.image) {
        cell.imageView.layer.cornerRadius = cell.imageView.layer.bounds.size.height/2;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.image = student.image;
        
    }
    
    else {
        cell.imageView.image = nil;
    }
        
    return cell;
}

- (void)initStudents
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
    NSArray *studentsFromPlist = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    self.students = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    
    for (NSDictionary *aStudent in studentsFromPlist) {
        MMRStudent *student = [[MMRStudent alloc] initWithName:[aStudent objectForKey:@"name"]];
        
        NSString *studentsNameString = [NSString stringWithFormat:@"%@.png",[aStudent objectForKey:@"name"]];

        
        if ([fileManager fileExistsAtPath:[[self documentsDirectoryPath] stringByAppendingString:studentsNameString]]) {
            NSData *photoData = [fileManager contentsAtPath:[[self documentsDirectoryPath] stringByAppendingString:studentsNameString]];
            UIImage *imageFromData = [UIImage imageWithData:photoData];
            
            student.image = imageFromData; 
        }
        
        [self.students addObject:student];
        
    }
    
}

-(NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory
                                                                  inDomains:NSUserDomainMask]lastObject];
    return [documentsURL path];
}

@end
