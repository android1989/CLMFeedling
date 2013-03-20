//
//  CLMFeedlingManager.m
//  CLMFeedling
//
//  Created by Andrew Hulsizer on 3/18/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMFeedlingManager.h"

@implementation CLMFeedlingManager

- (CLMFeedlingManager*)sharedFeedling
{
    static CLMFeedlingManager *manager;
    static dispatch_once_t onceToken;
}
@end
