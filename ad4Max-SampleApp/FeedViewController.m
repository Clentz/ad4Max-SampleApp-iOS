//
//  FeedViewController.m
//  ad4Max-SampleApp
//
//  Created by Thibaut LE LEVIER on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

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
    return @"38eef07c-f3c0-4caf-89e8-251e920d0668";
}

-(NSString*)getAdServerURL
{
    return @"adtest.ad4max.com";
}

-(void)bannerView:(Ad4MaxBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Error");
}

- (void)bannerViewWillLoadAd:(Ad4MaxBannerView *)banner
{
    NSLog(@"bannerViewWillLoadAd:");
    
    if (self.adView.frame.origin.y < 0.0) {    
        [UIView beginAnimations:@"show add" context:nil];
        [UIView setAnimationDuration:0.5];
        [self.tableView setFrame:CGRectMake(0.0, 50.0, self.tableView.frame.size.width, self.tableView.frame.size.  height-50)];
        [self.adView setFrame:CGRectMake(0.0, 0.0, self.adView.frame.size.width, self.adView.frame.size.height)];
        [UIView commitAnimations];
    }
}

- (void)bannerViewDidLoadAd:(Ad4MaxBannerView *)banner 
{
    NSLog(@"bannerViewDidLoadAd:");
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
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
