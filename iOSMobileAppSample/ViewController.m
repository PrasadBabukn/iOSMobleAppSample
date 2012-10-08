//Om Sri Sai Ram
//  ViewController.m
//  iOSMobileAppSample
//
//  Created by PrasadBabu KN on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    modal=[[MainViewModel alloc] init];
    modal.delegate=self;
    tblVideos=[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tblVideos setDelegate:self];
    [tblVideos setDataSource:self];
    [self.view addSubview:tblVideos];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    modal=nil;
    tblVideos=nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma ModalViewDelegate
-(void) DataLoadingFinished
{
    [tblVideos reloadData];
}

#pragma UITableView Datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [modal.Videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"YoutubeVideosCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    YoutubeItem *currentItem=[modal.Videos objectAtIndex:indexPath.row];
    [cell.textLabel setText:currentItem.title];
    [cell.imageView setImage:currentItem.thumbnail];
    return cell;
}

@end
