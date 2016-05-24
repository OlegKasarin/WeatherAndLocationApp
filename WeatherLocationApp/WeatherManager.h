//
//  WeatherManager.h
//  WeatherLocationApp
//
//  Created by apple on 20.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "HistoryManager.h"

extern NSString* const CLCurrentTempAndWeatherDidChangeNotification;


@interface WeatherManager : NSObject

@property (assign, nonatomic) double temperature;
@property (strong, nonatomic) NSString* weatherDescription;

+ (instancetype)sharedInstance;
- (void) getWeatherForCity: (NSString*) city;

@end

