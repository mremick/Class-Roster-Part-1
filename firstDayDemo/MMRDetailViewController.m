//
//  MMRDetailViewController.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/13/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRDetailViewController.h"

@interface MMRDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation MMRDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.nameLabel.text = [NSString stringWithFormat:@"You clicked %@",self.name];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.name; 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
