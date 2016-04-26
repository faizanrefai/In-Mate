//
//  termView.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistCreditCard.h"
#import "testmapAppDelegate.h"
#import "DAL.h"
@class testmapAppDelegate;
@interface termView : UIViewController <UIActionSheetDelegate>
{
	testmapAppDelegate *appDel;
	IBOutlet UIWebView *webView;
	IBOutlet UIButton *btnDone;
    DAL *dal;
}
-(IBAction) doneClicked:(id)sender;
-(IBAction)backButton;
@end
