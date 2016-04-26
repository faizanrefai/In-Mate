//
//  PdfController.h
//  Inmate
//
//  Created by girish on 12/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "testmapAppDelegate.h"
#import "PDFService.h"
@interface PdfController : UIViewController <UIWebViewDelegate>{

	IBOutlet UIWebView *webView;
    testmapAppDelegate *appdel;
    IBOutlet UITextField *pdfPasswordTextField;
}
- (IBAction)createPDFFile;
- (IBAction)loadPDFFile;
-(void)CreateContact;
@end
