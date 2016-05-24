//
//  ItemObject.m
//  WeatherLocationApp
//
//  Created by apple on 21.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "ItemObject.h"

@implementation ItemObject

- (instancetype)initWithLocation: (CLLocation*) location City: (NSString*) city Address: (NSString*) address Temperature: (float) temperature WeatherDescription: (NSString*) weatherDescription andDate: (NSString*) date
{
    self = [super init];
    if (self) {
        self.location = location;
        self.city = city;
        self.address = address;
        self.temperature = temperature;
        self.weatherDescription = weatherDescription;
        self.date = date;
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.location = [decoder decodeObjectForKey:@"location"];
    self.city = [decoder decodeObjectForKey:@"city"];
    self.address = [decoder decodeObjectForKey:@"address"];
    self.temperature = [decoder decodeFloatForKey:@"temperature"];
    self.weatherDescription = [decoder decodeObjectForKey:@"weatherDescription"];
    self.date = [decoder decodeObjectForKey:@"date"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeFloat:self.temperature forKey:@"temperature"];
    [encoder encodeObject:self.weatherDescription forKey:@"weatherDescription"];
    [encoder encodeObject:self.date forKey:@"date"];
    
}

@end
