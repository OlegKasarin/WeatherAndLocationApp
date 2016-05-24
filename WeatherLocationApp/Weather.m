//
//  Weather.m
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (Weather*)initWeatherWithCity: (NSString*) city
{
    self = [super init];
    if (self) {
        [self getWeatherForCity:city];
    }
    return self;
}

- (Weather*)initWeatherWithCoordinates: (CLLocationCoordinate2D) coordinates
{
    self = [super init];
    if (self) {
        [self getWeatherForLocation:coordinates];
    }
    return self;
}

- (void) getWeatherForCity: (NSString*) city {
    
    NSString* urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=5355f3f23a618d52ef3c69a58fa5a590", city];
    
    [self getWeatherByURL:urlString];
}

- (void) getWeatherForLocation: (CLLocationCoordinate2D) coordinates {
    
    NSString* urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=5355f3f23a618d52ef3c69a58fa5a590", coordinates.latitude, coordinates.longitude];
    
    [self getWeatherByURL:urlString];
}

#pragma mark - hidden

- (void) getWeatherByURL: (NSString*) urlString {
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //NSLog(@"dataTaskWIthURL >>> %@", data);
        
        [self formDataFromDictionary: [self parsingJSONFromDataToDictionary:data]]; //forming properties from JSON data
        
    }];
    
    [task resume];
}

-(NSDictionary*)parsingJSONFromDataToDictionary: (NSData*) responseData {
    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSData* jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    //NSLog(@"%@", jsonDict);
    return jsonDict;
}

-(void) formDataFromDictionary: (NSDictionary*) dictionary {
    //NSLog(@"formData starting: ");

    //coordinates
    double latitude = [[[dictionary objectForKey:@"coord"] objectForKey:@"lat"] doubleValue];
    double longtitude = [[[dictionary objectForKey:@"coord"] objectForKey:@"lon"] doubleValue];
    //NSLog(@"latitude: %.2f, longtitude: %.2f", latitude, longtitude);

    self.coordinates = CLLocationCoordinate2DMake(latitude, longtitude);
    
    //temp
    self.temperature = [[[dictionary objectForKey:@"main"] objectForKey:@"temp"] doubleValue];

    //description
    
    self.weatherDescription = [NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"]];
    
    //city name
    self.city = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"name"]];
}

@end
