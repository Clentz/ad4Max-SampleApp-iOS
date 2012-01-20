//
//
//  Ad4MaxBannerViewDelegate.h
//  Ad4Max SDK 1.0
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


#import "Ad4MaxBannerView.h"

#import <Foundation/Foundation.h>

@class CLLocation;

/**
 The Ad4MaxBannerViewDelegate protocol is implemented by an object to configure an Ad4MaxBannerView and to react to changes in an Ad4MaxBannerView object. The banner view calls its delegate before loading a new banner view, when a new advertisement is loaded, when the user interacts with an advertisement, and when errors occur.
 */
@protocol Ad4MaxBannerViewDelegate <NSObject>

/** @name Configure the Banner View - Mandatory parameters */

/** Get your AD BOX account for which the Ad will be displayed
 
 The returned value can vary at run time and you could decide to return different AD BOX ids for the same banner view. This is typically the case if your application supports the landscape orientation, as an AD BOX is associated to a single Ad format.

 This delegate method is mandatory otherwise you will get an error through your delegate method bannerView:didFailToReceiveAdWithError:.

 @return A string representing your AD BOX id (eg. '38eef07c-f3c0-4caf-89e8-251e920d0668')
 */
- (NSString*)getAdBoxId;

/** Get the URL of the server responsible for serving the Ads 

 This delegate method is mandatory otherwise you will get an error through your delegate method bannerView:didFailToReceiveAdWithError:.

 @return A string representing the server URL (eg. 'adtest.ad4max.com' or 'http://adtest.ad4max.com')
 */
- (NSString*)getAdServerURL;

/** @name Handling Errors */

/** Called when a banner view fails to load a new Ad.
 
 This delegate method is mandatory otherwise you will get the errors logged to the console.
 @param banner The banner view that failed to load an Ad.
 @param error The error object that describes the problem.
 */
- (void)bannerView:(Ad4MaxBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

@optional

/** @name Configure the Banner View - Optional parameters */

/** Set the time interval at which the banner ad will be refreshed.
 
 If you do not implement this method, the default value will be 45 seconds.
 The minimum value is 30 seconds, values below 30 seconds will be floored to 30 seconds. 
 If you want to disable the refresh, you can simply return 0.
 
 @return An integer setting the refresh rate of the Ads or 0 if you want to disable the refresh
 */
- (NSUInteger)getAdRefreshRate;

/** @name Improving the Targeting - Optional Methods */

/** Set the location of the user of your application. 
 
 You have to provide a standard CLLocation object and use in your application a CLLocationManager to update it. You don't need to notify the banner view when an update to the user location is available, this method will be called each time a new Ad will be loaded. 
 
 Notice that you should not request the user location only to target Ads as your application might be rejected by Apple (see §4.4 in App Store Review Guidelines: https://developer.apple.com/appstore/resources/approval/guidelines.html)
 
 @return A CLLocation object giving the current device location
 */
- (CLLocation*)getUserGeoLocation;

/** Set categories of Ads you want to display in your application
  
 If you want to display Ads related to your application (eg. Health related Ads), you can specify categories by this method. A maximum of three categories is possible.
 
 The list of categories is still under construction so using this method will not have any effect at this time. Stay tunes!

 @return A string containing a maximum of three Ad categories separated by semicolon (eg. '101;2003;200'). 
 */
- (NSString*)getTargetedPublisherCategories;

/** Specify whether you accept Ads in another language than the language of the user.
 
 By default Ads could be displayed in a different language, specially in countries speaking multiple languages.
 @return YES if you want to force the language of the Ad to the current device language
 */
- (BOOL)doForceLanguage;

/** @name Detecting When Ads Are Loaded or Clicked - Optional Methods
 */

/** Called before a new banner Ad is loaded
    @param banner The banner view that is about to load a new advertisement.
 */
- (void)bannerViewWillLoadAd:(Ad4MaxBannerView *)banner;

/** Called when a new banner Ad is loaded and ready to be displayed.
 @param banner The banner view that loaded a new Ad.
 */
- (void)bannerViewDidLoadAd:(Ad4MaxBannerView *)banner;

/** Called before a banner view executes an action. 
 
 This method is called when the user clicks the banner view. To allow the action to be triggered, return YES. To suppress the action, return NO. Your application should almost always allow actions to be triggered; preventing actions may alter the Ads your application sees and reduce the revenue your application earns.
 
 If the willLeave parameter is YES, then your application is moved to the background shortly after this method returns. This is the only possible value as of today, NO parameter will not be used.
 
    @param banner The banner view that the user clicked on.
    @param willLeave YES if Safari will be launched to execute the action; NO if the action is going to be executed inside your application.
    @return Your delegate returns YES if the action should execute; NO to prevent the banner action from executing.
 */
- (BOOL)bannerViewActionShouldBegin:(Ad4MaxBannerView *)banner willLeaveApplication:(BOOL)willLeave;

@end

/**
 Definition of error codes
 */
enum {
    Ad4MaxUnknownError = 0, /**< Ad4MaxUnknownError */
    Ad4MaxConfigurationError = 1, /**< Ad4MaxConfigurationError */
    Ad4MaxServerFailureError = 2, /**< Ad4MaxServerFailureError */
    Ad4MaxBannerSizeError = 3, /**< Ad4MaxBannerSizeError */
    Ad4MaxBannerVisibilityError = 4, /**< Ad4MaxBannerVisibilityError */
    Ad4MaxNetworkNotReachableError = 5, /**< Ad4MaxNetworkNotReachableError */
    Ad4MaxNoAdsAvailableError = 6 /**< Ad4MaxNoAdsAvailableError */
};
typedef NSUInteger Ad4MaxError;
