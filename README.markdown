Intro
=======================

This application demonstrates the use of ad4Max iOS SDK through a very basic App (a RSS reader).

![Sample application screenshot](http://clentz.github.com/ad4Max-SDK-iOS/tutorial/screenshotSampleApp.png)

It demonstrates also some more advanced use of the SDK like:

* how to display Ads both in Portrait and Landscape modes
* how to show an Ad banner only when an Ad is available

For more information, see the [GitHub page of the framework](https://github.com/Clentz/ad4Max-SDK-iOS).

Installation
=======================

You can clone the GitHub repository (or download it via GitHub) and then compiles the application by opening the XCode project ad4Max-SampleApp.xcodeproj.

Most of the interesting source code is located in FeedViewController.h/.m files.

How to display Ads both in Portrait and Landscape modes
=======================

With ad4Max, you have one AdBox for each banner size thus you need two AdBoxes to be able to serve both portrait and landscape Ads.

Each time the device orientation changes, your delegate method getAdBoxId will be called so you need to provide the right AdBox ID for the current orientation of the device:

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

Notice that you also have to resize the Ad4MaxBannerView (UIView) to match the current banner size but you should only do this once the new Ad have been received (otherwise the Ad banner will be either too large (landscape to portrait rotation) or cut (portrait to landscape rotation)). You will be noticed of this because your delegate bannerView:didFailToReceiveAdWithError: method will be called with an error type Ad4MaxBannerSizeError. Here is the way this is handled in the sample application code:

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

    	[...]

	}


How to show an Ad banner only when an Ad is available
=======================

The basic way to achieve this is to hide the banner on load and when bannerView:didFailToReceiveAdWithError: is called on your delegate and to make it visible when bannerViewDidLoadAd: is called on your delegate.

Here is the sample application code to see how to make the Ad appear and disappear smoothly:
	
	-(void)bannerView:(Ad4MaxBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
	{
		[...]
		
	    [UIView beginAnimations:@"hide add" context:nil];
	    [UIView setAnimationDuration:0.5];

	    [self.adView setFrame:CGRectMake(0.0, -self.adView.frame.size.height, self.adView.frame.size.width, self.adView.frame.size.height)];
	    [self.tableView setFrame:CGRectMake(0.0, self.adView.frame.origin.y+self.adView.frame.size.height, self.tableView.frame.size.width, self.tableView.frame.size.height+self.adView.frame.origin.y+self.adView.frame.size.height)];

	    [UIView commitAnimations];

	}
	
Notice that the Ad4MaxBannerView (UIView) is positioned out of the screen in Interface Builder, this is how the Ad banner is not shown on load.

	
Licence
===========

This Software is licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License.  You may obtain a copy
of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
License for the specific language governing permissions and limitations under
the License.

This product includes third-party softwares compatible with this Apache license but you must make sure you conform to these licenses if you use, install, modify or redistribute this software:

- [Reachability](http://developer.apple.com/library/ios/#samplecode/Reachability/Introduction/Intro.html) licensed by Apple Inc.
- [UIDevice-with-UniqueIdentifier-for-iOS-5](https://github.com/gekitz/UIDevice-with-UniqueIdentifier-for-iOS-5/blob/master/license) licensed by the Georg Kitz. 

Copyright (C) 2011 Publigroupe All Rights Reserved.

