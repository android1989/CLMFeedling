//
//  CLMXMLParser.m
//  CLMFeedling
//
//  Created by Andrew Hulsizer on 3/19/13.
//  Copyright (c) 2013 Andrew Hulsizer. All rights reserved.
//

#import "CLMXMLParser.h"
#import "CLMFeed.h"
#import "CLMFeedItem.h"

static NSString * const kChannelElementName = @"channel";
static NSString * const kItemElementName = @"item";
static NSString * const kFeederReloadCompletedNotification = @"finishedReading";

@interface CLMXMLParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *feedItems;
@property (nonatomic, strong) id currentElement;
@property (nonatomic, strong) NSMutableString *currentElementData;

@property (nonatomic, strong) NSXMLParser *parser;

@end

@implementation CLMXMLParser

- (void)parseData:(id)data
{
    self.parser = [[NSXMLParser alloc] initWithData:data];
    self.parser.delegate = self;
    if ([self.parser parse])
    {
        
    }
}

#pragma marn - Lazy Loading

- (NSMutableString *)currentElementData
{
    if (_currentElementData == nil) {
        _currentElementData = [[NSMutableString alloc] init];
    }
    
    return _currentElementData;
}

- (NSMutableArray *)feedItems
{
    if (_feedItems == nil) {
        _feedItems = [[NSMutableArray alloc] init];
    }
    
    return _feedItems;
}

#pragma mark - XML Parsing
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kChannelElementName]) {
        
        CLMFeed *channel = [[CLMFeed alloc] init];
        self.currentElement = channel;
    }
    else if ([elementName isEqualToString:kItemElementName]) {
        
        CLMFeedItem *post = [[CLMFeedItem alloc] init];
        [self.feedItems addObject:post];
        self.currentElement = post;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.currentElementData appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    SEL selectorName = NSSelectorFromString(elementName);
    if ([self.currentElement respondsToSelector:selectorName]) {
        
        [self.currentElement setValue:self.currentElementData forKey:elementName];
        
    }
    self.currentElementData = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    
}

@end
