//
//  letterView.m
//  testmap
//
//  Created by apple  on 10/10/11.
//  Copyright 2011 bvhkh. All rights reserved.
//

#import "letterView.h"
#import "BusinessFormat.h"
@implementation letterView
@synthesize tblFont,txtLetName,letterName;

// The designate d initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
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
	pickerViewCBrand.hidden=TRUE;
	//[self.view addSubview:tblFont];
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
	tblFont.hidden=TRUE;
	arrFontName=[[NSMutableArray alloc]initWithObjects:@"Courier",@"Arial",
				@"Courier New",@"Zapfino",@"Arial Unicode MS",@"American Typewriter",
				 @"Helvetica", @"Marker Felt", @"Helvetica Neue",@"DB LCD Temp",@"Verdana",@"Times New Roman",@"Georgia",@"Arial Rounded MT Bold",@"Trebuchet MS",nil]; 
	
	
//	arrFontName=[[NSMutableArray alloc]initWithObjects:@"Courier",@"Courier-Bold",@"Courier-Oblique",
//				 @"Courier-BoldOblique",@"Helvetica",@"Helvetica-Oblique",@"Helvetica-BoldOblique",nil]; 
	
	
	//@"Times-Roman",@"Times-Bold",@"Times-Italic",@"Times-BoldItalic"
//	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButton)]; 
//    self.navigationItem.leftBarButtonItem = buttonItem;
//    [buttonItem release];
	self.navigationController.navigationBar.tintColor=[UIColor blackColor];
	//self.navigationController.navigationBarHidden=TRUE;	
}
-(void)viewWillAppear:(BOOL)animated{
    isBusiness=TRUE;
    isFrd=FALSE;
    self.title=@"Choose Letter Format";
    [btnNext setImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
    dal=[[DAL alloc]init];
    [dal initDatabase:@"DBInmate.sqlite"];
    if(appdel.tabController.selectedIndex==1)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}
-(IBAction) btnnext :(id)sender
{
   
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create A Title For Letter" message:@" "
						  
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	
		
	
	
	if(!txtLetName) {
		CGRect frame = CGRectMake(14, 45, 255, 30);
		txtLetName = [[UITextField alloc] initWithFrame:frame];
		
		txtLetName.borderStyle = UITextBorderStyleBezel;
		
		txtLetName.textColor = [UIColor blackColor];
		
		txtLetName.textAlignment = UITextAlignmentCenter;
		
		txtLetName.font = [UIFont systemFontOfSize:14.0];
		
		txtLetName.placeholder = @"<Enter letter name >";
		
		
		txtLetName.backgroundColor = [UIColor whiteColor];
		
		txtLetName.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
		
		txtLetName.keyboardType = UIKeyboardTypeDefault; // use the default type input method (entire keyboard)
		
		txtLetName.returnKeyType = UIReturnKeyDefault;
		
		
		
		txtLetName.clearButtonMode = UITextFieldViewModeWhileEditing; // has a clear 'x' button to the right
		
	}
    [alert addSubview:txtLetName];
    [alert show];
    [alert release];
	
}

-(IBAction) btnFont :(id)sender
{
    
	tblFont.hidden=TRUE;
	pickerViewCBrand.hidden=FALSE;
	[pickerViewCBrand reloadAllComponents];
}
-(IBAction)clickBusiness:(id)sender{
	if(isBusiness)
        isBusiness=FALSE;
    else
        isBusiness=TRUE;
	[btnFrd setImage:[UIImage imageNamed:@"btnRadio.png"] forState:UIControlStateNormal];
	[btnBussiness setImage:[UIImage imageNamed:@"selRadio.png"] forState:UIControlStateNormal];

	
	
}
-(IBAction)clickFrd:(id)sender{
	if(isFrd)
        isFrd=FALSE;
    else
        isFrd=TRUE;
	[btnBussiness setImage:[UIImage imageNamed:@"btnRadio.png"] forState:UIControlStateNormal];
	[btnFrd setImage:[UIImage imageNamed:@"selRadio.png"] forState:UIControlStateNormal];
	
	
	
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	pickerViewCBrand.hidden=TRUE;
//}

//-(void)backButton
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [arrFontName count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.font=[UIFont fontWithName:[NSString stringWithFormat:@"%@",[arrFontName objectAtIndex:indexPath.row]] size:18];
	cell.textLabel.text=[arrFontName objectAtIndex:indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	appdel.appFontName=[arrFontName objectAtIndex:indexPath.row];
   	
}
#pragma mark pickerview
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([textField isEqual:carbrandtext])
    {
		
        if (!actionSheetCBrand)
        {
			[carbrandtext resignFirstResponder];
            actionSheetCBrand = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
            [actionSheetCBrand setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
			
            CGRect pickerFrame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                pickerFrame = CGRectMake(0, 40, 768, 300);
            else
                pickerFrame = CGRectMake(0, 40, 320, 200);
			
            pickerViewCBrand = [[UIPickerView alloc] initWithFrame:pickerFrame];
            pickerViewCBrand.showsSelectionIndicator = YES;
            pickerViewCBrand.userInteractionEnabled = TRUE;
            pickerViewCBrand.dataSource = self;
            pickerViewCBrand.delegate = self;
            [actionSheetCBrand addSubview:pickerViewCBrand];
			
            UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Select"]];
            closeButton.momentary = YES;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
            else
                closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
			
			
            closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
            closeButton.tintColor = [UIColor blackColor];
            [closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
            [actionSheetCBrand addSubview:closeButton];
            [closeButton release];
			
			
            CGRect frame;
			
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                frame = CGRectMake(self.view.frame.origin.x, 630, 768.0f,350.0f);
            else
                frame = CGRectMake(self.view.frame.origin.x, 160, 480.0f,300.0f);
			
            [actionSheetCBrand setFrame:frame];
            [self.view addSubview:actionSheetCBrand];
			
            return NO;           
        }
    }
    else {
        return YES;
    }
    return 0;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==1 && txtLetName.text){
        int duplicate=0;
        NSMutableArray *arr=[[NSMutableArray alloc] init];
         arr=[[dal SelectWithStar:@"tblBusiness"]retain];
        NSMutableArray *arrLetterName=[[NSMutableArray alloc] init];
        arrLetterName=[[dal SelectWithStar:@"tblFrdFormat"] retain];
       
        for(int i=0;i<[arr count];i++){
            if([[[arr objectAtIndex:i] valueForKey:@"LetterName"] isEqualToString:txtLetName.text])
            {
                duplicate=1;
                txtLetName.text=@"";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Duplicate Titile" message:@"The title already exists."
                                      
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
                [alert release];
            }
        }
        for(int i=0;i<[arrLetterName count];i++){
            if([[[arrLetterName objectAtIndex:i] valueForKey:@"LetterName"] isEqualToString:txtLetName.text])
            {
                duplicate=1;
                txtLetName.text=@"";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Duplicate Titile" message:@"The title already exists."
                                      
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
                [alert release];
            }
        }
        [btnNext setImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
        letterFormatViewController = [[letterFormat alloc] initWithNibName:@"letterFormat" bundle:nil];
        [txtLetName resignFirstResponder];
        letterName=[[NSString alloc]init];
        appdel.appLetterName=[NSString stringWithFormat:@"%@",txtLetName.text];
        
        if ([carbrandtext.text isEqualToString:@"Select Font"]){
            appdel.appFontName=@"Helvetica";
        }
        letterFormatViewController.letterView = self;
       
        if(isFrd && duplicate==0){
             letterFormatViewController.title= @"Friend Letter";
             [self.navigationController pushViewController:letterFormatViewController animated:YES];
        }
       
        else{
            if(duplicate==0){
            BusinessFormat *objBusiness=[[BusinessFormat alloc] init];
            objBusiness.title=@"Business Letter";
            [self.navigationController pushViewController:objBusiness animated:YES];
            [objBusiness release];
            }
        }
    }
}
-(void)dismissActionSheet
{
    if (actionSheetCBrand)
    {
        if ([carbrandtext.text isEqualToString:@"Select Font"])
        {
            carbrandtext.text=[NSString stringWithFormat:@"%@",[arrFontName objectAtIndex:0]];
            appdel.appFontName=[arrFontName objectAtIndex:0];
            
        }       
    }
	
    actionSheetCBrand.hidden = TRUE;
    
    [actionSheetCBrand release];
    actionSheetCBrand=nil;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == pickerViewCBrand) {
        return 1;
    }
	return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
    if (pickerView == pickerViewCBrand)
    {
       //NSString * a =  [arrFontName objectAtIndex:row];
		appdel.appFontName=[arrFontName objectAtIndex:row];
		NSLog(@"%@",appdel.appFontName);
        carbrandtext.text= [NSString stringWithFormat:@"%@",appdel.appFontName];
        appdel.indexOfFont=[NSString   stringWithFormat:@"%d",row];
        NSLog(@"%@",appdel.indexOfFont);
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if(pickerView == pickerViewCBrand)
    {
        if (component==0)
        {
            return [arrFontName count];
        }
    }
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

{
    if(pickerView == pickerViewCBrand)
    {
        if (component==0)
        {
            return [arrFontName objectAtIndex:row];
        }
    }
	return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *retval = (id)view;
	if (!retval) {
		retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerViewCBrand rowSizeForComponent:component].width, [pickerViewCBrand rowSizeForComponent:component].height)] autorelease];
	}
	
	retval.text =[arrFontName objectAtIndex:row];
	
	retval.font = [UIFont fontWithName:[NSString stringWithFormat:@"%@",[arrFontName objectAtIndex:row]] size:18];
	
	return retval;
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
