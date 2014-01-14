//
//  MMRStudent.m
//  firstDayDemo
//
//  Created by Matt Remick on 1/14/14.
//  Copyright (c) 2014 Matt Remick. All rights reserved.
//

#import "MMRStudent.h"

@implementation MMRStudent

- (instancetype)initWithName:(NSString *)name
{
    if (self) {
        self = [super init];
        self.name = name;
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",self.name];
}


@end
