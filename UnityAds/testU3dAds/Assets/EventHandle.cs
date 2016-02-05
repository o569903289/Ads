using UnityEngine;
using System.Collections;
using UnityEngine.Advertisements;

public class EventHandle : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void ShowAd()
	{
		Debug.Log ("onShowAd");
		if (Advertisement.IsReady())
		{
			Debug.Log ("ShowAd");
			Advertisement.Show();
		}
	}

	public void ShowRewardedAd()
	{
		Debug.Log ("onShowRewardedAd");
		if (Advertisement.IsReady("rewardedVideo"))
		{
			Debug.Log ("ShowRewardedAd");
			var options = new ShowOptions { resultCallback = HandleShowResult };
			Advertisement.Show("rewardedVideo", options);
		}
	}

	private void HandleShowResult(ShowResult result)
	{
		switch (result)
		{
		case ShowResult.Finished:
			Debug.Log("The ad was successfully shown.");
			//
			// YOUR CODE TO REWARD THE GAMER
			// Give coins etc.
			break;
		case ShowResult.Skipped:
			Debug.Log("The ad was skipped before reaching the end.");
			break;
		case ShowResult.Failed:
			Debug.LogError("The ad failed to be shown.");
			break;
		}
	}
}
