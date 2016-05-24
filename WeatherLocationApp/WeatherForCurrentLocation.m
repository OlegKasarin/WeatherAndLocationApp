//
//  WeatherForCurrentLocation.m
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "WeatherForCurrentLocation.h"

@implementation WeatherForCurrentLocation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coordinates = 0;
        _location = @"Location";
    }
    return self;
}

-(NSString*) currentCoordinatesString {
    return [NSString stringWithFormat:@"You are at: %@", self.coordinates];
}

@end
