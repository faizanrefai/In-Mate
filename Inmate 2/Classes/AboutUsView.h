//
//  AboutUsView.h
//  testmap
//
//  Created by apple  on 10/17/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "benefitsView.h"
#import "DAL.h"
@class benefitsView;
@interface AboutUsView : UIViewController 
{
	benefitsView *benefitsViewController;
	IBOutlet UITextView *txtView;
	CGFloat animatedDistance;
	IBOutlet UIWebView *webView;
    DAL *dal;
}

-(IBAction) btnbenefits :(id)sender;
-(IBAction)backButton;
@end
