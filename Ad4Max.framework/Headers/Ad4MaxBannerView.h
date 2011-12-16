//
//  Ad4MaxBannerView.h
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


#import <UIKit/UIKit.h>

@protocol   Ad4MaxBannerViewDelegate;	
@class      Ad4MaxParamsService;

/**
 
 The Ad4MaxBannerView class provides a view that displays banner advertisements to the user using adOne advertisement network. When the user taps a banner view, the view triggers an action programmed into the advertisement.
 
 The Ad4MaxBannerView’s delegate is called when a banner view cycles to show a new advertisement as well as when the user interacts with the banner view.
 
 A banner view size must be always match the size of the advertisement defined
    in the server, otherwise your delegate will be notified of an error via
    the bannerView:didFailToReceiveAdWithError:.
 
 ### Subclassing Notes
 
 The Ad4MaxBannerView class provides a self-contained view. Your application should not subclass ADBannerView nor add subviews to a banner view.
 
 */
@interface Ad4MaxBannerView : UIView <UIWebViewDelegate> {
     
    BOOL                        initialized;
    
    // The webview containing the Ad
    UIWebView*					activeWebView;
    
    // The next Ad in a non-visible webview to enable transition between the Ads
    UIWebView*					inactiveWebView;
    
    // The number of webviews Ad ready do display
    NSInteger                   cntWebViewLoads;
    
    // The service object used to retrieve the Ad content
    Ad4MaxParamsService*        paramsService;
    
    // The timer running to handle the refresh of the Ad
    NSTimer*                    refreshTimer;    
   
}


/** @name Getting and Setting the Delegate */

/**
 The delegate of the Ad4MaxBannerView.
 
 Important: Ad4MaxBannerView does not retain its delegate so before releasing an instance of Ad4MaxBannerView that has a delegate, you must first set its delegate property to nil. For example, this can be done in your dealloc method.
 */
@property(nonatomic, assign) IBOutlet id<Ad4MaxBannerViewDelegate> ad4MaxDelegate;

/** @name Determining If the Banner View Is Showing an Ad */

/**
 A Boolean value that states whether the banner view has downloaded an Ad. (read-only)
 @return This property returns YES if an Ad is loaded; NO otherwise.
 */
@property(readonly, assign) BOOL bannerLoaded;

@end
