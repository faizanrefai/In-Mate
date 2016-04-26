//
//  thankyouView.h
//  testmap
//
//  Created by apple  on 10/11/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"

@interface thankyouView : UIViewController {

    testmapAppDelegate *objAppdel;
    
    IBOutlet UILabel *message;
    IBOutlet UIButton *btnWeb;
    NSTimer *timer;
    int flag;
}
@property(nonatomic,retain)UILabel *message;
@property(nonatomic,retain) NSTimer *timer;
-(IBAction)website:(id)sender;
-(IBAction)closeBtn:(id)sender;
@end
