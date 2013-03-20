//
//  CLMFeedlingManager.m
//  CLMFeedling
//
//  Created by Andrew Hulsizer on 3/18/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMFeedlingManager.h"
#import "CLMParser.h"
static NSString * const FeedlingBaseCategory = @"FeedlingBaseCategory";

@interface CLMFeedlingManager ()

@property (nonatomic, strong) NSDictionary *feeds;

@end

@implementation CLMFeedlingManager

+ (CLMFeedlingManager*)sharedFeedling
{
    static CLMFeedlingManager *_sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
		_sharedManager = [[self alloc] init];
	});
	return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _feeds = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)refreshFeeds
{
    for (NSString *category in [self.feeds allKeys])
    {
        [self refreshFeedsInCategory:category];
    }
}

- (void)refreshFeedsInCategory:(NSString*)category
{
    NSMutableArray *categoryFeeds = [self.feeds objectForKey:category];
    for (NSString *feedURL in categoryFeeds)
    {
        CLMParser *parser = [[CLMParser alloc] init];
        [parser fetchFeed:feedURL];
    }
}

- (void)addFeed:(NSString*)feedURL
{
    [self addFeed:feedURL toCategory:FeedlingBaseCategory];
}

- (void)addFeed:(NSString*)feedURL toCategory:(NSString*)category
{
    if (category && ![category isEqualToString:@""])
    {
        NSMutableArray *categoryFeeds = [self.feeds objectForKey:category];
        if (!categoryFeeds)
        {
            categoryFeeds = [[NSMutableArray alloc] init];
            [self.feeds setValue:categoryFeeds forKey:category];
        }
        [categoryFeeds addObject:feedURL];
    }
}
@end
