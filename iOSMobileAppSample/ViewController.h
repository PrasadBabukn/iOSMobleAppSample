//Om Sri Sai Ram
//  ViewController.h
//  iOSMobileAppSample
//
//  Created by PrasadBabu KN on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewModel.h"

@interface ViewController : UIViewController<MainViewModelDelegate, UITableViewDelegate, UITableViewDataSource>
{
    MainViewModel *modal;
    
    UITableView *tblVideos;
}

@end
