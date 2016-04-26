//
//  CreateChooseLetter.m
//  Jail Mail
//
//  Created by girish on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateChooseLetter.h"
#import "letterView.h"
#import "ChooseExistingLetter.h"

@implementation CreateChooseLetter

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
}
-(void)viewWillAppear:(BOOL)animated{
    dal=[[DAL alloc]init];
    self.navigationItem.hidesBackButton = YES;
    
	[dal initDatabase:@"DBInmate.sqlite"];
    appdel.bolChoose=TRUE;
    NSMutableArray *tempArr;
    self.title=@"Write a Letter";
	tempArr=[[dal SelectWithStar:@"tblFrdFormat"] retain];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    arr=[[dal SelectWithStar:@"tblBusiness"]retain];
    if([tempArr count]==0 && [arr count]==0){
        btnChoose.hidden=TRUE; 
        imgChoose.hidden=TRUE;
    }
    else{
        btnChoose.hidden=FALSE;
         imgChoose.hidden=FALSE;
    }
    
    imgChoose.image=[UIImage imageNamed:@"newBlueBg.png"];
    imgCreate.image=[UIImage imageNamed:@"newBlueBg.png"];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)CreateLetter:(id)sender{
	imgCreate.image=[UIImage imageNamed:@"newBlackBg.png"];
	appdel.isLetter=TRUE;
	letterView *letter=[[letterView alloc]initWithNibName:@"letterView" bundle:nil];
	[self.navigationController pushViewController:letter animated:YES];
	[letter release];
	
}
-(IBAction)ChooseLetter:(id)sender{
	imgChoose.image=[UIImage imageNamed:@"newBlackBg.png"];
	ChooseExistingLetter *choose=[[ChooseExistingLetter alloc]initWithNibName:@"ChooseExistingLetter" bundle:nil];
	[self.navigationController pushViewController:choose animated:YES];
	[choose release];
	
}
-(void)viewDidDisappear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
