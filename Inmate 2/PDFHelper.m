//
//  PDFHelper.m
//  PDFDemo
//
//  Created by Friendlydeveloper on 29.07.11.
//  Copyright 2011 www.codingsessions.com. All rights reserved.
//

#import "PDFHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "testmapAppDelegate.h"
#define LEFT_MARGIN 25
#define RIGHT_MARGIN 25
#define TOP_MARGIN 35
#define BOTTOM_MARGIN 50
#define BOTTOM_FOOTER_MARGIN 32
#define DOC_WIDTH 595
#define DOC_HEIGHT 842

@implementation PDFHelper
@synthesize textArray;
@synthesize invisibleTextView;

- (void)createPDF:(NSString *)fileName withContent:(NSString *)content forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password {
    
    //create our invisibleTextView
    testmapAppDelegate *appdel;
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication] delegate];
   
    NSString *strUName;
    strUName=[[appdel.dataInmate valueForKey:@"UserName"] stringByAppendingString:@" "];
    strUName=[strUName stringByAppendingString:[appdel.dataInmate valueForKey:@"ULastName"]];
    NSString *strUadd=[appdel.dataInmate valueForKey:@"UserAdd"];
	NSString *strCSZ=[NSString stringWithFormat:@"%@,%@-%@",[appdel.dataInmate valueForKey:@"UserCity"],[appdel.dataInmate valueForKey:@"UserState"],[appdel.dataInmate valueForKey:@"UserZip"] ];
	
    
    NSString *strIName;
    strIName=[[appdel.dataInmate valueForKey:@"InName"] stringByAppendingString:@" "];
    strIName=[strIName stringByAppendingString:[appdel.dataInmate valueForKey:@"ILastName"]];
    NSString *strIadd=[appdel.dataInmate valueForKey:@"iid"];
	NSString *strId=[appdel.dataInmate valueForKey:@"InAdd"];
	NSString *strICSZ=[NSString stringWithFormat:@"%@,%@-%@",[appdel.dataInmate valueForKey:@"InCity"],[appdel.dataInmate valueForKey:@"InState"],[appdel.dataInmate valueForKey:@"InZip"] ];
    invisibleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    textArray = [[NSMutableArray alloc] init];
    if(appdel.bolLetterFormat){
    NSString *tab=@"\t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t";
    
    NSString *lesstab=@"\t \t \t \t \t \t \t \t \t \t \t \t \t \t";
    
    if([appdel.appFontName isEqualToString:@"Courier"] ){
        content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@ \n \n \t \t  %@ \n \n \t \t  %@ \n \n%@,\n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,lesstab,strIName,lesstab,strId,lesstab,strIadd,lesstab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
        
    }
   
    else if([appdel.appFontName isEqualToString:@"Zapfino"]){
        NSString *tooLessTabs=@"\t \t \t \t \t \t \t \t \t \t \t \t ";
        content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@ \n \n \t \t \t \t %@ \n \n \t \t \t \t %@ \n \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tooLessTabs,strIName,tooLessTabs,strId,tooLessTabs,strIadd,tooLessTabs,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
    }
    else if([appdel.appFontName isEqualToString:@"Arial"] ){
    content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@  \n \n \t \t \t \t %@ \n \n \t \t \t \t %@ \n \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tab,strIName,tab,strId,tab,strIadd,tab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
    }
    else{
        if( [appdel.appFontName isEqualToString:@"DB LCD Temp"] ){
            NSString *tab=@"\t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t";
            
            content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@  \n \n \t \t \t \t %@ \n \n%@, \n \n  \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tab,strIName,tab,strId,tab,strIadd,tab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
            NSLog(@"!!!!!!!!!!!! %@",content);
            
        }
       else if([appdel.appFontName isEqualToString:@"Marker Felt"]  ){
        NSString *tab=@"\t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t";
        
        content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@ \n \n \t \t \t \t %@\n \n \t \t \t \t %@ \n \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tab,strIName,tab,strId,tab,strIadd,tab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
        }
       else if([appdel.appFontName isEqualToString:@"Verdana"] ){
           NSString *tab=@"\t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t";
           
           content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@ \n \n \t \t \t \t %@ \n \n \t \t \t \t %@ \n \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tab,strIName,tab,strId,tab,strIadd,tab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
       }
       else if(  [appdel.appFontName isEqualToString:@"Times New Roman"]){
           NSString *tab=@"\t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t";
           
           content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n %@ \n \n \t \t \t \t %@ \n \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tab,strIName,tab,strId,tab,strIadd,tab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
       }
        else{
            content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@ \n %@ %@ \n %@ %@  \n %@ %@ \n %@ %@ \n  %@ \n \n \t \t \t \t%@ \n \n \t \t \t \t %@ \n \n%@, \n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,tab,strIName,tab,strId,tab,strIadd,tab,strICSZ,appdel.appTxtDear,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
        }
    }
    }
    else{
         NSString *lesstab=@"\t \t \t ";
        content=[NSString stringWithFormat:@"%@\n%@\n%@\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n%@     %@\n\n\t\t\t\t\t\t\t%@\n\n%@,\n%@" ,strUName,strUadd,strCSZ,appdel.appTxtDate,strIName,strId,strIadd,strICSZ,appdel.appTxtDear,lesstab,appdel.appSubject,content,appdel.appSalutation,appdel.appTxtSign];
    }
    [textArray setArray:[content componentsSeparatedByString:@" "]];
   // NSLog(@"cont%@",content);
    [invisibleTextView setText:content];
    
    
	CGContextRef pdfContext;
	CFStringRef path;
	CFURLRef url;
	CFStringRef passwordString = (CFStringRef)password;
	CGRect pageRect = CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT);
	CFMutableDictionaryRef myDictionary = NULL;
	const char *filename = [fileName UTF8String];
	// Create a CFString from the filename we provide to this method when we call it
	path = CFStringCreateWithCString (NULL, filename,
									  kCFStringEncodingUTF8);
	// Create a CFURL using the CFString we just defined
	url = CFURLCreateWithFileSystemPath (NULL, path,
										 kCFURLPOSIXPathStyle, 0);
	//CFRelease (path);
	// This dictionary contains extra options mostly for 'signing' the PDF
	myDictionary = CFDictionaryCreateMutable(NULL, 0,
											 &kCFTypeDictionaryKeyCallBacks,
											 &kCFTypeDictionaryValueCallBacks);
	CFDictionarySetValue(myDictionary, kCGPDFContextTitle, (CFStringRef)fileName);
	CFDictionarySetValue(myDictionary, kCGPDFContextCreator, (CFStringRef)fileName);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, passwordString);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword, passwordString);
	//if (![password isEqualToString:@""]) CFDictionarySetValue(myDictionary, kCGPDFContextEncryptionKeyLength, (CFStringRef)"128");
	//if (allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanTrue);
	if (!allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanFalse);
	//if (allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
	if (!allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanFalse);
	
	
	// Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
	pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
	// Cleanup our mess
	CFRelease(myDictionary);
	CFRelease(url);
	//CFRelease(passwordString);
	
	//CFRange currentRange = CFRangeMake(0, 0);
	int i=0;
	do {
        
		CGContextBeginPage (pdfContext, &pageRect);
		
		CGRect bounds = CGRectMake(LEFT_MARGIN, 
								   TOP_MARGIN, 
								   DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN, 
								   DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
		
		UIGraphicsPushContext(pdfContext);
		CGContextSaveGState(pdfContext);
		CGContextTranslateCTM(pdfContext, 0, bounds.origin.y); 
		CGContextScaleCTM(pdfContext, 1, -1); 
		CGContextTranslateCTM(pdfContext, 0, -(bounds.origin.y + bounds.size.height)); 
		if ([invisibleTextView.text length] > 0) [[self stringToDraw:font fontSize:fontSize] drawInRect:bounds withFont:[UIFont fontWithName:font size:fontSize]];
		CGContextRestoreGState(pdfContext);
        i++;
		UIGraphicsPopContext();
		
		CGContextEndPage (pdfContext);
	}
   
	while (!done);
    appdel.noOfPages=i;
	// NSLog(@"Helper No of pages %d", appdel.noOfPages);
	// We are done with our context now, so we release it
	CGContextRelease (pdfContext);
	CFRelease(path);
    
    
}

- (NSString *)stringToDraw:(NSString *)font fontSize:(int)fontSize {
	CGSize tempSize;
    CGSize theTextSize;
    tempSize.width = DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN;
    tempSize.height = 10000000;//DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN;
	
    theTextSize = [invisibleTextView.text sizeWithFont: [UIFont fontWithName:font size:fontSize] constrainedToSize: tempSize]; 
	
	//NSLog(@"size.width:%f, size.height:%f", theTextSize.width, theTextSize.height);
	
	if (theTextSize.height > DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN) {
		//NSLog(@"Text exceeds bounds");
		BOOL match = NO;
		int wordCount = 0;
		float currentHeight = 0.0f;
		float previousHeight = 0.0f;
		NSString *returnString = [[[NSString alloc] init]autorelease];
		NSString *tempReturnString = [[[NSString alloc] init]autorelease];
		
		do {
			if ([textArray count] > wordCount + 1) {
				returnString = (wordCount > 0) ? [returnString stringByAppendingString:[NSString stringWithFormat:@" %@", [textArray objectAtIndex:wordCount]]] : [NSString stringWithFormat:@"%@", [textArray objectAtIndex:wordCount]];
				theTextSize = [returnString sizeWithFont: [UIFont fontWithName:font size:fontSize] constrainedToSize: CGSizeMake(DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN, DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN)];
				//NSLog(@"Currentsize.width:%f, Currentsize.height:%f", theTextSize.width, theTextSize.height);
				currentHeight = theTextSize.height;
				
				if (theTextSize.height >= DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN) {
					match = YES;
					//NSLog(@"MATCH");
				}
				
				if (currentHeight == previousHeight && currentHeight > 700.0f) { //sometimes the above is not accurate and the height is shorter than we think (because of large fonts)
					//NSLog(@"FIXMATCH");
					match = YES;
					wordCount --;
					returnString = tempReturnString;
				}
				wordCount ++;
			}
			else {
				match = YES;
			}
			previousHeight = theTextSize.height;
			tempReturnString = returnString;
		}
		while (!match);
		
		for (int i = 0; i < wordCount; i++) {
			[textArray removeObjectAtIndex:0];
		}
		
		if ([textArray count]) {
			invisibleTextView.text = [textArray componentsJoinedByString:@" "];
		}
		else {
			invisibleTextView.text = @"";
			done = YES;
		}
		
		if ([returnString length] == 0) returnString = @" ";
		
		return returnString;
	}
	else {
		done = YES;
		return invisibleTextView.text;
	}
	
	return invisibleTextView.text;
}
- (void)createPDF1:(NSString *)fileName withContent:(NSString *)content forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password {
    
    //create our invisibleTextView
    testmapAppDelegate *appdel;
    appdel=(testmapAppDelegate *)[[UIApplication sharedApplication] delegate];
    invisibleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    textArray = [[NSMutableArray alloc] init];
    float moneyOrderAmt;
    int photos,leter;
    if(!appdel.bolMoney){
        moneyOrderAmt=0.0f;
    }
    else{
        moneyOrderAmt=appdel.moneyorderAmt;
    }
    if(!appdel.bolPhoto){
        photos=0;
    }
    else{
        photos=appdel.noOfPhotos;
    }
    if(!appdel.bolLetter){
        leter=0;
    }
    else{
        leter=appdel.noOfPages;
    }
    content=[NSString stringWithFormat:@"\t \t Inmates Mailing Info \n \n First Name: %@\n Last Name: %@ \n Inmate ID: %@ \n Bed Assignment: %@ \n Institution Name: %@ \n Institution Address: %@ \n City: %@ \n State: %@ \n Zip Code: %@ \n \n \n \t \t Sender's info \n \n First Name: %@ \n Last Name: %@ \n Street Address: %@ \n City: %@ \n State: %@ \n Zip Code:%@ \n Email: %@ \n \n  \t \t Order's Info \n \n Letter: %d  \n No of Photos: %d \n Money Order Amount: %.2f" ,[appdel.dataInmate valueForKey:@"InName"],[appdel.dataInmate valueForKey:@"ILastName"],[appdel.dataInmate valueForKey:@"iid"],[appdel.dataInmate valueForKey:@"bed"],[appdel.dataInmate valueForKey:@"IInstName"],[appdel.dataInmate valueForKey:@"InAdd"],[appdel.dataInmate valueForKey:@"InCity"],[appdel.dataInmate valueForKey:@"InState"],[appdel.dataInmate valueForKey:@"InZip"],[appdel.dataInmate valueForKey:@"UserName"],[appdel.dataInmate valueForKey:@"ULastName"],[appdel.dataInmate valueForKey:@"UserAdd"],[appdel.dataInmate valueForKey:@"UserCity"],[appdel.dataInmate valueForKey:@"UserState"],[appdel.dataInmate valueForKey:@"UserZip"],[appdel.dataInmate valueForKey:@"Email"],leter,photos,moneyOrderAmt];
   
  
    
    [textArray setArray:[content componentsSeparatedByString:@" "]];
    // NSLog(@"cont%@",content);
    [invisibleTextView setText:content];
        
	CGContextRef pdfContext;
	CFStringRef path;
	CFURLRef url;
	CFStringRef passwordString = (CFStringRef)password;
	CGRect pageRect = CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT);
	CFMutableDictionaryRef myDictionary = NULL;
	const char *filename = [fileName UTF8String];
	// Create a CFString from the filename we provide to this method when we call it
	path = CFStringCreateWithCString (NULL, filename,
									  kCFStringEncodingUTF8);
	// Create a CFURL using the CFString we just defined
	url = CFURLCreateWithFileSystemPath (NULL, path,
										 kCFURLPOSIXPathStyle, 0);
	//CFRelease (path);
	// This dictionary contains extra options mostly for 'signing' the PDF
	myDictionary = CFDictionaryCreateMutable(NULL, 0,
											 &kCFTypeDictionaryKeyCallBacks,
											 &kCFTypeDictionaryValueCallBacks);
	CFDictionarySetValue(myDictionary, kCGPDFContextTitle, (CFStringRef)fileName);
	CFDictionarySetValue(myDictionary, kCGPDFContextCreator, (CFStringRef)fileName);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, passwordString);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword, passwordString);
	//if (![password isEqualToString:@""]) CFDictionarySetValue(myDictionary, kCGPDFContextEncryptionKeyLength, (CFStringRef)"128");
	//if (allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanTrue);
	if (!allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanFalse);
	//if (allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
	if (!allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanFalse);
	
	
	// Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
	pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
	// Cleanup our mess
	CFRelease(myDictionary);
	CFRelease(url);
	//CFRelease(passwordString);
	
	//CFRange currentRange = CFRangeMake(0, 0);
	int i=0;
	do {
        
		CGContextBeginPage (pdfContext, &pageRect);
		
		CGRect bounds = CGRectMake(LEFT_MARGIN, 
								   TOP_MARGIN, 
								   DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN, 
								   DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
		
		UIGraphicsPushContext(pdfContext);
		CGContextSaveGState(pdfContext);
		CGContextTranslateCTM(pdfContext, 0, bounds.origin.y); 
		CGContextScaleCTM(pdfContext, 1, -1); 
		CGContextTranslateCTM(pdfContext, 0, -(bounds.origin.y + bounds.size.height)); 
		if ([invisibleTextView.text length] > 0){ 
            [[self stringToDraw:font fontSize:fontSize] drawInRect:bounds withFont:[UIFont fontWithName:font size:fontSize]];
        }
		CGContextRestoreGState(pdfContext);
        i++;
		UIGraphicsPopContext();
		
		CGContextEndPage (pdfContext);
	}
    
	while (!done);
    
	// NSLog(@"Helper No of pages %d", appdel.noOfPages);
	// We are done with our context now, so we release it
	CGContextRelease (pdfContext);
	CFRelease(path);
    
    
}

- (void)dealloc {
    [invisibleTextView release];
    [textArray release];
    [super dealloc];
}

@end
