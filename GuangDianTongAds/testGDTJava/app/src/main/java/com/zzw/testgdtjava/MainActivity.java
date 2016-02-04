package com.zzw.testgdtjava;

import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;

import com.qq.e.ads.banner.ADSize;
import com.qq.e.ads.banner.AbstractBannerADListener;
import com.qq.e.ads.banner.BannerView;
import com.qq.e.ads.interstitial.AbstractInterstitialADListener;
import com.qq.e.ads.interstitial.InterstitialAD;


public class MainActivity extends ActionBarActivity {

    BannerView bannerView;
    InterstitialAD iad;
    private RelativeLayout mainContainer;
    private boolean isInterstitialReady;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button btn = (Button)findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showInterstitial();
            }
        });


        this.preloadAds();
        this.showBanner();
    }

    void preloadAds()
    {
        //banner
        bannerView = new BannerView(this, ADSize.BANNER, Constants.APPID, Constants.BannerPosID);
        bannerView.setRefresh(30);
        bannerView.setADListener(new AbstractBannerADListener() {
            @Override
            public void onNoAD(int i) {
                Log.i("AD_DEMO", "BannerNoAD，eCode=" + i);
            }

            @Override
            public void onADReceiv() {
                Log.i("AD_DEMO", "ONBannerReceive");
            }
        });


        mainContainer = new RelativeLayout(this);
        RelativeLayout.LayoutParams mp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
        mp.addRule(RelativeLayout.CENTER_IN_PARENT);
        addContentView(mainContainer, mp);

        RelativeLayout.LayoutParams bp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
        bp.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);

        mainContainer.addView(bannerView, bp);
        bannerView.loadAD();
        bannerView.setVisibility(View.INVISIBLE);


        //InterstitialAD
        isInterstitialReady = false;
        iad = new InterstitialAD(this, Constants.APPID, Constants.InterteristalPosID);
        iad.setADListener(new AbstractInterstitialADListener() {

            @Override
            public void onNoAD(int arg0) {
                Log.i("AD_DEMO", "LoadInterstitialAd Fail:" + arg0);
                isInterstitialReady = false;
            }

            @Override
            public void onADReceive() {
                isInterstitialReady = true;
            }

            @Override
            public void onADOpened() {

            }

            @Override
            public void onADExposure() {

            }

            @Override
            public void onADClicked() {

            }

            @Override
            public void onADLeftApplication() {

            }

            @Override
            public void onADClosed() {
                isInterstitialReady = false;
                iad.loadAD();
                //close event
            }
        });

        iad.loadAD();
    }

    public void showBanner()
    {
        bannerView.setVisibility(View.VISIBLE);
    }

    public void showInterstitial()
    {
        if (isInterstitialReady)
        {
            iad.show();
        }
        else
        {
            iad.loadAD();
            //close event
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
