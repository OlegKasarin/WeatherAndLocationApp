//
//  WeatherForCurrentLocation.h
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherForCurrentLocation : NSObject

@property (nonatomic) NSString* location;

-(NSString*) currentCoordinatesString;

- (void) getWeatherForCity: (NSString*) city;

@end
