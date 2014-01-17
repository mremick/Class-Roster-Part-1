//
//  MMRDetailViewController.h
//  firstDayDemo
//
//  Created by Matt Remick on 1/13/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMRStudent.h"

@protocol MMRDetailViewControllerDelegate <NSObject>

- (void)studentWasUpdated:(MMRStudent *)student;

@end

@interface MMRDetailViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate>

//@property (strong,nonatomic) NSString *name;
@property (nonatomic, weak) MMRStudent *student;

@property (unsafe_unretained) id<MMRDetailViewControllerDelegate> delegate;

@end
