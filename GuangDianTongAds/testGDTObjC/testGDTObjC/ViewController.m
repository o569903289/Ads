//
//  ViewController.m
//  tesgGDTObjC
//
//  Created by 0280106PC0119 on 16/2/3.
//  Copyright © 2016年 quicksdk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self preloadAds];
    [self showBanner];
}

-(void)preloadAds
{
    _bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, 0, GDTMOB_AD_SUGGEST_SIZE_320x50.width, GDTMOB_AD_SUGGEST_SIZE_320x50.height) appkey:@"100720253" placementId:@"9079537207574943610"];
    _bannerView.delegate = self;
    _bannerView.currentViewController = self;
    _bannerView.interval = 30;
    _bannerView.isGpsOn = NO;
    _bannerView.showCloseBtn = YES;
    _bannerView.isAnimationOn = YES;
    [self.view addSubview:_bannerView];
    [_bannerView loadAdAndShow];
    [_bannerView setHidden:YES];
    
    //interstitial
    _interstitial = [[GDTMobInterstitial alloc] initWithAppkey:@"2211675583" placementId:@"2954362461573316031"];
    _interstitial.delegate = self;
    _interstitial.isGpsOn = NO;
    [_interstitial loadAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    _bannerView.delegate = nil;
    _bannerView.currentViewController = nil;
    _bannerView = nil;
}

//banner
-(void)showBanner
{
    [_bannerView setHidden:NO];
}

-(void)hideBanner
{
    [_bannerView setHidden:YES];
}

- (void)bannerViewDidReceived
{
    NSLog(@"bannerViewDidReceived");
}

- (void)bannerViewFailToReceived:(NSError *)error// 请求广告条数据失败后调用
{
    NSLog(@"bannerViewFailToReceived");
}

- (void)bannerViewWillLeaveApplication// 应用进入后台时调用
{
    NSLog(@"bannerViewWillLeaveApplication");
}

- (void)bannerViewWillExposure// 广告条曝光回调
{
    NSLog(@"bannerViewWillExposure");
}

- (void)bannerViewClicked// 广告条点击回调
{
    NSLog(@"bannerViewClicked");
}

- (void)bannerViewWillClose// banner条被用户关闭时调用
{
    NSLog(@"bannerViewWillClose");
}
//banner end

//interstitial
- (void)showInterstitial {
    if ([_interstitial isReady])
    {
        UIViewController *vc = [[[UIApplication sharedApplication] keyWindow]
                            rootViewController];
        [_interstitial presentFromRootViewController:vc];
    }
    else
    {
        [_interstitial loadAd];
        NSLog(@"interstitial not Ready");
        //close event
    }
}
// 广告预加载成功回调
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialSuccessToLoadAd");
}
// 广告预加载失败回调
- (void)interstitialFailToLoadAd:(GDTMobInterstitial *)interstitial error:(NSError *)error // 插屏广告将要展示回调
{
    NSLog(@"interstitialFailToLoadAd");
}
- (void)interstitialWillPresentScreen:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialWillPresentScreen");
}
// 插屏广告视图展示成功回调
- (void)interstitialDidPresentScreen:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialDidPresentScreen");
}
// 插屏广告展示结束回调
- (void)interstitialDidDismissScreen:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialDidDismissScreen");
    [_interstitial loadAd];
    //close event
}
// 应用进入后台时回调
- (void)interstitialApplicationWillEnterBackground:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialApplicationWillEnterBackground");
}
// 插屏广告曝光时回调
- (void) interstitialWillExposure:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialWillExposure");
}
// 插屏广告点击时回调
- (void) interstitialClicked:(GDTMobInterstitial *)interstitial
{
    NSLog(@"interstitialClicked");
}
//interstitial end
@end
