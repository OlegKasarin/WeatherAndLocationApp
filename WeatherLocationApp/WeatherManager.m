//
//  WeatherManager.m
//  WeatherLocationApp
//
//  Created by apple on 20.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "WeatherManager.h"

NSString* const CLCurrentTempAndWeatherDidChangeNotification = @"CLCurrentTempAndWeatherDidChangeNotification";


@implementation WeatherManager

+ (instancetype)sharedInstance
{
    static WeatherManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[WeatherManager alloc] init];
    });
    return sharedInstance;
}

- (void) getWeatherForCity: (NSString*) city {
    NSString* urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=5355f3f23a618d52ef3c69a58fa5a590", city];
    [self getWeatherByURL:urlString];
}


#pragma mark - gettingWeatherMethods

- (void) getWeatherByURL: (NSString*) urlString {
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    //getDataURL
    NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [self formDataFromDictionary: [self parsingJSONFromDataToDictionary:data]]; //forming properties from JSON data
        
        NSLog(@"Temperature: %f, Weather: %@", self.temperature, self.weatherDescription);
    }];
    
    [task resume];
}

-(NSDictionary*)parsingJSONFromDataToDictionary: (NSData*) responseData {
    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError* error = nil;
    NSData* jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    return jsonDict;
}

-(void) formDataFromDictionary: (NSDictionary*) dictionary {
    
    self.temperature = [[[dictionary objectForKey:@"main"] objectForKey:@"temp"] doubleValue];
    self.temperature-= 273.15;
    
    self.weatherDescription = [NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CLCurrentTempAndWeatherDidChangeNotification object:nil];
}

@end
