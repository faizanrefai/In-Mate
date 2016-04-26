//
//  CreateChooseLetter.h
//  Jail Mail
//
//  Created by girish on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"
#import "DAL.h"
@interface CreateChooseLetter : UIViewController {

	testmapAppDelegate *appdel;
    DAL *dal;
    IBOutlet UIButton *btnChoose;
    IBOutlet UIImageView *imgChoose;
    IBOutlet UIImageView *imgCreate;
}
-(IBAction)CreateLetter:(id)sender;
-(IBAction)ChooseLetter:(id)sender;
@end
