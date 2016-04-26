//
//  FacebookTweeter.m
//  Jail Mail
//
//  Created by Openxcell on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookTweeter.h"
#import "testmapAppDelegate.h"
@implementation FacebookTweeter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    [buttonItem release];
    
    NSString *urlAddress;
     if(appdel.isFB){
         urlAddress= @"http://www.facebook.com/inmatechoice";
        self.title=@"Facebook";
    }
    else{
        urlAddress= @"http://twitter.com/notforgotten1";
        self.title=@"Twitter";
    }
   
    if(appdel.tabController.selectedIndex==0)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    
	
//	NSURL *url = [NSURL fileURLWithPath:@"http://in.yahoo.com/?p=us"];
//	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//	[webView loadRequest:requestObj];
	
}
-(IBAction)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
