//
//  MMRStudent.h
//  firstDayDemo
//
//  Created by Matt Remick on 1/14/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMRStudent : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) UIImage *image;

- (instancetype)initWithName:(NSString *)name;


@end
