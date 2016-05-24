//
//  ItemObject.h
//  WeatherLocationApp
//
//  Created by apple on 21.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@interface ItemObject : NSObject <NSCoding>

@property (strong, nonatomic) CLLocation* location;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* address;
@property (assign, nonatomic) float temperature;
@property (strong, nonatomic) NSString* weatherDescription;
@property (strong, nonatomic) NSString* date;
 
- (instancetype)initWithLocation: (CLLocation*) location City: (NSString*) city Address: (NSString*) address Temperature: (float) temperature WeatherDescription: (NSString*) weatherDescription andDate: (NSString*) date;

@end
