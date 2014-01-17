//
//  MMRViewController.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/13/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRViewController.h"
#import "MMRDetailViewController.h"
#import "MMRStudent.h"
#import "MMRStudentsTableViewDataSource.h"

@interface MMRViewController () <UITableViewDelegate,UIActionSheetDelegate,MMRDetailViewControllerDelegate>
@property (strong,nonatomic) UIRefreshControl *refreshControl;
@property (strong,nonatomic) MMRStudentsTableViewDataSource *tableViewDataSource;

- (IBAction)sortButtonSelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;


@end

@implementation MMRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableViewDataSource = [[MMRStudentsTableViewDataSource alloc] init];

    [self.tableViewDataSource initStudents];
    
    self.myTableview.delegate = self;
    
    self.myTableview.dataSource = self.tableViewDataSource;
    
    [self creatingRefreshControl];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)sortButtonSelected:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to sort the names?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Yes", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //sort alphabetically here
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES
                                                                    selector:@selector(localizedStandardCompare:)];
    
    NSArray *sortedArray = [self.tableViewDataSource.students sortedArrayUsingDescriptors:@[sortDescriptor]];
    [self.tableViewDataSource.students removeAllObjects];
    [self.tableViewDataSource.students addObjectsFromArray:sortedArray];
    [self.myTableview reloadData];
    
}


#pragma mark - Refresh Control Methods

- (void)creatingRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.myTableview.frame.size.height)];
    [self.myTableview addSubview:self.refreshControl];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segue"]) {
        NSIndexPath *indexPath = [self.myTableview indexPathForSelectedRow];
        MMRDetailViewController *vc = (MMRDetailViewController *)segue.destinationViewController;
        MMRStudent *student = [self.tableViewDataSource.students objectAtIndex:indexPath.row];
        vc.student = student;
        vc.delegate = self;
    }
}

- (void)studentWasUpdated:(MMRStudent *)student
{
    NSIndexPath *updatedPath = [NSIndexPath indexPathForRow:[self.tableViewDataSource.students indexOfObject:student] inSection:0];
    
    [self.myTableview reloadRowsAtIndexPaths:@[updatedPath] withRowAnimation:UITableViewRowAnimationLeft];
}

@end
