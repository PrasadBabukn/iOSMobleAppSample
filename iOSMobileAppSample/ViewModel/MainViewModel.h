//Om Sri Sai Ram
//  MainViewModel.h
//  iOSMobileAppSample
//
//  Created by PrasadBabu KN on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YoutubeItem.h"

@protocol MainViewModelDelegate <NSObject>
@required
-(void) DataLoadingFinished;
@end

@interface MainViewModel : NSObject<NSURLConnectionDelegate>
{
    NSMutableArray *videos;
    NSMutableData *receivedRawData;
}

@property(nonatomic, retain) NSArray *Videos;
@property(nonatomic, retain) id<MainViewModelDelegate> delegate;

@end
