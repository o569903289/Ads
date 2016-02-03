//
//  ViewController.h
//  tesgGDTObjC
//
//  Created by 0280106PC0119 on 16/2/3.
//  Copyright © 2016年 quicksdk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTMobBannerView.h"
#import "GDTMobInterstitial.h"

@interface ViewController : UIViewController<GDTMobBannerViewDelegate, GDTMobInterstitialDelegate>
{
    GDTMobBannerView *_bannerView;
    GDTMobInterstitial *_interstitial;
}


@end

