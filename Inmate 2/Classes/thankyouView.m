//
//  thankyouView.m
//  testmap
//
//  Created by apple  on 10/11/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "thankyouView.h"
#import "WebSite.h"
#import "RootViewController.h"
@implementation thankyouView
@synthesize message,timer;
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
    self.navigationItem.hidesBackButton=YES;
    objAppdel =(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    objAppdel =(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"index %d",objAppdel.tabController.selectedIndex);
    flag=0;
    if(objAppdel.tabController.selectedIndex==3)
    {
        objAppdel.bolFinish=YES;
        objAppdel.bolPhoto=FALSE;
        objAppdel.bolMoney=FALSE;
        objAppdel.bolLetter=FALSE;
        objAppdel.bolChoose=TRUE;
        objAppdel.noOfPhotos=0;
        objAppdel.noOfPages=0;
        objAppdel.moneyorderAmt=0;
        objAppdel.finalAmt=0;
        NSLog(@"%@",objAppdel.arrImageData);
        [objAppdel.arrImageData removeAllObjects];
         NSLog(@"%@",objAppdel.arrImageData);
        timer=[NSTimer scheduledTimerWithTimeInterval:25 target: self selector: @selector(CallMe) userInfo: nil repeats: NO];
        [btnWeb setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    }
    else{
        
    
        [self.navigationController popToRootViewControllerAnimated:YES];
       
        
    }
    
  
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)CallMe{
    flag=1;
    [timer invalidate];
        objAppdel.tabController.selectedIndex=0;
    
}
-(IBAction)closeBtn:(id)sender{
    flag=1;
    [timer invalidate];
    
    objAppdel.tabController.selectedIndex=0;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
-(IBAction)website:(id)sender{
    [timer invalidate];
    flag=1;
    [btnWeb setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
    WebSite *objWEb=[[WebSite alloc]initWithNibName:@"WebSite" bundle:nil];
    [self presentModalViewController:objWEb animated:YES];
    [objWEb release];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated{
    if(flag==0){
    [timer invalidate];
    
   
    }
}
- (void)dealloc {
    [super dealloc];
}


@end
