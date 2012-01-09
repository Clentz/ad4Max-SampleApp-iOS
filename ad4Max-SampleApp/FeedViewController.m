//
//  FeedViewController.m
//  ad4Max-SampleApp
//
//  Copyright 2011 Publigroupe
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

// ============================================================================


#import "FeedViewController.h"

@implementation FeedViewController
@synthesize tableView,adView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [dataSource release];
    [tableView release];
    [adView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    MWFeedParser *feed = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:@"http://www.publigroupe.com/media-relations/rss.xml"]];
    [feed setDelegate:self];
    [feed parse];
}

#pragma mark - RSS Parser Delegate

- (void)feedParserDidStart:(MWFeedParser *)parser
{
    dataSource = [[NSMutableArray alloc] init];
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    [dataSource addObject:item];
    [self.tableView reloadData];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser
{
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Error");
    [parser stopParsing];
}
#pragma mark -
#pragma mark - Ad4Max Banner View Delegate

- (NSString*)getAdBoxId
{
    if(UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        // Return the AD BOX configured to serve portrait Ads
        return @"38eef07c-f3c0-4caf-89e8-251e920d0668";
    }
    else {
        // Return the AD BOX configured to serve landscape Ads
        return @"8e2dadaa-e618-4c07-aba3-c6fc532c05c4";
    }
}

-(NSString*)getAdServerURL
{
    return @"adtest.ad4max.com";
}

-(void)bannerView:(Ad4MaxBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if( [error code] == Ad4MaxBannerSizeError ) {        
        if(UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
            // Resize the Ad to match the banner size 320x50
            [self.adView setFrame:CGRectMake(self.adView.frame.origin.x, self.adView.frame.origin.y, 320.0, 50.0)];
        }
        else {
            // Resize the Ad to match the banner size 480x32
            [self.adView setFrame:CGRectMake(self.adView.frame.origin.x, self.adView.frame.origin.y, 480.0, 32.0)];
        }        
        
        // do not hide the banner
        return;
    }

    // Otherwise hide the banner
    NSLog(@"Error %@", [error description]);
    
    [UIView beginAnimations:@"hide add" context:nil];
    [UIView setAnimationDuration:0.5];
    
    [self.adView setFrame:CGRectMake(0.0, -self.adView.frame.size.height, self.adView.frame.size.width, self.adView.frame.size.height)];
    [self.tableView setFrame:CGRectMake(0.0, self.adView.frame.origin.y+self.adView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height+self.adView.frame.origin.y+self.adView.frame.size.height)];
    
    [UIView commitAnimations];

}

- (void)bannerViewWillLoadAd:(Ad4MaxBannerView *)banner
{
    NSLog(@"bannerViewWillLoadAd:");
}

- (void)bannerViewDidLoadAd:(Ad4MaxBannerView *)banner 
{
    NSLog(@"bannerViewDidLoadAd:");
    
    [UIView beginAnimations:@"show add" context:nil];
    [UIView setAnimationDuration:0.5];

    [self.adView setFrame:CGRectMake(0.0, 0.0, self.adView.frame.size.width, self.adView.frame.size.height)];
    [self.tableView setFrame:CGRectMake(0.0, self.adView.frame.origin.y+self.adView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height+self.adView.frame.origin.y+self.adView.frame.size.height)];
    
    [UIView commitAnimations];
    
}

#pragma mark -

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.row] title];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Open the article in Safari?" message:[[dataSource objectAtIndex:indexPath.row] title] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert setTag:indexPath.row];
    [alert show];
    [alert release];
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[dataSource objectAtIndex:alertView.tag] link]]];
    }
}


@end
