//
//  DetailView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "DetailView.h"
#import "FacebookTweeter.h"
#import "WebSite.h"
@implementation DetailView

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
	
	
}
-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    appdel.bolChoose=TRUE;
    if(appdel.tabController.selectedIndex==0)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    [buttonItem release];
    imgWebsite.image=[UIImage imageNamed:@"newBlueBg.png"];
    imgFB.image=[UIImage imageNamed:@"newBlueBg.png"];
    imgTwitter.image=[UIImage imageNamed:@"newBlueBg.png"];
    imgPrice.image=[UIImage imageNamed:@"newBlueBg.png"];
    imgAboutus.image=[UIImage imageNamed:@"newBlueBg.png"];
    imgTerms.image=[UIImage imageNamed:@"newBlueBg.png"];
	
}
-(IBAction)website:(id)sender{
    
    imgWebsite.image=[UIImage imageNamed:@"newBlackBg.png"];
    WebSite *objWEb=[[WebSite alloc]initWithNibName:@"WebSite" bundle:nil];
    [self presentModalViewController:objWEb animated:YES];
    [objWEb release];
}

#pragma IBAction
-(IBAction)facebook:(id)sender{
    imgFB.image=[UIImage imageNamed:@"newBlackBg.png"];
    appdel.isFB=TRUE;
    faceObj=[[FacebookTweeter alloc]initWithNibName:@"FacebookTweeter" bundle:nil];
    [self.navigationController pushViewController:faceObj animated:YES];
}
-(IBAction)twitter:(id)sender{
    appdel.isFB=FALSE;
    imgTwitter.image=[UIImage imageNamed:@"newBlackBg.png"];
    faceObj=[[FacebookTweeter alloc]initWithNibName:@"FacebookTweeter" bundle:nil];
    [self.navigationController pushViewController:faceObj animated:YES];
}
-(IBAction)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) btnprice :(id)sender
{
    imgPrice.image=[UIImage imageNamed:@"newBlackBg.png"];
	priceViewController = [[priceView alloc] initWithNibName:@"priceView" bundle:nil];
	priceViewController.title = @"Price";
	[self.navigationController pushViewController:priceViewController animated:YES];
}

-(IBAction) btnAboutUs :(id)sender
{
    imgAboutus.image=[UIImage imageNamed:@"newBlackBg.png"];
	benefitsview = [[benefitsView alloc] initWithNibName:@"benefitsView" bundle:nil];
	benefitsview.title = @"Benefits";
	[self.navigationController pushViewController:benefitsview animated:YES];
}

-(IBAction) btnterms :(id)sender
{
	
    imgTerms.image=[UIImage imageNamed:@"newBlackBg.png"];
	appdel.isTerm=TRUE;
	termViewController = [[termView alloc] initWithNibName:@"termView" bundle:nil];
	termViewController.title = @"Terms And Conditions";
	[self.navigationController pushViewController:termViewController animated:YES];
}
	
	
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [faceObj release];
	[priceViewController release];
	[benefitsView release];
	[termViewController release];
}


@end
