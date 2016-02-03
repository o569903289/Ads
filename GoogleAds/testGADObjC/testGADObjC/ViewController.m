//
//  ViewController.m
//  testGADObjC
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
    
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self preloadAds];
    [self showBanner];
}
-(IBAction)onButton:(id)sender
{
    [self showInterstitial];
}

-(void)preloadAds
{
    //banner
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"86e6651452b7394d7e113e78ccd19583"];
    [self.bannerView loadRequest:[GADRequest request]];
    CGRect rect = self.bannerView.frame;
    rect.origin = CGPointMake(0, self.view.frame.size.height - self.bannerView.frame.size.height);
    [self.bannerView setFrame:rect];
    [self.view addSubview:self.bannerView];
    [self.bannerView setHidden:YES];
    
    //interstitial
    self.interstitial = [self createAndLoadInterstitial];
}

//interstitial
-(void)showInterstitial
{
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
    else
    {
        NSLog(@"interstitial not Ready");
        //close event
    }
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"86e6651452b7394d7e113e78ccd19583"];
    [interstitial loadRequest:request];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
    self.interstitial = [self createAndLoadInterstitial];
    //close event
}

/// Called when an interstitial ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
}

/// Called when an interstitial ad request failed.
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Called just before presenting an interstitial.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Called before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store).
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}
//interstitial end


//banner
-(void)showBanner
{
    [self.bannerView setHidden:NO];
}

-(void)hideBanner
{
    [self.bannerView setHidden:YES];
}

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    
    adView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        adView.alpha = 1;
    }];
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    //pause game
}

- (void)adViewWillDismissScreen:(GADBannerView *)bannerView
{
    //resume game
}

- (void)adViewDidDismissScreen:(GADBannerView *)bannerView
{
    
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView
{
    
}
//banner end


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
