//
//  CreditCard.m
//  testmap
//
//  Created by Hirak on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreditCard.h"
#import "AlertHandler.h"
#import "SBJSON.h"
#import "PdfController.h"
//#import "AuthNetUnitTests.h"
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;


@implementation CreditCard

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
	dal=[[DAL alloc]init];
	[dal initDatabase:@"DBInmate.sqlite"];
    arrCardType=[[NSArray alloc] initWithObjects:@"Discover Card",@"MasterCard",@"Visa Card",nil];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    
     NSLog(@"here is the amount%@",appDel.dataInmate);
      NSLog(@"%@",[appDel.dataInmate objectForKey:@"UserName"]);
    if(appDel.tabController.selectedIndex==3)
    {
        
    }
    else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    scroll.frame=CGRectMake(0, 0, 320, 480);
    [scroll setContentSize:CGSizeMake(0, 600) ];
 
      [btnDone setBackgroundImage:[UIImage imageNamed:@"newBlueBg.png"] forState:UIControlStateNormal];
	self.title=@"Credit Card";
   objThanks=[[thankyouView alloc]init];
    objThanks.message.hidden=TRUE;
    //authNetUnitTests=[[AuthNetUnitTests alloc]init];
	//self.navigationController.navigationBarHidden=TRUE;
	if (appDel.isExist==TRUE)
	{
		arrCreditDet=[[NSMutableArray alloc]init];
	
		arrCreditDet=[dal SelectWithStar:@"tblCreditCard" withCondition:@"ID" withColumnValue:[NSString stringWithFormat:@"%@",appDel.creditNO]];
		NSLog(@"query is : %@",arrCreditDet);
		tfldNumber.text=[NSString stringWithFormat:@"%@",[[arrCreditDet valueForKey:@"cardNumber"]objectAtIndex:0]];
		tfldHolder.text=[[arrCreditDet valueForKey:@"cardHolder"]objectAtIndex:0];
		tfldDate.text=[[arrCreditDet valueForKey:@"expiryDate"]objectAtIndex:0];
		tfldCode.text=[[arrCreditDet valueForKey:@"sCode"]objectAtIndex:0];
		tfldType.text=[[arrCreditDet valueForKey:@"cardType"]objectAtIndex:0];
        tfldEmail.text=[[arrCreditDet valueForKey:@"email"] objectAtIndex:0];
        
        UIBarButtonItem *buttonSave = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateCreditCard)]; 
		self.navigationItem.rightBarButtonItem = buttonSave;
		[buttonSave release];
        UIBarButtonItem *buttonSave1 = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onBack)]; 
		self.navigationItem.leftBarButtonItem = buttonSave1;
		[buttonSave1 release];
	}
	else if (appDel.isExist==FALSE)
	{
		tfldNumber.text=@"";
		tfldHolder.text=@"";
		tfldDate.text=@"";
		tfldCode.text=@"";
		tfldType.text=@"";
        tfldEmail.text=@"";
       
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
    [tfldNumber setInputAccessoryView:toolbar];
    [tfldHolder setInputAccessoryView:toolbar];
    [tfldDate setInputAccessoryView:toolbar];
    [tfldCode setInputAccessoryView:toolbar];
    [tfldType setInputAccessoryView:toolbar];
    [tfldEmail setInputAccessoryView:toolbar];
    PdfController *pdfCon=[[PdfController alloc] init];
    [pdfCon CreateContact];
    [pdfCon release];
    
   
	
}

-(void)next {
    nextBtn.enabled=YES;
    prevBtn.enabled=YES;
    if(activeField==tfldNumber){
        [tfldHolder becomeFirstResponder];
        
    }
    else if(activeField==tfldHolder){
        [tfldDate becomeFirstResponder];
    }
    else if(activeField==tfldDate){
        [tfldCode becomeFirstResponder];
        
    }
    else if(activeField==tfldCode){
        
        [tfldType becomeFirstResponder];
       
    }
    else if(activeField==tfldType){
        [tfldEmail becomeFirstResponder];
        nextBtn.enabled=NO;
    }
     
    
    
}
-(void)prev {
    prevBtn.enabled=YES;
    nextBtn.enabled=YES;
    if(activeField==tfldNumber){
        prevBtn.enabled=NO;
        
    }
    else if(activeField==tfldHolder){
        [tfldNumber becomeFirstResponder];
    }
    else if(activeField==tfldDate){
        [tfldHolder becomeFirstResponder];
        
    }
    else if(activeField==tfldCode){
        [tfldDate becomeFirstResponder];
    }
    else if(activeField==tfldEmail){
        [tfldEmail resignFirstResponder];
        [tfldType becomeFirstResponder];
    }
        
}

-(void)resignKeyboard {
    [activeField resignFirstResponder];
    [tfldEmail resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}
#pragma mark IBAction
-(IBAction)updateCreditCard{
	
    [appDel.dataCreditCard setValue:tfldNumber.text forKey:@"cardNumber"];
	[appDel.dataCreditCard setValue:tfldHolder.text forKey:@"cardHolder"];
	[appDel.dataCreditCard setValue:tfldDate.text forKey:@"expiryDate"];
	[appDel.dataCreditCard setValue:tfldCode.text forKey:@"sCode"];
	[appDel.dataCreditCard setValue:tfldType.text forKey:@"cardType"];
    [appDel.dataCreditCard setValue:tfldEmail.text forKey:@"email"];
  	NSLog(@"here %@",[appDel.dataCreditCard valueForKey:@"ID"]);
	[dal updateRecord:appDel.dataCreditCard forID:@"ID=" inTable:@"tblCreditCard" 
            withValue:[NSString stringWithFormat:@"%@", appDel.creditNO]];
	
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Updated"
												  message:@"Credit Card Information Updated" 
												 delegate:self 
										cancelButtonTitle:@"OK" 
										otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(IBAction)onBack{
	
	[self.navigationController popViewControllerAnimated:YES];
	
	
}
-(IBAction) doneClicked:(id)sender
{
     
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
	[dateFormatter setDateFormat:@"MM-yy"];
	NSDate *date = [dateFormatter dateFromString:tfldDate.text];
//    strNew=[dateFormatter stringFromDate:date];
//    
//	NSLog(@"date is %@",strNew);
//    strNew = [strNew stringByReplacingOccurrencesOfString:@"-"                                                                                                   withString:@""];
    BOOL isValid=[self isValidCreditCardNumber:tfldNumber.text];
    BOOL emailstatus=[self validateEmailWithString:tfldEmail.text];
    if([tfldCode.text isEqualToString:@""] || [tfldDate.text isEqualToString:@""] || [tfldHolder.text isEqualToString:@""] || [tfldNumber.text isEqualToString:@""] || [tfldType.text isEqualToString:@""] ){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                      message:@"Please enter all details" 
                                                     delegate:self 
                                            cancelButtonTitle:@"OK" 
                                            otherButtonTitles:nil];
        
        [alert show];
        [alert release];
        

    }
    else if (!isValid)
	{	
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                      message:@"Please enter a valid card number" 
                                                     delegate:self 
                                            cancelButtonTitle:@"OK" 
                                            otherButtonTitles:nil];
        
        [alert show];
        [alert release];
        
    }
	
	else  if (!date) { 
		
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Incorrect Date" message:@"Please Enter Date in mm-yy Format" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		alert.tag=2;
		[alert show];
		[alert release];
		
	}
    else if([tfldCode.text length]!=3){
       
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Incorrect Code" message:@"Please Enter Three Digit Security code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		alert.tag=2;
		[alert show];
		[alert release];
    }
    else if(!emailstatus){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Invalid E-Mail" message:@"Please Enter a valid E-Mail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		alert.tag=2;
		[alert show];
		[alert release];
        
    }
    else{
        
              
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Are You sure to want to Complete Transaction?"
                                                      message:@"" 
                                                     delegate:self 
                                            cancelButtonTitle:nil 
                                            otherButtonTitles:@"Yes",@"No",nil];
        alert.tag=1;
        [alert show];
        [alert release];
            
       
        
    }
   
}
-(void)showAlertMethd{
     [AlertHandler showAlertForProcess];
}
-(void)authorize{
    // http://openxcellaus.info/InMate/payment/action/payment.php
    //http://notforgotten.biz/webservice/payment/action/payment.php
    

    NSArray *arr=[tfldDate.text componentsSeparatedByString:@"-"];
    
      NSString *post = [NSString stringWithFormat:@"fname=%@&card_number=%@&card_type=%@&month=%@&year=%@&amount=%.2f&card_code=%@&email=%@",tfldHolder.text,tfldNumber.text,tfldType.text,[arr objectAtIndex:0],[arr objectAtIndex:1],appDel.finalAmt,tfldCode.text,tfldEmail.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
 
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://notforgotten.biz/webservice/payment/action/payment.php"]]];

    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *urlResponse = nil;
    NSError *requestError;
    
    NSData *responseData = [ NSURLConnection sendSynchronousRequest: request returningResponse: &urlResponse error: &requestError ];
    
    if (responseData == nil) {
        if (requestError != nil) {
            NSLog(@"error ");
            NSLog(@"%@",requestError);
            [AlertHandler hideAlert];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Connection to Server Failed!"												  message:[NSString stringWithFormat:@"Please check your Network Connection"] 
                                                         delegate:self 										cancelButtonTitle:@"OK" 						otherButtonTitles:nil];	
            [alert show];
            [alert release];
            

        }
        
        return; 
    }
    else {
        NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
        SBJSON *parser = [[SBJSON alloc] init];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        dic= [parser objectWithString:jsonString];
        
        NSString *strMsg =  [dic valueForKey:@"msg"];
        
        NSLog(@"%@",strMsg);
        
        if([strMsg isEqualToString:@"Success"]){
            
            if(!appDel.isExist){
                NSLog(@"%@",tfldNumber.text);
                [appDel.dataCreditCard setValue:tfldNumber.text forKey:@"cardNumber"];
                [appDel.dataCreditCard setValue:tfldHolder.text forKey:@"cardHolder"];
                [appDel.dataCreditCard setValue:tfldDate.text forKey:@"expiryDate"];
                [appDel.dataCreditCard setValue:tfldCode.text forKey:@"sCode"];
                [appDel.dataCreditCard setValue:tfldType.text forKey:@"cardType"];
                [appDel.dataCreditCard setValue:tfldEmail.text forKey:@"email"];
                [dal insertRecord:appDel.dataCreditCard inTable:@"tblCreditCard"];
                NSLog(@"%@",appDel.dataCreditCard);
                
            }

            [self SendData];
        }
        else{
            [AlertHandler hideAlert];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry!"												  message:[NSString stringWithFormat:@"%@",strMsg] 
                                                         delegate:self 										cancelButtonTitle:@"OK" 						otherButtonTitles:nil];	
            [alert show];
            [alert release];
        }

    }
    
    }
- (BOOL)validateEmailWithString:(NSString*)email11
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email11];
	
}
-(BOOL) isValidCreditCardNumber:(NSString *)number {
    
	NSString *toTest = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
	
    int n, i, alternate, sum;
	
    n = [toTest length];
	
    if (n < 13 || n > 19)
        return 0;
	
    for (alternate = 0, sum = 0, i = n - 1; i > -1; --i) {
        if (!isdigit([toTest characterAtIndex:i]))
            return 0;
		
        n = [toTest characterAtIndex:i] - '0';
		
        if (alternate) {
            n *= 2;
            if (n > 9)
                n = (n % 10) + 1;
        }
        alternate = !alternate;
		
        sum += n;
    }
	
    return (sum % 10 == 0);
}


-(void)SendData{
    
    
    if(appDel.bolPhoto && appDel.bolLetter){
    arrNsImages=[[NSMutableArray alloc]initWithCapacity:[appDel.arrImageData count]+2];
    }
    else if(appDel.bolPhoto && !appDel.bolLetter){
        arrNsImages=[[NSMutableArray alloc]initWithCapacity:[appDel.arrImageData count]+1];
    }
    else if(appDel.bolLetter && !appDel.bolPhoto){
        arrNsImages=[[NSMutableArray alloc]initWithCapacity:2];
    }
    else {
        arrNsImages=[[NSMutableArray alloc] init];
    }
    if(appDel.bolPhoto){
    for(int i=0;i<[appDel.arrImageData count];i++){
        
        NSData *dataObj = UIImageJPEGRepresentation([appDel.arrImageData objectAtIndex:i], 1.0);
        [arrNsImages   addObject:dataObj];
               
    }        
    }
   
    if(appDel.bolLetter){
        NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(
                                                                     NSDocumentDirectory,
                                                                     NSUserDomainMask,
                                                                     YES);
        NSString *path1 = [arrayPaths objectAtIndex:0];
        path1 = [path1 stringByAppendingString:@"/"];
        path1 = [path1 stringByAppendingString:@"inmate.pdf"];

        data = [NSData dataWithContentsOfFile:path1];
       
        [arrNsImages addObject:data];
    }
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(
                                                              NSDocumentDirectory,
                                                              NSUserDomainMask,
                                                              YES);
    NSString *path1 = [arrayPaths objectAtIndex:0];
    path1 = [path1 stringByAppendingString:@"/"];
    path1 = [path1 stringByAppendingString:@"contact.pdf"];
    
    data = [NSData dataWithContentsOfFile:path1];
    
    [arrNsImages addObject:data];
    
        if(!appDel.bolMoney){
        appDel.moneyorderAmt=0.0;
    }
   
    //http://openxcellaus.info/InMate/mail.php?
    //http://notforgotten.biz/webservice/mail.php?
    //http://notforgotten.biz/webservice/testing/mail_final.php?
    
    NSString *strurlpara=[NSString stringWithFormat:@"http://notforgotten.biz/webservice/testing/mail_final.php?moneyorder=%.2f&email=%@&mFname=%@&mLname=%@&mInMateId=%@&mBed=%@&mInstituteName=%@& mInstituteAddress=%@&mCity=%@&mState=%@&mZipCode=%@&sFname=%@&sLname=%@&sAddress=%@&sCity=%@&sState=%@&sZipCode=%@&sEmail=%@",appDel.moneyorderAmt,tfldEmail.text,[appDel.dataInmate objectForKey:@"InName"],[appDel.dataInmate objectForKey:@"ILastName"],[appDel.dataInmate objectForKey:@"iid"],[appDel.dataInmate objectForKey:@"bed"],[appDel.dataInmate objectForKey:@"IInstName"],[appDel.dataInmate objectForKey:@"InAdd"],[appDel.dataInmate objectForKey:@"InCity"],[appDel.dataInmate objectForKey:@"InState"],[appDel.dataInmate objectForKey:@"InZip"],[appDel.dataInmate objectForKey:@"UserName"],[appDel.dataInmate objectForKey:@"ULastName"],[appDel.dataInmate objectForKey:@"UserAdd"],[appDel.dataInmate objectForKey:@"UserCity"],[appDel.dataInmate objectForKey:@"UserState"],[appDel.dataInmate objectForKey:@"UserZip"],tfldEmail.text];
    strurlpara=[strurlpara stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
  
    NSURL *url = [NSURL URLWithString:strurlpara];

    NSLog(@"url is %@",url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:url];
	[request setHTTPMethod:@"POST"];
    [self callPOST:@"test" withParameter:@"fileatt" withRequest:request withData:data];
    
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
   
    NSLog(@"%@",responseString);
    [AlertHandler hideAlert];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"newBlackBg.png"] forState:UIControlStateNormal];
    thankyouView *objCreditCard = [[thankyouView alloc] initWithNibName:@"thankyouView" bundle:nil];
	[self.navigationController pushViewController:objCreditCard animated:YES];
	[self dismissModalViewControllerAnimated:YES];
   
    
}
-(void)callPOST:(NSString *)filename withParameter:(NSString *)strparameter  withRequest:(NSMutableURLRequest *)request withData:(NSData *)data
{
    NSMutableData * body = [[NSMutableData alloc] init];
      
    NSLog(@"%d",[arrNsImages count]);
    for (int k=0; k<[arrNsImages count]; k++) {
        NSLog(@"%d",k);
        NSString *postStr=[NSString stringWithFormat:@"image="];
        
        NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userfile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:postStr] dataUsingEncoding:NSUTF8StringEncoding]];  // message
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        if([arrNsImages count]-2==k && appDel.bolLetter){
//            [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.pdf\"\r\n",[NSString stringWithFormat:@"fileatt%d",k+1],[NSString stringWithFormat:@"%d",k+1]]] dataUsingEncoding:NSUTF8StringEncoding]];
//            
//            
//            [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//            
//            [body appendData:[NSData dataWithData:[arrNsImages objectAtIndex:k]]];  
            
            
            [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.pdf\"\r\n",[NSString stringWithFormat:@"pdfattach"],[NSString stringWithFormat:@"Letter"]]] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:[arrNsImages objectAtIndex:k]]]; 
            
            
        }
        if([arrNsImages count]-1==k){
            [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.pdf\"\r\n",[NSString stringWithFormat:@"emailattach"],[NSString stringWithFormat:@"Order Info"]]] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:[arrNsImages objectAtIndex:k]]]; 
            
        }
        else if(appDel.bolPhoto){
        [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n",[NSString stringWithFormat:@"fileatt%d",k+1],[NSString stringWithFormat:@"%d",k+1]]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
      
            [body appendData:[NSData dataWithData:[arrNsImages objectAtIndex:k]]];  
        }

        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    [request setHTTPBody:body];
}

    
   
   



#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 


#pragma mark textField
- (void)textFieldDidBeginEditing:(UITextField*)textField
{
    CGRect textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
     activeField = textField;
    if(activeField==tfldNumber){
        prevBtn.enabled=NO;
    }
    else{
        prevBtn.enabled=YES;
    }
    if(activeField==tfldEmail){
        nextBtn.enabled=NO;
    }
    else{
        nextBtn.enabled=YES;
    }
   
    if ([textField isEqual:tfldType])
    {
        
        if (!actionSheetCBrand)
        {
            [tfldType resignFirstResponder];
            [tfldNumber resignFirstResponder];
            [tfldHolder resignFirstResponder];
            [tfldDate resignFirstResponder];
            [tfldCode resignFirstResponder];
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
    return YES;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(actionSheet.tag==1){
	if (buttonIndex == 0)
	{
        [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
        NSOperationQueue  *queue=[[NSOperationQueue alloc] init];
        NSInvocationOperation *operation=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(showAlertMethd) object:nil];
        [queue addOperation:operation];
        [operation release];
       [self authorize];
    
    }
    }
    else{
        
    }
}
-(void)dismissActionSheet
{
    if (actionSheetCBrand)
    {
        if ([tfldType.text isEqualToString:@""])
        {
            tfldType.text=[NSString stringWithFormat:@"%@",[arrCardType objectAtIndex:0]];
        }       
    }
     [tfldEmail becomeFirstResponder];
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
        NSString *a =  [arrCardType objectAtIndex:row];
        tfldType.text= [NSString stringWithFormat:@"%@",a];
       
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if(pickerView == pickerViewCBrand)
    {
        if (component==0)
        {
            return [arrCardType count];
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
            return [arrCardType objectAtIndex:row];
        }
    }
    return 0;
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
}


@end
