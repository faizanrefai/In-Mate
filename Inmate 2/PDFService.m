//
//  PDFService.m
//  PDF
//
//  Created by Masashi Ono on 09/10/25.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "PDFService.h"
#import "testmapAppDelegate.h"
#import "letterFormat.h"
static PDFService *_instance;
letterFormat *letterformat;
testmapAppDelegate *appdel;
void PDFService_defaultErrorHandler(HPDF_STATUS   error_no,
                                    HPDF_STATUS   detail_no,
                                    void         *user_data)
{
    PDFService_userData *userData = (PDFService_userData *)user_data;
    HPDF_Doc pdf = userData->pdf;
    PDFService *service = userData->service;
    NSString *filePath = userData->filePath;
    
    //  HPDF_ResetError(pdf)
    HPDF_Free(pdf);
    
    if (service.delegate) {
        [service.delegate service:service
         didFailedCreatingPDFFile:filePath
                          errorNo:error_no
                         detailNo:detail_no];
    }
}


@implementation PDFService

@synthesize delegate;

- (id) init
{
    self = [super init];
    if (self != nil) {
        //init code
    }
	
	appdel=(testmapAppDelegate *)[[UIApplication sharedApplication]delegate];
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

+ (PDFService *)instance
{
    if (!_instance) {
        _instance = [[PDFService alloc] init];
    }
    return _instance;
}

- (void)createPDFFile:(NSString *)filePath
{
    appdel.noOfPages=0;
    // Creates a test PDF file to the specified path.
    // TODO: use UIImage to create non-optimized PNG rather than build target setting
    NSString *path = nil;
	const char *pathCString = NULL;
    NSLog(@"hi%@",appdel.dataInmate);
	NSString *strUName=[appdel.dataInmate valueForKey:@"UserName"];
	NSString *strUadd=[appdel.dataInmate valueForKey:@"UserAdd"];
	NSString *strCSZ=[NSString stringWithFormat:@"%@,%@-%@",[appdel.dataInmate valueForKey:@"UserCity"],[appdel.dataInmate valueForKey:@"UserState"],[appdel.dataInmate valueForKey:@"UserZip"] ];
	NSString *strIName=[appdel.dataInmate valueForKey:@"InName"];
	NSString *strIadd=[appdel.dataInmate valueForKey:@"iid"];
	NSString *strId=[appdel.dataInmate valueForKey:@"InAdd"];
	NSString *strICSZ=[NSString stringWithFormat:@"%@,%@-%@",[appdel.dataInmate valueForKey:@"InCity"],[appdel.dataInmate valueForKey:@"InState"],[appdel.dataInmate valueForKey:@"InZip"] ];
	NSLog(@"%d",appdel.appTxtBody.length);
	NSMutableArray *arrbody=[[NSMutableArray alloc]init];
	for(int i=0;i<appdel.appTxtBody.length;i++)
		{
			NSString *theCurChar = [appdel.appTxtBody substringWithRange:NSMakeRange(i,1)];
			
			[arrbody addObject:theCurChar];
			
		}
	NSLog(@"array of body   %d",[arrbody count]);
    //LOG(@"[libharu] PDF Creation START");
    PDFService_userData userData;
    HPDF_Doc pdf = HPDF_New(PDFService_defaultErrorHandler, &userData);
    userData.pdf = pdf;
    userData.service = self;
    userData.filePath = filePath;
    //LOG(@"[libharu] Adding page 1");
    HPDF_Page page1 = HPDF_AddPage(pdf);
	
    //LOG(@"[libharu] SetSize page 1");
    HPDF_Page_SetSize(page1, HPDF_PAGE_SIZE_A4, HPDF_PAGE_LANDSCAPE);
    
	    //LOG(@"[libharu] TextOut page 1");
    HPDF_Page_BeginText(page1);
	
    //HPDF_UseJPFonts (pdf);
    //HPDF_UseJPEncodings (pdf);
    NSString *fontstyle;
    if(appdel.isLetter){
     fontstyle=[NSString stringWithFormat:@"%@",appdel.appFontName];
        NSLog(@"%@",fontstyle);
        
    }
    else{
        fontstyle=[NSString stringWithFormat:@"%@",[appdel.arrLetterDet valueForKey:@"Font"]];
        NSLog(@"%@",fontstyle);
    }
	HPDF_Font fontEn=HPDF_GetFont(pdf, [fontstyle UTF8String], "StandardEncoding");
	//HPDF_Font fontJp = HPDF_GetFont(pdf, "MS-Mincyo", "90ms-RKSJ-H");
    HPDF_Page_SetFontAndSize(page1, fontEn, 20.0);
	appdel.noOfPages++;
	
   // HPDF_Page_TextOut(page1, 50.00, 500.00, "Hello libHaru!");
    //HPDF_Page_SetFontAndSize(page1, fontJp, 16.0);
    HPDF_Page_TextOut(page1, 15.00, 560.00, [strUName cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 15.00, 540.00, [strUadd cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 15.00, 520.00, [strCSZ cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 15.00, 500.00, [appdel.appTxtDate cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 600.00, 480.00, [strIName cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 600.00, 460.00, [strId cStringUsingEncoding:NSShiftJISStringEncoding]);

	HPDF_Page_TextOut(page1, 600.00, 440.00, [strIadd cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 600.00, 420.00, [strICSZ cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 15.00, 380.00, [appdel.appTxtDear cStringUsingEncoding:NSShiftJISStringEncoding]);
	
   // HPDF_Page_TextOut(page1, 70, 40,"Hi how are you whats up hows life going on are you enjoying it properly");
	int j=0,k=0,m=320,s=0 ;
	
   
	
	for(int i=1;i<=[arrbody count];i++){
		
		if(i<=64){
			
           

			HPDF_Page_TextOut(page1, 70.00+j ,360, [[arrbody objectAtIndex:i-1]cStringUsingEncoding:NSShiftJISStringEncoding]);
		 j=j+12;
		}
		else if(i>64 && i<134){
			
			
			HPDF_Page_TextOut(page1, 5.00+k, 340, [[arrbody objectAtIndex:i-1] cStringUsingEncoding:NSShiftJISStringEncoding]);
			k=k+12;
			
		}
		
		else if(i>=134){
			if(s==840){
				
				s=0;
				m=m-20;
				
				if(m==0){
					
					m=560;
					appdel.noOfPages++;
					HPDF_Page page2 = HPDF_AddPage(pdf);
					HPDF_Page_SetSize(page2, HPDF_PAGE_SIZE_A4, HPDF_PAGE_LANDSCAPE);
					HPDF_Page_BeginText(page2);
                   
                   
					HPDF_Page_SetFontAndSize(page2, fontEn, 20.0);
					page1=page2;
					
				}
            }
           
			 if(s==0 && [[arrbody objectAtIndex:i-1] isEqualToString:@" "]){
				
                 NSLog(@"hello");
			}
            
			else{
                
            
               HPDF_Page_TextOut(page1, 5.00+s, m, [[arrbody objectAtIndex:i-1] cStringUsingEncoding:NSShiftJISStringEncoding]);
                s=s+12; 
                
            }
                
        }
			 
	
		
			
}
		
		
		
	
	NSLog(@"%d",m);
			
	
	
	if(m==0){
		HPDF_Page_TextOut(page1, 600.00, 560, [@"Signature" cStringUsingEncoding:NSShiftJISStringEncoding]);
		HPDF_Page_TextOut(page1, 600.00,540, [@"Yours Sincerly" cStringUsingEncoding:NSShiftJISStringEncoding]);
		HPDF_Page_TextOut(page1, 600.00, 520, [appdel.appTxtSign cStringUsingEncoding:NSShiftJISStringEncoding]);
		
	}
	else{
		
		if(m>80){
	HPDF_Page_TextOut(page1, 6000.00, m-30, [@"Signature" cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 600.00,m-50, [@"Yours Sincerly" cStringUsingEncoding:NSShiftJISStringEncoding]);
	HPDF_Page_TextOut(page1, 600.00, m-70, [appdel.appTxtSign cStringUsingEncoding:NSShiftJISStringEncoding]);
	
	}
		else{
			m=560;
            appdel.noOfPages++;
			HPDF_Page pageend = HPDF_AddPage(pdf);
			HPDF_Page_SetSize(pageend, HPDF_PAGE_SIZE_A4, HPDF_PAGE_LANDSCAPE);
			HPDF_Page_BeginText(pageend);
			HPDF_Page_SetFontAndSize(pageend, fontEn, 16.0);
			HPDF_Page_TextOut(pageend, 600.00, m-30, [@"Signature" cStringUsingEncoding:NSShiftJISStringEncoding]);
			HPDF_Page_TextOut(pageend, 600.00,m-50, [@"Yours Sincerly" cStringUsingEncoding:NSShiftJISStringEncoding]);
			HPDF_Page_TextOut(pageend, 6000.00, m-80, [appdel.appTxtSign cStringUsingEncoding:NSShiftJISStringEncoding]);
			HPDF_Page_EndText(pageend);
		}
	}
	
	
	
    HPDF_Page_EndText(page1);
	
		
	
    //LOG(@"[libharu] Path drawing page 1");
    //HPDF_Page_SetLineWidth(page1, 4.0);
//    HPDF_Page_SetRGBStroke(page1, 1.0, 0, 0);
//    HPDF_Page_Rectangle(page1, 200, 200, 40, 150);
//    HPDF_Page_Stroke(page1);
    //LOG(@"[libharu] PNG image drawing page 1");
    // comment out this line intentionally causes an error here to test error handling
//    path = [[NSBundle mainBundle] pathForResource:@"no_such_file_hogehoge"
//                                           ofType:@"png"];
//	path = [[NSBundle mainBundle] pathForResource:@"test"
//                                           ofType:@"png"];
   // pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
    //LOG(@"[libharu] LoadPngImageFromFile path:%@\n pathCString:%s", path, pathCString);
  // HPDF_Image image = HPDF_LoadPngImageFromFile(pdf, pathCString);
   // HPDF_Page_DrawImage(page1, image, 260, 240, 245, 319);
    
    pathCString = [filePath cStringUsingEncoding:1];
    //LOG(@"[libharu] SaveToFile filePath:%@\n pathCString:%s", filePath, pathCString);
    HPDF_SaveToFile(pdf, pathCString);
    //LOG(@"[libharu] Freeing PDF object ");
	
	
	
	//PDFService_userData userData1;
//    HPDF_Doc pdf1 = HPDF_New(PDFService_defaultErrorHandler, &userData1);
//    userData.pdf = pdf1;
//    userData.service= self;
//    userData.filePath = filePath;
//	HPDF_Page page2 = HPDF_AddPage(pdf1);
//    //LOG(@"[libharu] SetSize page 1");
//    HPDF_Page_SetSize(page2, HPDF_PAGE_SIZE_A4, HPDF_PAGE_LANDSCAPE);
//    //LOG(@"[libharu] TextOut page 1");
//    HPDF_Page_BeginText(page2);
//    HPDF_UseJPFonts (pdf1);
//    HPDF_UseJPEncodings (pdf1);
//	HPDF_Font fontEn1=HPDF_GetFont(pdf1, "Helvetica", "StandardEncoding");
//    HPDF_Page_SetFontAndSize(page2, fontEn1, 16.0);
//    HPDF_Page_TextOut(page2, 50.00, 500.00, "Hello libHaru!");
	
	
    if (HPDF_HasDoc(pdf)) {
        HPDF_Free(pdf);
    }
    //LOG(@"[libharu] PDF Creation END");
}

@end
