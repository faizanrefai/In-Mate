//
//  inmate.m
//  testmap
//
//  Created by Hirak on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "inmate.h"
#import "SelectionoptView.h"
#import "ExistInmate.h"
#import "DAL.h"
#import "PdfController.h"
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
@implementation inmate

@synthesize scrollView;;

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
	appDel = (testmapAppDelegate *)[[UIApplication sharedApplication] delegate];
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardDidShow:) 
													 name:UIKeyboardDidShowNotification 
												   object:nil];		
	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
	}
	
	dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];

	doneButton.hidden=TRUE;
	
}
- (void)viewWillAppear:(BOOL)animate
{
    if(appDel.tabController.selectedIndex==3)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    toolbar = [[[UIToolbar alloc] init] autorelease];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    prevBtn =[[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(prev)];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    nextBtn =[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(next)];
    UIBarButtonItem *flexButton1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton1 =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:prevBtn,flexButton,nextBtn,flexButton1, doneButton1, nil];
    
    [flexButton release];
    [doneButton1 release];
    [toolbar setItems:itemsArray];
    
    [fldUAdd setInputAccessoryView:toolbar];
    [fldIName setInputAccessoryView:toolbar];
    [fldBed setInputAccessoryView:toolbar];
    [fldEmail setInputAccessoryView:toolbar];
    [fldIAdd setInputAccessoryView:toolbar];
    [fldICity setInputAccessoryView:toolbar];
    [fldID setInputAccessoryView:toolbar];
    [fldIState setInputAccessoryView:toolbar];
    [fldIZip setInputAccessoryView:toolbar];
    [fldUAdd setInputAccessoryView:toolbar];
    [fldUCity setInputAccessoryView:toolbar];
    [fldUName setInputAccessoryView:toolbar];
    [fldUState setInputAccessoryView:toolbar];
    [fldUZip setInputAccessoryView:toolbar];
    [fldULastName setInputAccessoryView:toolbar];
    [fldILastName setInputAccessoryView:toolbar];
    [fldIInstituteName setInputAccessoryView:toolbar];
    
    
    
    [btnSave setImage:[UIImage imageNamed:@"newSaveBlue.png"] forState:UIControlStateNormal];
      [btnNext setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	self.navigationController.navigationBarHidden=FALSE;
    self.view.frame=CGRectMake(0, 0, 320, 460);
    mainView.frame=CGRectMake(0, 0, 320, 830);
    scrollView.frame = CGRectMake(0, 100, 320, 460);
    arrState=[[NSArray alloc] initWithObjects:@"Alabama",@"Alaska",@"Arizona",@"Arkansas",@"California",@"Colorado",@"Connecticut",@"Delaware",@"Florida",@"Georgia",@"Hawaii",@"Idaho",@"Illinois",@"Indiana",@"Iowa",@"Kansas",@"Kentucky",@"Louisiana",@"Maine",@"Maryland",@"Massachusetts",@"Michigan",@"Minnesota",@"Mississippi",@"Missouri",@"Montana",@"Nebraska",@"Nevada",@"New Hampshire",@"New Jersey",@"New Mexico",@"New York",@"North Carolina",@"North Dakota",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Vermont",@"Virginia",@"Washington",@"West Virginia",@"Wisconsin",@"Wyoming", nil];
    [scrollView setContentSize:CGSizeMake(320, 1000)];
    if(appDel.isLetter){
    
	mainView.hidden=FALSE;
	self.title=@"Create Inmate";
        btnNext.hidden=TRUE;
        btnSave.hidden=FALSE; 
        [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    }
    else{
        self.title=@"Inmate Info";
        btnNext.hidden=FALSE;
        btnSave.hidden=TRUE;
        [btnNext setTitle:@"Next" forState:UIControlStateNormal];
        UIBarButtonItem *delButton=[[UIBarButtonItem alloc]initWithTitle:@"Update" 
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self action:@selector(updateData)];
        [self.navigationItem setRightBarButtonItem:delButton];
        [delButton release];
        
        UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithTitle:@"Back" 
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self action:@selector(back)];
        [self.navigationItem setLeftBarButtonItem:backBtn];
        [backBtn release];
        array=[[NSMutableArray alloc]init];
        
		array=[dal SelectWithStar:@"tblInmate" withCondition:@"ID" withColumnValue:[NSString stringWithFormat:@"%@",appDel.creditNO]];
	        
              
       
        
		fldUName.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"UserName"]objectAtIndex:0]];
        fldUAdd.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"UserAdd"]objectAtIndex:0]];
        fldUCity.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"UserCity"]objectAtIndex:0]];
        fldUState.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"UserState"]objectAtIndex:0]];
        fldUZip.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"UserZip"]objectAtIndex:0]];
        fldID.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"iid"]objectAtIndex:0]];
        fldIName.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"InName"]objectAtIndex:0]];
        fldIAdd.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"InAdd"]objectAtIndex:0]];
        fldICity.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"InCity"]objectAtIndex:0]];
        fldIState.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"InState"]objectAtIndex:0]];
        fldIZip.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"InZip"]objectAtIndex:0]];
        fldEmail.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"Email"]objectAtIndex:0]];
        fldBed.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"bed"]objectAtIndex:0]];
        fldILastName.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"ILastName"] objectAtIndex:0]];
        fldULastName.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"ULastName"] objectAtIndex:0]];
        fldIInstituteName.text=[NSString stringWithFormat:@"%@",[[array valueForKey:@"IInstName"] objectAtIndex:0]];
        
        
		

    }
	
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
   
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void)next {
   
    if(activeField==fldIName){
        [fldILastName becomeFirstResponder];
        
    }
    else if(activeField==fldILastName){
        [fldID becomeFirstResponder];
    }
    else if(activeField==fldID){
        [fldBed becomeFirstResponder];
        
    }
    else if(activeField==fldBed){
        [fldIInstituteName becomeFirstResponder];
    }
    else if(activeField==fldIInstituteName){
        [fldIAdd becomeFirstResponder];
    }
    else if(activeField==fldIAdd){
        [fldICity becomeFirstResponder];
    }
    else if(activeField==fldICity){
        [fldIState becomeFirstResponder];
    }
    else if(activeField==fldIState){
        [fldIZip becomeFirstResponder];
    }
    else if(activeField==fldIZip){
        [fldUName becomeFirstResponder];
    }
   
    else if(activeField==fldUName){
        [fldULastName becomeFirstResponder];
    }
    else if(activeField==fldULastName){
        [fldUAdd becomeFirstResponder];
    }
    else if(activeField==fldUAdd){
        [fldUCity becomeFirstResponder];
    }
    else if(activeField==fldUCity){
        [fldUState becomeFirstResponder];
    }
    else if(activeField==fldUState){
        [fldUZip becomeFirstResponder];
    }
    else if(activeField==fldUZip){
       
        [fldEmail becomeFirstResponder];
       
    }
    else if(activeField==fldEmail){
       
    }
   

}
-(void)prev {
    
    if(activeField==fldIName){
        
        
    }
    else if(activeField==fldILastName){
        [fldIName becomeFirstResponder];
    }
    else if(activeField==fldID){
        [fldILastName becomeFirstResponder];
        
    }
    else if(activeField==fldBed){
        [fldID becomeFirstResponder];
    }
    else if(activeField==fldIInstituteName){
        [fldBed becomeFirstResponder];
    }
    else if(activeField==fldIAdd){
        [fldIInstituteName becomeFirstResponder];
    }
    else if(activeField==fldICity){
        [fldIAdd becomeFirstResponder];
    }
    else if(activeField==fldIState){
        [fldICity becomeFirstResponder];
    }
    else if(activeField==fldIZip){
        [fldIState becomeFirstResponder];
    }
   
    else if(activeField==fldUName){
        [fldIZip becomeFirstResponder];
    }
    else if(activeField==fldULastName){
        [fldUName becomeFirstResponder];
    }
    else if(activeField==fldUAdd){
        [fldULastName becomeFirstResponder];
    }
    else if(activeField==fldUCity){
        [fldUAdd becomeFirstResponder];
    }
    else if(activeField==fldUState){
        [fldUCity becomeFirstResponder];
    }
    else if(activeField==fldUZip){
        [fldUState becomeFirstResponder];
    }
    else if(activeField==fldEmail){
        [fldUZip becomeFirstResponder];
    }

}

-(void)resignKeyboard {
    [activeField resignFirstResponder];
}

-(IBAction)updateData{
    [appDel.dataInmate setValue:fldUName.text forKey:@"UserName"];
	[appDel.dataInmate setValue:fldUAdd.text forKey:@"UserAdd"];
	[appDel.dataInmate setValue:fldUCity.text forKey:@"UserCity"];
	[appDel.dataInmate setValue:fldUState.text forKey:@"UserState"];
	[appDel.dataInmate setValue:fldUZip.text forKey:@"UserZip"];
	[appDel.dataInmate setValue:fldID.text forKey:@"iid"];
	[appDel.dataInmate setValue:fldIName.text forKey:@"InName"];
	[appDel.dataInmate setValue:fldIAdd.text forKey:@"InAdd"];
	[appDel.dataInmate setValue:fldICity.text forKey:@"InCity"];
	[appDel.dataInmate setValue:fldIState.text forKey:@"InState"];
	[appDel.dataInmate setValue:fldIZip.text forKey:@"InZip"];
    [appDel.dataInmate setValue:fldEmail.text forKey:@"Email"];
	[appDel.dataInmate setValue:fldBed.text forKey:@"bed"];
    [appDel.dataInmate setValue:fldIInstituteName.text forKey:@"IInstName"];
    [appDel.dataInmate setValue:fldILastName.text forKey:@"ILastName"];
    [appDel.dataInmate setValue:fldULastName.text forKey:@"ULastName"];
    
	[dal updateRecord:appDel.dataInmate forID:@"ID=" inTable:@"tblInmate" 
            withValue:[NSString stringWithFormat:@"%@", appDel.creditNO]];
	
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Updated"
												  message:@"Inmate Information Updated" 
												 delegate:self 
										cancelButtonTitle:@"OK" 
										otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)keyboardWillShow:(NSNotification *)note {
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
		doneButton.hidden=TRUE;
		[self addButtonToKeyboard];
	}
}

- (void)keyboardDidShow:(NSNotification *)note {
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		doneButton.hidden=TRUE;
		[self addButtonToKeyboard];
    }
}
- (void)addButtonToKeyboard {
	// create custom button
	
	doneButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.hidden=TRUE;
	doneButton.adjustsImageWhenHighlighted = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} else {        
		[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found, add the button
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}
}
- (void)doneButton:(id)sender
{
	[fldUName resignFirstResponder];
}

-(IBAction) submitClicked:(id)sender
{
    [btnNext setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
    
	SelectionoptView *SelectionoptViewController = [[SelectionoptView alloc] initWithNibName:@"SelectionoptView" bundle:nil];
	[self.navigationController pushViewController:SelectionoptViewController animated:YES];
}
-(IBAction) saveClicked:(id)sender
{   
      //[btnSave setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
        appDel.inMateName=fldIName.text;
    if([fldID.text isEqualToString:@""] || [fldIAdd.text isEqualToString:@""] || [fldICity.text isEqualToString:@""] || [fldIName.text isEqualToString:@""] || [fldIState.text isEqualToString:@""] || [fldIZip.text isEqualToString:@""] || [fldUAdd.text isEqualToString:@""] || [fldUCity.text isEqualToString:@""] || [fldUName.text isEqualToString:@""] || [fldUState.text isEqualToString:@""] || [fldUZip.text isEqualToString:@""] || [fldEmail.text isEqualToString:@""] || [fldILastName.text isEqualToString:@""] || [fldULastName.text isEqualToString:@""] ){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Inamte Not Saved" message:@"Please Enter All The Values"
                              
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        
        
    }
    else if(!appDel.isLetter){
        if(appDel.bolLetter){
            [appDel.dataInmate setValue:fldUName.text forKey:@"UserName"];
            [appDel.dataInmate setValue:fldUAdd.text forKey:@"UserAdd"];
            [appDel.dataInmate setValue:fldUCity.text forKey:@"UserCity"];
            [appDel.dataInmate setValue:fldUState.text forKey:@"UserState"];
            [appDel.dataInmate setValue:fldUZip.text forKey:@"UserZip"];
            [appDel.dataInmate setValue:fldID.text forKey:@"iid"];
            [appDel.dataInmate setValue:fldIName.text forKey:@"InName"];
            [appDel.dataInmate setValue:fldIAdd.text forKey:@"InAdd"];
            [appDel.dataInmate setValue:fldICity.text forKey:@"InCity"];
            [appDel.dataInmate setValue:fldIState.text forKey:@"InState"];
            [appDel.dataInmate setValue:fldIZip.text forKey:@"InZip"];
            [appDel.dataInmate setValue:fldEmail.text forKey:@"Email"];
            [appDel.dataInmate setValue:fldBed.text forKey:@"bed"];
            [appDel.dataInmate setValue:fldIInstituteName.text forKey:@"IInstName"];
            [appDel.dataInmate setValue:fldILastName.text forKey:@"ILastName"];
            [appDel.dataInmate setValue:fldULastName.text forKey:@"ULastName"];
                     [btnSave setImage:[UIImage imageNamed:@"newSaveBlack.png"] forState:UIControlStateNormal];
                     [btnNext setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
                   PdfController *pdfController = [[PdfController alloc] initWithNibName:@"PdfController" bundle:nil];
                   [self.navigationController pushViewController:pdfController animated:YES];
        }
        else{
                    [appDel.dataInmate setValue:fldUName.text forKey:@"UserName"];
                   [appDel.dataInmate setValue:fldUAdd.text forKey:@"UserAdd"];
                   [appDel.dataInmate setValue:fldUCity.text forKey:@"UserCity"];
                   [appDel.dataInmate setValue:fldUState.text forKey:@"UserState"];
                   [appDel.dataInmate setValue:fldUZip.text forKey:@"UserZip"];
                   [appDel.dataInmate setValue:fldID.text forKey:@"iid"];
                   [appDel.dataInmate setValue:fldIName.text forKey:@"InName"];
                   [appDel.dataInmate setValue:fldIAdd.text forKey:@"InAdd"];
                   [appDel.dataInmate setValue:fldICity.text forKey:@"InCity"];
                   [appDel.dataInmate setValue:fldIState.text forKey:@"InState"];
                   [appDel.dataInmate setValue:fldIZip.text forKey:@"InZip"];
                   [appDel.dataInmate setValue:fldEmail.text forKey:@"Email"];
                   [appDel.dataInmate setValue:fldBed.text forKey:@"bed"];
                   [appDel.dataInmate setValue:fldIInstituteName.text forKey:@"IInstName"];
                   [appDel.dataInmate setValue:fldILastName.text forKey:@"ILastName"];
                   [appDel.dataInmate setValue:fldULastName.text forKey:@"ULastName"];
                   [btnSave setImage:[UIImage imageNamed:@"newSaveBlack.png"] forState:UIControlStateNormal];
                   [btnNext setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
                    SelectionoptView *objSel=[[SelectionoptView alloc]initWithNibName:@"SelectionoptView" bundle:nil];
                    [self.navigationController pushViewController:objSel animated:YES];
                    [objSel release];
        }
    }
    else{
	
	[appDel.dataInmate setValue:fldUName.text forKey:@"UserName"];
	[appDel.dataInmate setValue:fldUAdd.text forKey:@"UserAdd"];
	[appDel.dataInmate setValue:fldUCity.text forKey:@"UserCity"];
	[appDel.dataInmate setValue:fldUState.text forKey:@"UserState"];
	[appDel.dataInmate setValue:fldUZip.text forKey:@"UserZip"];
	[appDel.dataInmate setValue:fldID.text forKey:@"iid"];
	[appDel.dataInmate setValue:fldIName.text forKey:@"InName"];
	[appDel.dataInmate setValue:fldIAdd.text forKey:@"InAdd"];
	[appDel.dataInmate setValue:fldICity.text forKey:@"InCity"];
	[appDel.dataInmate setValue:fldIState.text forKey:@"InState"];
	[appDel.dataInmate setValue:fldIZip.text forKey:@"InZip"];
    [appDel.dataInmate setValue:fldEmail.text forKey:@"Email"];
    [appDel.dataInmate setValue:fldBed.text forKey:@"bed"];
    [appDel.dataInmate setValue:fldIInstituteName.text forKey:@"IInstName"];
    [appDel.dataInmate setValue:fldILastName.text forKey:@"ILastName"];
    [appDel.dataInmate setValue:fldULastName.text forKey:@"ULastName"];
        
	NSLog(@"here %@",appDel.dataInmate);
	[dal insertRecord:appDel.dataInmate inTable:@"tblInmate"];
	//ExistInmate *SelectionoptViewController = [[ExistInmate alloc] initWithNibName:@"ExistInmate" bundle:nil];
	//[self.navigationController pushViewController:SelectionoptViewController animated:YES];
	if(appDel.bolLetter){
        [btnSave setImage:[UIImage imageNamed:@"newSaveBlack.png"] forState:UIControlStateNormal];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
    PdfController *pdfController = [[PdfController alloc] initWithNibName:@"PdfController" bundle:nil];
   
	[self.navigationController pushViewController:pdfController animated:YES];
    }
    else{
        
        [btnSave setImage:[UIImage imageNamed:@"newSaveBlack.png"] forState:UIControlStateNormal];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
        SelectionoptView *objSel=[[SelectionoptView alloc]initWithNibName:@"SelectionoptView" bundle:nil];
        
        [self.navigationController pushViewController:objSel animated:YES];
        [objSel release];
    }
        
	//infoView.hidden=FALSE;
	mainView.hidden=TRUE;
    }
    appDel.emailID=fldEmail.text;
}
#pragma mark textField
//- (void)textFieldDidBeginEditing:(UITextField*)textField
//{
//    CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
//    CGRect viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
//    CGFloat midline = textFieldRect.origin.y + 1.0 * textFieldRect.size.height;
//    CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
//    CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
//    CGFloat heightFraction = numerator / denominator;
//    animatedDistance = floor(162.0 * heightFraction);
//    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y -= animatedDistance;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
//    [self.view setFrame:viewFrame];
//    [UIView commitAnimations];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    CGRect viewFrame = self.view.frame;
//    viewFrame.origin.y += animatedDistance;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
//    [self.view setFrame:viewFrame];
//    [UIView commitAnimations];
//   }
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField ==fldUName) {
//        [fldUAdd becomeFirstResponder];
//    }
//    
//    else if (textField == fldUAdd) {
//        [fldUCity becomeFirstResponder];
//    }
//    
//    else if (textField == fldUCity) {
//        [fldUState becomeFirstResponder];
//    }
//    
//    else if (textField == fldUState) {
//        [fldUZip becomeFirstResponder];
//    }
//    else if (textField == fldUZip) {
//        [fldEmail becomeFirstResponder];
//    }
//    
//    else if (textField == fldEmail) {
//        [fldID becomeFirstResponder];
//    }
//    else if (textField == fldID) {
//        [fldIName becomeFirstResponder];
//    }
//    else if (textField == fldIName) {
//        [fldIAdd becomeFirstResponder];
//    }
//    
//    else if (textField == fldIAdd) {
//        [fldICity becomeFirstResponder];
//    }
//    else if (textField == fldICity) {
//        [fldIState becomeFirstResponder];
//    }
//    
//    else if (textField == fldIState) {
//        [fldIZip becomeFirstResponder];
//    }
//    else{
//        [textField resignFirstResponder];
//    }
//
//    
//    
//    
//    return YES;
//}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    if(activeField==fldIName){
        prevBtn.enabled=NO;
    }
    else{
        prevBtn.enabled=YES;
    }
    if(activeField==fldEmail){
        nextBtn.enabled=NO;
    }
    else{
        nextBtn.enabled=YES;
    }
    if([textField isEqual:fldIState]){
        isState=FALSE;
        
    }
    else{
        isState=TRUE;
    }
    if ([textField isEqual:fldUState] || [textField isEqual:fldIState])
    {
        
        if (!actionSheetState)
        {
            [fldUState resignFirstResponder];
            [fldIZip resignFirstResponder];
            [fldUAdd resignFirstResponder];
            [fldUCity resignFirstResponder];
            [fldUName resignFirstResponder];
            
            [fldUState resignFirstResponder];
            [fldID resignFirstResponder];
            [fldEmail resignFirstResponder];
            [fldIAdd resignFirstResponder];
            [fldICity resignFirstResponder];
            [fldIName resignFirstResponder];
            [fldUZip resignFirstResponder];
            [fldBed resignFirstResponder];
            [fldILastName resignFirstResponder];
            [fldULastName resignFirstResponder];
            [fldIInstituteName resignFirstResponder];
            actionSheetState = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionSheetState setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
            
            CGRect pickerFrame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
            
            pickerState = [[UIPickerView alloc] initWithFrame:pickerFrame];
            pickerState.showsSelectionIndicator = YES;
            pickerState.userInteractionEnabled = TRUE;
            pickerState.dataSource = self;
            pickerState.delegate = self;
            [actionSheetState addSubview:pickerState];
            
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
            closeButton.momentary = YES;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
            
            
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
            [actionSheetState addSubview:closeButton];
            [closeButton release];
            
            
            CGRect frame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
            
            [actionSheetState setFrame:frame];
            [self.view addSubview:actionSheetState];
            
            return NO;           
        }
    }
    else {
        return YES;
    }
    return 0;
}
-(void)dismissActionSheet
{
    if (actionSheetState)
    {
        if ([fldUState.text isEqualToString:@""] && isState)
        {
            fldUState.text=[NSString stringWithFormat:@"%@",[arrState objectAtIndex:0]];
            //activeField=fldUZip ;
            
        } 
        else if([fldIState.text isEqualToString:@""] && !isState){
             fldIState.text=[NSString stringWithFormat:@"%@",[arrState objectAtIndex:0]];
            //activeField=fldIZip;
        }
    }
    
    actionSheetState.hidden = TRUE;
    
    [actionSheetState release];
    actionSheetState=nil;
    [self next];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == pickerState) {
        return 1;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView == pickerState)
    {
        NSString *a =  [arrState objectAtIndex:row];
        if(isState)
        fldUState.text= [NSString stringWithFormat:@"%@",a];
        else
            fldIState.text= [NSString stringWithFormat:@"%@",a];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if(pickerView == pickerState)
    {
        if (component==0)
        {
            return [arrState count];
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

{
    if(pickerView == pickerState)
    {
        if (component==0)
        {
            return [arrState objectAtIndex:row];
        }
    }
    return 0;
}


//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//	[textField resignFirstResponder];
//  
//	return YES;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
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
