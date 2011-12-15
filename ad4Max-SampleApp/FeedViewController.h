//
//  FeedViewController.h
//  ad4Max-SampleApp
//
//  Created by Thibaut LE LEVIER on 12/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import <Ad4Max/Ad4Max.h>

@interface FeedViewController : UIViewController <UITabBarDelegate,UITableViewDataSource,MWFeedParserDelegate,Ad4MaxBannerViewDelegate> {
    NSMutableArray *dataSource;
}

@property (retain,nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) IBOutlet Ad4MaxBannerView *adView;

@end
