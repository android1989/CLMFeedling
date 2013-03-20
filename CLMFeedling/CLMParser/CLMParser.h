//
//  CLMParser.h
//  CLMFeedling
//
//  Created by Andrew Hulsizer on 3/18/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLMParser : NSObject

- (NSDictionary*)fetchFeeds:(NSDictionary*)feeds;
- (NSDictionary*)refreshFeeds;
@end
