//
//  DetailView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "priceView.h"
#import "AboutUsView.h"
#import "termView.h"
#import "testmapAppDelegate.h"
#import "FacebookTweeter.h"
@class priceView,termView,AboutUsView,testmapAppDelegate;

@interface DetailView : UIViewController 
{
	priceView *priceViewController;
	benefitsView *benefitsview;
	termView *termViewController;
	testmapAppDelegate *appdel;
    FacebookTweeter *faceObj;
    IBOutlet UIImageView *imgInfo;
    IBOutlet UIImageView *imgAboutus;
    IBOutlet UIImageView *imgTerms;
    IBOutlet UIImageView *imgPrice;
    IBOutlet UIImageView *imgFB;
    IBOutlet UIImageView *imgTwitter;
    IBOutlet UIImageView *imgWebsite;
    
}

-(IBAction) btnprice :(id)sender;
-(IBAction) btnAboutUs :(id)sender;
-(IBAction) btnterms :(id)sender;
-(IBAction)backButton;
-(IBAction)facebook:(id)sender;
-(IBAction)twitter:(id)sender;
-(IBAction)website:(id)sender;
@end
