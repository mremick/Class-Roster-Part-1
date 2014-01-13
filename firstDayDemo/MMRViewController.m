//
//  MMRViewController.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/13/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRViewController.h"
#import "MMRDetailViewController.h"

@interface MMRViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (strong,nonatomic) NSArray *students;
@property (strong,nonatomic) NSArray *instructors;
@property (strong,nonatomic) UIRefreshControl *refreshControl;


@end

@implementation MMRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.myTableview.delegate = self;
    self.myTableview.dataSource = self;
    
    self.instructors = [[NSArray alloc] initWithObjects:@"Brad",@"Clem", nil];
    self.students = [[NSArray alloc] initWithObjects:@"Dale",@"John",@"Matt", nil];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.myTableview.frame.size.height)];
    [self.myTableview addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.students count];
    }
    
    else {
        return [self.instructors count];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Students";
    }
    
    else {
        return @"Instrucors";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.students objectAtIndex:indexPath.row];
    }
    
    else {
        cell.textLabel.text = [self.instructors objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segue"]) {
        NSIndexPath *indexPath = [self.myTableview indexPathForSelectedRow];
        MMRDetailViewController *vc = (MMRDetailViewController *)segue.destinationViewController;
        if (indexPath.section == 0) {
            vc.name = [self.students objectAtIndex:indexPath.row];
        }
        
        else {
            vc.name = [self.instructors objectAtIndex:indexPath.row];
        }
    }
}

@end
