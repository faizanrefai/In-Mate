//
//  BatchDetailsType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 12/13/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BatchStatisticType.h"
#import "GDataXMLNode.h"

@interface BatchDetailsType : NSObject {
	NSString *batchId;
	NSString *settlementTimeUTC;
	NSString *settlementTimeLocal;
	NSString *settlementState;
    NSString *paymentMethod;
    NSMutableArray *batchStatistics;
}

@property (nonatomic, retain) NSString *batchId;
@property (nonatomic, retain) NSString *settlementTimeUTC;
@property (nonatomic, retain) NSString *settlementTimeLocal;
@property (nonatomic, retain) NSString *settlementState;
@property (nonatomic, retain) NSString *paymentMethod;
@property (nonatomic, retain) NSMutableArray *batchStatistics;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (BatchDetailsType *) batchDetails;

- (void) addBatchStatistic: (BatchStatisticType *) b;

/**
 * Class method that takes in GDataXMLElement and returns a fully parsed
 * BatchDetailsType.  If the method was not able to parse the response,
 * a nil object is returned.
 * @return The parsed BatchDetailsType from parsing the GDataXMLElement or nil if unable
 * to parse the data.
 */
+ (BatchDetailsType *)buildBatchDetails:(GDataXMLElement *)element;
@end
