//
//  RootViewController.h
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
#import "testmapAppDelegate.h"
@class DetailView;
@interface RootViewController : UIViewController {
	DetailView *detailViewController;
    IBOutlet UIImageView *imgWebsite;
    testmapAppDelegate *appdel;
 }

-(IBAction) btninfo :(id)sender;
-(IBAction)website:(id)sender;
@end
