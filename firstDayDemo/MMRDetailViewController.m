//
//  MMRDetailViewController.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/13/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRDetailViewController.h"
@import AssetsLibrary;

@interface MMRDetailViewController ()
- (IBAction)cameraButtonPushed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.student.name;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.delegate studentWasUpdated:self.student];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonPushed:(UIBarButtonItem *)sender {
    
    UIActionSheet *mySheet;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        mySheet = [[UIActionSheet alloc] initWithTitle:@"Pick Photo"
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Camera",@"Photo Library", nil];
    }
    
    else {
        mySheet = [[UIActionSheet alloc] initWithTitle:@"Pick Photo"
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"Photo Library", nil];
    }
    
    [mySheet showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Camera"]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{
            //imagePicker code here
        }];
    }
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Photo Library"]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No camera"
                                                            message:@"A camera is not currently on the device"
                                                           delegate:self
                                                  cancelButtonTitle:@"Go to photos"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        self.imageView.layer.cornerRadius = 120.0;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.image = editedImage;
        self.student.image = editedImage;
        
        
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusRestricted || [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Acces denied!"
                                                                message:@"Access to the photos has been denied"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            
            [picker dismissViewControllerAnimated:YES completion:^{
                //
            }];
            
            return;
        }
        
        else {
            //saving photos here
            NSData *photoData = UIImagePNGRepresentation(editedImage);
            NSString *studentsNameString = [NSString stringWithFormat:@"%@.png",self.student.name];
            NSString *photoFilePath = [[self documentsDirectoryPath] stringByAppendingString:studentsNameString];
            [photoData writeToFile:photoFilePath atomically:YES];
        }
    }];
}

-(NSString *)documentsDirectoryPath
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory
                                                                  inDomains:NSUserDomainMask]lastObject];
    return [documentsURL path];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Go to photos"]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:^{
            //photo library code here
        }];
    }
    
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [imagePicker dismissViewControllerAnimated:YES completion:^{
            //
        }];
        
        
        
    }
}





@end
