//
//  MMRDetailViewController.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/13/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRDetailViewController.h"
@import AssetsLibrary;

static float viewWidth = 320.0;

float redColor = 0;
float greenColor = 0;
float blueColor = 0;

@interface MMRDetailViewController ()
- (IBAction)cameraButtonPushed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) UIColor *backgroundColor;
@property (strong,nonatomic) UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;
@property (weak, nonatomic) IBOutlet UITextField *githubTextField;

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
    self.scrollView.contentSize = CGSizeMake(1000, 1000);
    
    self.twitterTextField.delegate = self;
    self.githubTextField.delegate = self;
    
    CGFloat sliderY = 500;
    
    UISlider *slider;
    
    for (int i = 0; i < 3; i++) {
        slider = [[UISlider alloc] initWithFrame:CGRectMake(50, sliderY, viewWidth - 100, 100)];
        
        [self.scrollView addSubview:slider];
        
        UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewWidth/2 - 20,sliderY - 2,viewWidth - 50,50)];
        
        switch (i) {
            case 0:
                colorLabel.text = @"Red";
                colorLabel.textColor = [UIColor redColor];
                break;
            case 1:
                colorLabel.text = @"Green";
                colorLabel.textColor = [UIColor greenColor];
                break;
                
            default:
                colorLabel.text = @"Blue";
                colorLabel.textColor = [UIColor blueColor];
                break;
        }
        sliderY += 80;
        
        [self.scrollView addSubview:colorLabel];
        
        slider.tag = i;
        [slider addTarget:self action:@selector(colorChanged:) forControlEvents:UIControlEventAllTouchEvents];
    
    }
    
    self.applyButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, viewWidth - 50, 60)];
    self.applyButton.center = CGPointMake(self.view.center.x, sliderY + 75);
    self.applyButton.backgroundColor = [UIColor grayColor];
    self.applyButton.layer.cornerRadius = 20.0;
    NSString *buttonTitle = [NSString stringWithFormat:@"Apply changes for %@",self.student.name];
    [self.applyButton setTitle:buttonTitle forState:UIControlStateNormal];
    self.applyButton.titleLabel.textColor = [UIColor blackColor];
    
    self.applyButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:22.0];
    
    [self.scrollView addSubview:self.applyButton];
    
    [self.applyButton addTarget:self action:@selector(buttonPushed) forControlEvents:UIControlEventTouchDown];
    
    NSLog(@"WIDTH:%f",self.view.bounds.size.width);
    
}

- (void)colorChanged:(id)sender
{
    UISlider *tempSlider = (UISlider *)sender;
    
    
    
    switch (tempSlider.tag) {
        case 0:
            redColor = tempSlider.value;
            break;
        
        case 1:
            greenColor = tempSlider.value;
            
        default:
            blueColor = tempSlider.value;
            break;
    }
    
    UIColor *backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0];
    
    UIColor *buttonBackgroundColor = [UIColor colorWithRed:1 - redColor green:1 - greenColor blue:1 - blueColor alpha:1.0];
    
    self.view.backgroundColor = backgroundColor;
    self.student.color = backgroundColor;
    self.applyButton.backgroundColor = buttonBackgroundColor;
    self.navigationController.navigationBar.tintColor = buttonBackgroundColor;
}

- (void)buttonPushed
{
    [self.delegate studentWasUpdated:self.student];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.student.name;
    
    self.imageView.layer.cornerRadius = 120.0;
    self.imageView.layer.masksToBounds = YES;
    
    if (!self.student.image) {
        self.imageView.image = [UIImage imageNamed:@"smiley-face-clip-art_413110.jpg"];
    }
    
    else {
        self.imageView.image = self.student.image;
    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.twitterTextField resignFirstResponder];
    [self.githubTextField resignFirstResponder];
    
    return NO;
}





@end
