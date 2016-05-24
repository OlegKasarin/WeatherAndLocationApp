//
//  CurrentLocation.h
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Weather.h"

@interface CurrentLocation : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
//@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) Weather* weather;

-(NSString*) currentLocationString;

@end
