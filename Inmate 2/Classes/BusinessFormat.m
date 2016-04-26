//
//  BusinessFormat.m
//  Jail Mail
//
//  Created by Openxcell on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessFormat.h"
#import "photoView.h"
#import "ChooseExistingLetter.h"

@implementation BusinessFormat
@synthesize scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
	dict=[[NSMutableDictionary alloc]init];
    
	dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];
    arrSalutations=[[NSArray alloc] initWithObjects:@"Best regards/wishes"
                    @"Confidently Yours",
                    @"Kind Regards/Wishes",
                    @"Many Thanks",
                    @"Respectfully Yours",
                    @"Warm Regards",
                    @"With Anticipation",
                    @"Goodbye",
                    @"Sincerely" ,
                    @"Later",
                    @"God Bless",
                    @"Godspeed",
                    @"Take Care",
                    @"Love" ,
                    @"Talk to you later",
                    @"Best Wishes",
                    @"Kind Regards",
                    @"With Love",
                    @"Yours Sincerely",
                    @"Yours Faithfully",
                    @"Yours Truly",
                    @"Yours Ever",
                    @"Yours Respectfully",
                    @"Hope to hear from ya soon",
                    @"Onward and Upward",
                    @"Peace",
                    @"Smell ya later",
                    @"Later alligator",
                    @"Cheers",
                    @"salutations",
                    @"Shine on",
                    @"Be good/well",
                    @"Cheerio",
                    @"Cheers",
                    @"I’m out",
                    @"More to come",
                    @"Smiles",
                    @"Ta ta for now",
                    @"Take care",
                    @"Take it easy",
                    @"Until next time",nil];
    arrGreetings=[[NSArray alloc] initWithObjects:@"Dear",
                  @"Hi",
                  @"Hello",
                  @"How are you",
                  @"Greetings",
                  @"Hey",
                  @"What’s up",
                  @"Wassup,"
                  @"What’s going on",
                  @"How’s it going",
                  @"How You doing",
                  @"Sup",
                  @"What’s shakin",
                  @"Howdy",
                  @"Yo",
                  @"Hiya",
                  @"Hey baby",
                  @"Hey Love",
                  @"Happy Birthday",
                  @"What’s happening",
                  @"To:", nil];


    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //letterview=[[letterView alloc]init];
    appdel.bolLetterFormat=FALSE;
    
    saveUpdate=0;
    coming=0;
    if(appdel.tabController.selectedIndex==1)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	self.navigationController.navigationBarHidden=FALSE;
    scrollView.frame = CGRectMake(0, 0, 320, 460);
    [scrollView setContentSize:CGSizeMake(320, 550)];	
	pickerViewDOB.hidden=TRUE;
	self.title=@"Business Letter";
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Letter" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
    self.navigationItem.leftBarButtonItem = buttonItem;
	
    [buttonItem release];
	UIFont* boldFont;
	boldFont= [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	UIFont *style;
	if(appdel.isLetter){
		UIBarButtonItem *buttonSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveLetter)]; 
		self.navigationItem.rightBarButtonItem = buttonSave;
        [buttonSave release];
		style=[UIFont fontWithName:[NSString stringWithFormat:@"%@",appdel.appFontName] size:20];
	}else {
		UIBarButtonItem *buttonSave = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateLetter)]; 
		self.navigationItem.rightBarButtonItem = buttonSave;
		[buttonSave release];
		style=[UIFont fontWithName:[NSString stringWithFormat:@"%@",[appdel.arrLetterDet valueForKey:@"Font"]] size:20];
		txtDate.text=[appdel.arrLetterDet valueForKey:@"Date"];
		txtDear.text=[appdel.arrLetterDet valueForKey:@"Dear"];
		txtSignature.text=[appdel.arrLetterDet valueForKey:@"Sign"];
		txtView.text=[appdel.arrLetterDet valueForKey:@"Body"];
        appdel.appFontName=[appdel.arrLetterDet valueForKey:@"Font"];
        appdel.indexOfFont=[appdel.arrLetterDet valueForKey:@"IndexNO"];
        txtSub.text=[appdel.arrLetterDet valueForKey:@"Subject"];
        txtSalutation.text=[appdel.arrLetterDet valueForKey:@"salutation"];
        
        NSLog(@"font is %@",appdel.indexOfFont);
        
	}
    flag=0;
	[btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
	[txtDate setFont:style];
	[txtDear setFont:style];
	[txtView setFont:style];
	[txtSub setFont:style];
	[txtSignature setFont:style];
    [txtSalutation setFont:style];
    
	[scrollView setContentOffset:CGPointMake(0,0)];
	[scrollView setContentSize:CGSizeMake(320, 700)];
	
	
	
	[txtView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [txtView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtView.layer setBorderWidth: 1.0];
    [txtView.layer setCornerRadius:8.0f];
    [txtView.layer setMasksToBounds:YES];
    
    [txtCG.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [txtCG.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtCG.layer setBorderWidth: 1.0];
    [txtCG.layer setCornerRadius:8.0f];
    [txtCG.layer setMasksToBounds:YES];
    
    [txtCG1.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [txtCG1.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtCG1.layer setBorderWidth: 1.0];
    [txtCG1.layer setCornerRadius:8.0f];
    [txtCG1.layer setMasksToBounds:YES];
    
    [txtCG2.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [txtCG2.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtCG2.layer setBorderWidth: 1.0];
    [txtCG2.layer setCornerRadius:8.0f];
    [txtCG2.layer setMasksToBounds:YES];
	
	
	[txtSignature.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [txtSignature.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [txtSignature.layer setBorderWidth: 1.0];
    [txtSignature.layer setCornerRadius:8.0f];
    [txtSignature.layer setMasksToBounds:YES];
    
    if([txtView.text isEqualToString:@""]){
    placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, txtView.frame.size.width - 20.0, 34.0)];
    [placeholderLabel setText:@"Body of the Letter Here"];
    // placeholderLabel is instance variable retained by view controller
    [placeholderLabel setBackgroundColor:[UIColor clearColor]];
  
    [placeholderLabel setTextColor:[UIColor lightGrayColor]];
    
    // textView is UITextView object you want add placeholder text to
    [txtView addSubview:placeholderLabel];
    } 
    if([txtSignature.text isEqualToString:@""]){
    placeholderLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, txtSignature.frame.size.width - 20.0, 34.0)];
    [placeholderLabel1 setText:@"Your Name Here"];
    // placeholderLabel is instance variable retained by view controller
    [placeholderLabel1 setBackgroundColor:[UIColor clearColor]];
    
    [placeholderLabel1 setTextColor:[UIColor lightGrayColor]];
    
    // textView is UITextView object you want add placeholder text to
    [txtSignature addSubview:placeholderLabel1];
    }
    UIToolbar *toolbar = [[[UIToolbar alloc] init] autorelease];
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
    
    
    [txtView setInputAccessoryView:toolbar];
    [txtSub setInputAccessoryView:toolbar];
    [txtSignature setInputAccessoryView:toolbar];
    

    
	
   
}
-(void)next {
    nextBtn.enabled=YES;
    prevBtn.enabled=YES;
    if(activeField==txtSub && flag==0){
        [txtView becomeFirstResponder];
        
    }
    else if(activeView==txtView){
        [txtSignature becomeFirstResponder];
    }
   
    else {
        nextBtn.enabled=NO;
        prevBtn.enabled=YES;
    }
    
    
    
}
-(void)prev {
    prevBtn.enabled=YES;
    nextBtn.enabled=YES;
    if(activeField==txtSub && flag==0){
        prevBtn.enabled=NO;
        nextBtn.enabled=YES;
        
    }
    else if(activeView==txtView){
        [txtSub becomeFirstResponder];
    }
    else if(activeView==txtSignature){
        [txtView becomeFirstResponder];
        
    }
    
}

-(void)resignKeyboard {
    [txtView resignFirstResponder];
    [txtSignature resignFirstResponder];
    [txtSub resignFirstResponder];
    
}
- (void) textViewDidChange:(UITextView *)theTextView
{
    if(![txtView hasText]) {
        [txtView addSubview:placeholderLabel];
        [UIView animateWithDuration:0.15 animations:^{
            placeholderLabel.alpha = 1.0;
        }];

    } else if ([[txtView subviews] containsObject:placeholderLabel]) {
        [UIView animateWithDuration:0.15 animations:^{
            placeholderLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            [placeholderLabel removeFromSuperview];
        }];

    }
    if(![txtSignature hasText]) {
        [txtSignature addSubview:placeholderLabel1];
        [UIView animateWithDuration:0.15 animations:^{
            placeholderLabel1.alpha = 1.0;
        }];
        
    } else if ([[txtSignature subviews] containsObject:placeholderLabel1]) {
        [UIView animateWithDuration:0.15 animations:^{
            placeholderLabel1.alpha = 0.0;
        } completion:^(BOOL finished) {
            [placeholderLabel1 removeFromSuperview];
        }];
        
    }
}

- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    if (![txtView hasText]) {
        [txtView addSubview:placeholderLabel];
        [UIView animateWithDuration:0.15 animations:^{
            placeholderLabel.alpha = 1.0;
        }];

    }
    if (![txtSignature hasText]) {
        [txtSignature addSubview:placeholderLabel1];
        [UIView animateWithDuration:0.15 animations:^{
            placeholderLabel1.alpha = 1.0;
        }];
        
    }
}

-(IBAction)updateLetter{
	saveUpdate=1;
	[dict setValue:txtDate.text forKey:@"Date"];
	[dict setValue:txtDear.text forKey:@"Dear"];
	//[dict setValue:self.letterView.letterName forKey:@"LetterName"];
	[dict setValue:txtSignature.text forKey:@"Sign"];
	[dict setValue:txtView.text forKey:@"Body"];
	[dict setValue:appdel.appFontName forKey:@"Font"];
    [dict setValue:appdel.indexOfFont forKey:@"IndexNO"];
    [dict setValue:txtSub.text forKey:@"Subject"];
    [dict setValue:txtSalutation.text forKey:@"salutation"];
	NSLog(@"id is:%@",txtSignature.text);
	NSLog(@"here %@",[appdel.arrLetterDet valueForKey:@"ID"]);
	[dal updateRecord:dict forID:@"ID=" inTable:@"tblBusiness" 
            withValue:[NSString stringWithFormat:@"%@", [appdel.arrLetterDet valueForKey:@"ID"]]];
	
    if(coming==0){
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Updated"
												  message:@"Letter Updated" 
												 delegate:self 
										cancelButtonTitle:@"OK" 
										otherButtonTitles:nil];
    alert.tag=2;
	[alert show];
	[alert release];
    }
}
-(IBAction)updateLetter1{
	
    saveUpdate=1;
    [dict setValue:txtDate.text forKey:@"Date"];
	[dict setValue:txtDear.text forKey:@"Dear"];
	[dict setValue:letter forKey:@"LetterName"];
	[dict setValue:txtSignature.text forKey:@"Sign"];
	[dict setValue:txtView.text forKey:@"Body"];
	[dict setValue:appdel.appFontName forKey:@"Font"];
    [dict setValue:appdel.indexOfFont forKey:@"IndexNO"];
    [dict setValue:txtSub.text forKey:@"Subject"];
    [dict setValue:txtSalutation.text forKey:@"salutation"];
	NSLog(@"id is:%@",txtSignature.text);
	NSLog(@"here %@",[appdel.arrLetterDet valueForKey:@"ID"]);
	[dal updateRecord:dict forID:@"ID=" inTable:@"tblBusiness" 
            withValue:[NSString stringWithFormat:@"%@", [appdel.arrLetterDet valueForKey:@"ID"]]];
	
    if(coming==0){
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Updated"
												  message:@"Letter Updated" 
												 delegate:self 
										cancelButtonTitle:@"OK" 
										otherButtonTitles:nil];
	[alert show];
	[alert release];
    }
   
}

-(IBAction) btnSubmit :(id)sender
{
    [btnSubmit setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
	isTrue=FALSE;
	[txtDate resignFirstResponder];
	[txtDear resignFirstResponder];
	[txtView resignFirstResponder];
	[txtSignature resignFirstResponder];
	appdel = (testmapAppDelegate*)[[UIApplication sharedApplication]delegate];
	appdel.appTxtBody=txtView.text;
    
	appdel.appTxtDate=txtDate.text;
	appdel.appTxtDear=txtDear.text;
	appdel.appTxtSign=txtSignature.text;
    appdel.appSubject=txtSub.text;
    appdel.appSalutation=txtSalutation.text;
    if([appdel.appTxtDate isEqualToString:@"Select Date"]){
        NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
		[timeFormat setDateFormat:@"MMMM dd,yyyy"];
		NSString *theTime = [timeFormat stringFromDate:[NSDate date]];
        NSLog(@"%@",theTime);
        appdel.appTxtDate=theTime;
    }
    if([appdel.appSalutation isEqualToString:@"Select Salutation"]){
        appdel.appSalutation=@"Sincerly";
    }
    if([appdel.appTxtDear isEqualToString:@"Select Greetings"]){
        appdel.appTxtDear=@"Dear";
    }

    
    //	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Submit" message:@"Do you want to attach letter?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    //
    //	[alert show];
    //	[alert release];
    appdel.bolChoose=TRUE;
    
    NSLog(@"font is %@",appdel.appFontName);
    NSLog(@"sign is %@",txtSignature.text);
    //create the file path to store our PDF document (will be created inside our app's documents directory) 
    //If you're using the simulator, the file can be found in: homeFolder/Library/Application Support/iPhone Simulator/versionOfIOS_Simulator/Applications/SomeWeirdStringIdentifyingYourApp/Documents/
    
    NSString *fileName = @"OurPDF.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *saveDirectory = [paths objectAtIndex:0];
	NSString *saveFileName = fileName;
	NSString *documentPath = [saveDirectory stringByAppendingPathComponent:saveFileName];
    
    PDFHelper *objPDF=[[PDFHelper alloc]init ];
    [objPDF createPDF:documentPath withContent:appdel.appTxtBody forSize:17 andFont:[NSString stringWithFormat:@"%@",appdel.appFontName] andColor:[UIColor blackColor] :YES :YES :([appdel.appTxtBody length] > 0) ? pdfPasswordTextField.text : nil];
    [objPDF release];
    NSLog(@"no of pages%d",appdel.noOfPages);
    if(!isTrue){
        appdel.bolLetter=YES;
        appdel.count=1;
        self.tabBarController.selectedIndex=2;
       // photoView *photoViewController = [[photoView alloc] initWithNibName:@"photoView" bundle:nil];
        //[self.navigationController pushViewController:photoViewController animated:YES];
    }
	
}
-(IBAction)click:(id)sender{
	
	
	
	
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        
//        NSString *str=[txtSignature.text stringByAppendingString:@"/\$"];
//        //[txtSignature.text stringByAppendingString:@"\n"];
//        
//        NSLog(@"string %@",str);
//        
//        //return FALSE;
//    }
//    return TRUE;
//}
-(IBAction) back :(id)sender{
	[self.navigationController popViewControllerAnimated:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(alertView.tag==1){
        
        ChooseExistingLetter *objExists=[[ChooseExistingLetter alloc]initWithNibName:@"ChooseExistingLetter" bundle:nil];
        [self.navigationController pushViewController:objExists animated:YES];
        [objExists release];
        
    }
    
    else if(alertView.tag==2){
        
        
    }
    
    
    //    else{
    //	if (buttonIndex==1) 
    //	{
    //		if(!isTrue){
    //        appdel.bolLetter=TRUE;
    //		letterDelegate.count=1;
    //		self.tabBarController.selectedIndex=2;
    //		photoViewController = [[photoView alloc] initWithNibName:@"photoView" bundle:nil];
    //		[self.navigationController pushViewController:photoViewController animated:YES];
    //		}
    //    }
    //        else{
    //            self.tabBarController.selectedIndex=3;
    //        }
    //		
    //
    //	}
}	


-(IBAction)backButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //    CreateChooseLetter *objChoose=[[CreateChooseLetter alloc]initWithNibName:@"CreateChooseLetter" bundle:nil];
    //    [self.navigationController pushViewController:objChoose animated:YES];
    //    [objChoose release];
}

-(IBAction)saveLetter
{
    //    UIBarButtonItem *buttonSave = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateLetter1)]; 
    //    self.navigationItem.rightBarButtonItem = buttonSave;
    //    [buttonSave release];
    saveUpdate=1;
	[dict setValue:txtDate.text forKey:@"Date"];
	[dict setValue:txtDear.text forKey:@"Dear"];
	[dict setValue:appdel.appLetterName forKey:@"LetterName"];
	[dict setValue:txtSignature.text forKey:@"Sign"];
	[dict setValue:txtView.text forKey:@"Body"];
  	[dict setValue:appdel.appFontName forKey:@"Font"];
    [dict setValue:appdel.indexOfFont forKey:@"IndexNO"];
	[dict setValue:txtSub.text forKey:@"Subject"];
    [dict setValue:txtSalutation.text forKey:@"salutation"];
	NSLog(@"dict is %@",dict);
    
    [dal insertRecord:dict inTable:@"tblBusiness"];
    if(coming==0){
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Saved"
												  message:@"Letter Saved" 
												 delegate:self 
										cancelButtonTitle:@"OK" 
										otherButtonTitles:nil];
    
    alert.tag=1;
	[alert show];
	[alert release];
    }
    
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if(textView==txtSignature){
        nextBtn.enabled=NO;
        prevBtn.enabled=YES;
        [scrollView setContentOffset:CGPointMake(0, 380) animated:YES];
    }
    else{
        nextBtn.enabled=YES;
        prevBtn.enabled=YES;
    }
    if(textView==txtView){
        
        [scrollView setContentOffset:CGPointMake(0, 190) animated:YES];
    }
    activeView=textView;
    flag=1;
    return YES;
}
#pragma mark UIDatePicker
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    flag=0;
    activeField=textField;
    prevBtn.enabled=NO;
    nextBtn.enabled=YES;
	if ([textField isEqual:txtDate])
    {
		
        if (!actionSheetDOB)
        {
			[txtDear resignFirstResponder];
			[txtView resignFirstResponder];
			[txtSignature resignFirstResponder];
            actionSheetDOB = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionSheetDOB setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
			
            CGRect pickerFrame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
			
            pickerViewDOB = [[UIDatePicker alloc] initWithFrame:pickerFrame];
			pickerViewDOB.minuteInterval=1;
			pickerViewDOB.datePickerMode=UIDatePickerModeDate;
            //pickerViewDOB.showsSelectionIndicator = YES;
            pickerViewDOB.userInteractionEnabled = TRUE;
			//  pickerViewDOB.dataSource = self;
			//  pickerViewDOB.delegate = self;
            [actionSheetDOB addSubview:pickerViewDOB];
			
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
            closeButton.momentary = YES;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
			
			
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
            [actionSheetDOB addSubview:closeButton];
            [closeButton release];
			
			
            CGRect frame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
			
            [actionSheetDOB setFrame:frame];
            [self.view addSubview:actionSheetDOB];
			
            return NO;           
        }
    }
    else if([txtSalutation isEqual:textField]){
        if (!actionSheetSal)
        {
            [scrollView setContentOffset:CGPointMake(0, 300) animated:YES];
            [txtSignature resignFirstResponder];
			[txtDear resignFirstResponder];
			[txtView resignFirstResponder];
			[txtSignature resignFirstResponder];
            actionSheetSal = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionSheetSal setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
            
            CGRect pickerFrame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
            
            pickerViewSal = [[UIPickerView alloc] initWithFrame:pickerFrame];
            pickerViewSal.showsSelectionIndicator = YES;
            pickerViewSal.userInteractionEnabled = TRUE;
            pickerViewSal.dataSource = self;
            pickerViewSal.delegate = self;
            [actionSheetSal addSubview:pickerViewSal];
            
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
            closeButton.momentary = YES;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
            
            
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
            [actionSheetSal addSubview:closeButton];
            [closeButton release];
            
            
            CGRect frame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
            
            [actionSheetSal setFrame:frame];
            [self.view addSubview:actionSheetSal];
            
            return NO;           
        }

    }
    else if(textField==txtDear){
        if (!actionSheetGreet)
        {
            [txtDate resignFirstResponder];
			[txtDear resignFirstResponder];
			[txtView resignFirstResponder];
			[txtSignature resignFirstResponder];
            actionSheetGreet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionSheetGreet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
            
            CGRect pickerFrame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
            
            pickerViewGreet = [[UIPickerView alloc] initWithFrame:pickerFrame];
            pickerViewGreet.showsSelectionIndicator = YES;
            pickerViewGreet.userInteractionEnabled = TRUE;
            pickerViewGreet.dataSource = self;
            pickerViewGreet.delegate = self;
            [actionSheetGreet addSubview:pickerViewGreet];
            
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
            closeButton.momentary = YES;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
            
            
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
            [actionSheetGreet addSubview:closeButton];
            [closeButton release];
            
            
            CGRect frame;
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
            
            [actionSheetGreet setFrame:frame];
            [self.view addSubview:actionSheetGreet];
            
            return NO;           
        }
    }

    else {
        actionSheetSal.hidden=TRUE;
        actionSheetDOB.hidden = TRUE;
        actionSheetGreet.hidden=TRUE;
        return YES;
    }
	
    return 0;
}

-(void)dismissActionSheet
{
    if (actionSheetDOB) 
    {
		
		NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
		[timeFormat setDateFormat:@"MMMM dd,yyyy"];
		NSString *theTime = [timeFormat stringFromDate:[pickerViewDOB date]];
		
		
		
        
		txtDate.text=theTime;
        
    }
    if (actionSheetSal) 
    {
		if ([txtSalutation.text isEqualToString:@"Select Salutation"])
        {
            txtSalutation.text=[NSString stringWithFormat:@"%@",[arrSalutations objectAtIndex:0]];
            
        }     
        
    }
    if (actionSheetGreet) 
    {
		if ([txtDear.text isEqualToString:@"Select Greetings"])
        {
            txtDear.text=[NSString stringWithFormat:@"%@",[arrGreetings objectAtIndex:0]];
            
        }     
        
    }
    actionSheetDOB.hidden = TRUE;
    [actionSheetDOB release];
    actionSheetDOB=nil;
    actionSheetGreet.hidden=TRUE;
    [actionSheetGreet release];
    actionSheetGreet=nil;
    actionSheetSal.hidden = TRUE;
    [actionSheetSal release];
    actionSheetSal=nil;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == pickerViewSal) {
        return 1;
    }
    if (pickerView == pickerViewGreet) {
        return 1;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView == pickerViewSal)
    {
        NSString *a =  [arrSalutations objectAtIndex:row];
        txtSalutation.text= [NSString stringWithFormat:@"%@",a];
    }
    if(pickerView==pickerViewGreet){
        NSString *a =  [arrGreetings objectAtIndex:row];
        txtDear.text= [NSString stringWithFormat:@"%@",a];
    }

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if(pickerView == pickerViewSal)
    {
        if (component==0)
        {
            return [arrSalutations count];
        }
    }
    if(pickerView == pickerViewGreet)
    {
        if (component==0)
        {
            return [arrGreetings count];
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

{
    if(pickerView == pickerViewSal)
    {
        if (component==0)
        {
            return [arrSalutations objectAtIndex:row];
        }
    }
    if(pickerView == pickerViewGreet)
    {
        if (component==0)
        {
            return [arrGreetings objectAtIndex:row];
        }
    }

    return 0;
}
-(void)viewWillDisappear:(BOOL)animated{
    if (saveUpdate==0) {
        if(appdel.isLetter){
            coming=1;
            [self saveLetter];
        }
        else{
            coming=1;
            [self updateLetter];
        }
    }

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
