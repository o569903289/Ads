//
//  ViewController.h
//  testGADObjC
//
//  Created by 0280106PC0119 on 16/2/3.
//  Copyright © 2016年 quicksdk. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface ViewController : UIViewController<GADBannerViewDelegate, GADInterstitialDelegate>

@property(nonatomic, strong) GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

