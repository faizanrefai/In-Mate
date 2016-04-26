//
//  AboutUsView.m
//  testmap
//
//  Created by apple  on 10/17/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "AboutUsView.h"

static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
@implementation AboutUsView

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
	
	self.navigationController.navigationBarHidden=FALSE;
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Information" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    self.title=@"About Us";
	UIBarButtonItem *btnBenefits=[[UIBarButtonItem alloc]initWithTitle:@"Benefits" style:UIBarButtonItemStylePlain target:self action:@selector(btnbenefits)
								];
	self.navigationItem.rightBarButtonItem=btnBenefits;
	[btnBenefits release];
	[buttonItem release];
	NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"about us" ofType:@"pdf"];
	
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	[webView loadRequest:requestObj];
	webView.scalesPageToFit = YES;
	
}
-(IBAction)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) btnbenefits
{
	benefitsViewController = [[benefitsView alloc] initWithNibName:@"benefitsView" bundle:nil];
	benefitsViewController.title = @"Benefits";
	[self.navigationController pushViewController:benefitsViewController animated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark textFieldRect
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
	if([txtView.text isEqualToString:@"Write Here......"]){
		txtView.text=@"";
	}
	
	// Any new character added is passed in as the "text" parameter
	if ([text isEqualToString:@"\n"]) {
		// Be sure to test for equality using the "isEqualToString" message
		[txtView resignFirstResponder];
		
		// Return FALSE so that the final '\n' character doesn't get added
		return FALSE;
	}
	// For any other character return TRUE so that the text gets added to the view
	return TRUE;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
	
	CGRect textFieldRect =[self.view.window convertRect:textView.bounds fromView:textView];
	CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
	
	CGFloat midline = textFieldRect.origin.y + 1.0 * textFieldRect.size.height;
	CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	animatedDistance = floor(162.0 * heightFraction);
	
	CGRect viewFrame = self.view.frame;
	
	viewFrame.origin.y -= animatedDistance;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[self.view setFrame:viewFrame];
    [UIView commitAnimations];   
}
-(void) textViewDidEndEditing:(UITextView *)textView{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	
	self.view.frame = CGRectMake(0,0, 320, 460);
	
	
	[txtView resignFirstResponder];
	
	[UIView commitAnimations];   
	
	
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
