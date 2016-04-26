//
//  moneyView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "moneyView.h"
#import "testmapAppDelegate.h"
#import "inmate.h"
#import "ExistInmate.h"
#import "photoView.h"

static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;

testmapAppDelegate *letterDelegate;


@implementation moneyView
@synthesize doneButton,numberKeyPad;

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
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    if(appdel.bolChoose){
   self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Submit" message:@"Would you like to send the inmate  money" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        
   self.title=@"Money Order";
    
    txtamount.text=@"";
	[alert show];
	[alert release];
    }
    
   

    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton1)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
    [buttonItem release];
    amount=0;
//    if(appdel.bolFinish){
//     txtamount.text=@"";
//    }
    dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];
    
	NSLog(@"no of pages %d and no of photos %d",appdel.noOfPages,appdel.noOfPhotos);
    if(appdel.noOfPages<=6 && appdel.bolLetter){
        
        
        amount=amount+99;
    }
    else{
        if(appdel.noOfPages % 6==0){
            
            int a=appdel.noOfPages%6;
            amount=a*99;
            
        }
        else{
        int a=appdel.noOfPages/6;
        amount=99+a*99;
        }
    }
    if(appdel.noOfPhotos<=4){
        
        amount=amount+(appdel.noOfPhotos*49);
    }
    else{
        
        amount=amount+(appdel.noOfPhotos*25);
        
    }
    NSLog(@"amount is %d",amount);
    appdel.finalAmt=(float)amount/100;
    
      
    //lblAmt.text=[NSString stringWithFormat:@"%.2f$",appdel.finalAmt]; 
	strdone=@"add";
	//self.navigationController.navigationBarHidden=TRUE;	
      [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
}
-(void)backButton1{
    appdel.tabController.selectedIndex=2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex==1) 
	{
		
	}
	else
	{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [self btnSubmit:nil];

//		self.tabBarController.selectedIndex=-1;
//		SelectionoptViewController = [[SelectionoptView alloc] initWithNibName:@"SelectionoptView" bundle:nil];
//		SelectionoptViewController.title = @"Selected Item";
//		[self.navigationController pushViewController:SelectionoptViewController animated:YES];
	}
}

-(IBAction) btnSubmit :(id)sender
{   [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
    appdel.bolChoose=FALSE;
    NSLog(@"%@",txtamount.text);
    float myFloat=[[txtamount text] floatValue];
    if(myFloat!=0){
    
   // arr=[str componentsSeparatedByString:@"$"];
    //NSLog(@"arr is %@",[arr objectAtIndex:1]);
   // float myFloat = [[arr objectAtIndex:1] floatValue];
    //NSLog(@"%f",myFloat);
   
  appdel.moneyorderAmt=myFloat;
   appdel.finalAmt=appdel.finalAmt+myFloat+0.99;
    NSLog(@"here it is %.2f",appdel.finalAmt);
        appdel.count=3;
        appdel.bolMoney=TRUE;
    }
    else{
        
        appdel.bolMoney=FALSE;
    }
    [txtamount resignFirstResponder];
	doneButton.hidden=TRUE;
	strdone=@"remove";
    NSLog(@"%d sdhfjkf",appdel.bolLetter);
    NSMutableArray *arrtemp=[[NSMutableArray alloc]init ];
	arrtemp=[[dal SelectWithStar:@"tblInmate"] retain];
    if([arrtemp count ]==0){
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil	otherButtonTitles:@"Create Inmate",nil];
        [action showInView:self.tabBarController.view];
    }
    else{
	UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil	otherButtonTitles:@"Create Inmate",@"Choose Inmate",nil];
	[action showInView:self.tabBarController.view];
	}
	//letterDelegate = (testmapAppDelegate*)[[UIApplication sharedApplication]delegate];
//	letterDelegate.count=3;
//	self.tabBarController.selectedIndex=-1;
//	SelectionoptViewController = [[SelectionoptView alloc] initWithNibName:@"SelectionoptView" bundle:nil];
//	[self.navigationController pushViewController:SelectionoptViewController animated:YES];
	
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==1)
	{
        appdel.isLetter=FALSE;
		ExistInmate *objExistInmate = [[ExistInmate alloc] initWithNibName:@"ExistInmate" bundle:nil];
		[self.navigationController pushViewController:objExistInmate animated:YES];
	}
	else if (buttonIndex==0)
	{
        appdel.isLetter=TRUE;
		inmate *objInmate = [[inmate alloc] initWithNibName:@"inmate" bundle:nil];
		[self.navigationController pushViewController:objInmate animated:YES];
	}

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	[textField resignFirstResponder];
	return YES;
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//	if(textField == txtamount) 
//	{
//		textField.text=[textField.text stringByReplacingOccurrencesOfString:@"$" withString:@""];
//		
//		//txtamount.textAlignment=UITextAlignmentRight;
//		//txtamount.font = [UIFont systemFontOfSize:26.0];
//        double currentValue = [textField.text doubleValue];
//        //Replace line above with this
//        //double currentValue = [[textField text] substringFromIndex:1] doubleValue];
//        double cents = round(currentValue * 100.0f);
//        
//        if ([string length]) {
//            for (size_t i = 0; i < [string length]; i++) {
//                unichar c = [string characterAtIndex:i];
//                if (isnumber(c)) {
//                    cents *= 10;
//                    cents += c - '0'; 
//                }            
//            }
//        } else {
//            // back Space
//            cents = floor(cents / 10);
//        }
//		//NSString *str=;
//		
//		textField.text = [NSString stringWithFormat:@"$%.2f", cents / 100.0f];
//		
//        //Add this line
//		//[textField setText:[NSString stringWithFormat:@"$%@",[textField text]]];
//        
//        return NO;
//	}
//	else {
//		return YES;
//	}
//    
//}
//


- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
	if (numberKeyPad) {
		numberKeyPad.currentTextField = textField;
	}
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {	
	if (![textField isEqual:normal]) {
		/*
		 Show the numberKeyPad 
		 */
		if (!self.numberKeyPad) {
			self.numberKeyPad = [NumberKeypadDecimalPoint keypadForTextField:textField];
		}else {
			//if we go from one field to another - just change the textfield, don't reanimate the decimal point button
			self.numberKeyPad.currentTextField = textField;
		}
	}	
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	//if (![textField isEqual:normal]) {
	if (textField == numberKeyPad.currentTextField) {
		/*
		 Hide the number keypad
         */
		[self.numberKeyPad removeButtonFromKeyboard];
		self.numberKeyPad = nil;
	}
	
	if (numberKeyPad.currentTextField == normal) {
		/*
		 Hide the number keypad
		 */
		[self.numberKeyPad removeButtonFromKeyboard];
		self.numberKeyPad = nil;
	}
    float a=[[txtamount text] floatValue];
    NSLog(@"%.2f",a);
    txtamount.text=[NSString stringWithFormat:@"%.2f",a];
}	

- (IBAction) backgroundTap {
  
    float a=[[txtamount text] floatValue];
    NSLog(@"%.2f",a);
    txtamount.text=[NSString stringWithFormat:@"%.2f",a];
	[txtamount resignFirstResponder];
	
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
    [lblAmt release];
    [btnSubmit release];
}


@end
