//
//  Weather.h
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

@interface Weather : NSObject

@property (assign, nonatomic) CLLocationCoordinate2D coordinates;
@property (assign, nonatomic) double temperature;
@property (strong, nonatomic) NSString* weatherDescription;
@property (strong, nonatomic) NSString* city;


- (Weather*)initWeatherWithCity: (NSString*) city;
- (Weather*)initWeatherWithCoordinates: (CLLocationCoordinate2D) coordinates;

- (void) getWeatherForCity: (NSString*) city;
- (void) getWeatherForLocation: (CLLocationCoordinate2D) coordinates;

@end






