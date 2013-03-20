//
//  CLMParser.m
//  CLMFeedling
//
//  Created by Andrew Hulsizer on 3/18/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMParser.h"
#import "AFNetworking.h"
#import "CLMFeed.h"
#import "CLMFeedItem.h"
#import "CLMXMLParser.h"
#import "CLMAtomParser.h"

static NSString * const kRSSFeed = @"rss";
static NSString * const kATOMFeed = @"feed";

@interface CLMParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSDictionary *feeds;
@property (nonatomic, strong) id clmParser;

@end

@implementation CLMParser

- (void)fetchFeed:(NSString*)feedURL
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:feedURL]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:feedURL]];
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:responseObject];
        XMLParser.delegate = self;
        [XMLParser parse];
        [self.clmParser parseData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR");
    }];
    
    [operation start];

}

#pragma mark - XML Parsing
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kRSSFeed]) {
        
        self.clmParser = [[CLMXMLParser alloc] init];
    }
    else if ([elementName isEqualToString:kATOMFeed]) {
        
        self.clmParser = [[CLMAtomParser alloc] init];
    }
    
    [parser abortParsing];
}


@end
