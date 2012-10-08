//Om Sri Sai Ram
//  MainViewModel.m
//  iOSMobileAppSample
//
//  Created by PrasadBabu KN on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewModel.h"

NSString *const youtubeSearchUrl=@"https://gdata.youtube.com/feeds/api/videos?v=2&alt=jsonc&author=MobileTechReview&max-results=50";

@interface MainViewModel (Private)
-(void) MakeWebRequestCallWithUrl:(NSString*) strUrl;
@end

@implementation MainViewModel

@synthesize Videos=videos;
@synthesize delegate;

-(id) init
{
    self = [super init];
    if (self) 
    {
        videos=[[NSMutableArray alloc] initWithCapacity:50];
        [self MakeWebRequestCallWithUrl:youtubeSearchUrl];
    }
    return self;
}

-(void) MakeWebRequestCallWithUrl:(NSString*) strUrl
{
    NSURL *url=[NSURL URLWithString:strUrl];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection)
    {
        [connection start]; //Its an asyn method
        receivedRawData=[[NSMutableData alloc] init];
    }
}

#pragma NSURLConnectionDelegate Methods Implementation
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error...");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedRawData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedRawData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Parse the responsedata to the JSON serializer
    NSError *error;
    NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:receivedRawData options:kNilOptions error:&error];
    NSDictionary *dataNodeDictionary=[jsonDictionary objectForKey:@"data"];
    NSDictionary *listNode=[dataNodeDictionary objectForKey:@"items"];
    if (nil!=listNode && 0!=[listNode count])
    {
        for (NSDictionary *enumerateDict in listNode) 
        {
            NSDictionary *itemDictionary=enumerateDict; //Clone the enumerate dictions. because you can not modify the itme in for
            
            YoutubeItem *currentItem=[[YoutubeItem alloc] init];
            if([itemDictionary objectForKey:@"id"])
                currentItem.itemId=[itemDictionary objectForKey:@"id"];
            if([itemDictionary objectForKey:@"title"])
                currentItem.title=[itemDictionary objectForKey:@"title"];
            if([itemDictionary objectForKey:@"thumbnail"] && [[itemDictionary objectForKey:@"thumbnail"] objectForKey:@"sqDefault"])
            {
                NSURL *thumbUrl=[NSURL URLWithString:[[itemDictionary objectForKey:@"thumbnail"] objectForKey:@"sqDefault"]];
                currentItem.thumbnail=[UIImage imageWithData:[NSData dataWithContentsOfURL:thumbUrl]];
            }
            [videos addObject:currentItem];
        }
    }
    [self.delegate DataLoadingFinished];
}

@end
