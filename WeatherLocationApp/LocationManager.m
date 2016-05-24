//
//  LocationManager.m
//  WeatherLocationApp
//
//  Created by apple on 20.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "LocationManager.h"
#import "WeatherManager.h"

NSString* const CLCurrentLocationDidChangeNotification = @"CLCurrentLocationDidChangeNotification";


@implementation LocationManager


#pragma mark - InitializationSingletone

+ (instancetype)sharedInstance
{
    static LocationManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
        
        sharedInstance.locationManager = [[CLLocationManager alloc] init];
        sharedInstance.locationManager.delegate = sharedInstance;
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([sharedInstance.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [sharedInstance.locationManager requestWhenInUseAuthorization];
        }
        
        [sharedInstance.locationManager startUpdatingLocation];
        
    });
    return sharedInstance;
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    self.currentLocation = [locations lastObject];
    
    CLGeocoder* geo = [[CLGeocoder alloc]init];
    
    [geo reverseGeocodeLocation: self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error)) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
             /*
             NSLog(@"addressFull %@", placemark.addressDictionary);
             NSLog(@"Locality: %@",placemark.locality);
             NSLog(@"Country: %@",placemark.country);
             NSLog(@"Name: %@",placemark.name);
             NSLog(@"PostalCode: %@",placemark.postalCode);
             NSLog(@"Location: %@",placemark.location);
             */
             
             self.currentCity = placemark.locality;
             self.currentAddress = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSLog(@"City is %@", self.currentCity);
             
         } else {
             NSLog(@"reverseGeocodeLocation failed: %@", error);
         }
         
         [[NSNotificationCenter defaultCenter] postNotificationName:CLCurrentLocationDidChangeNotification object:nil];
         
         [[WeatherManager sharedInstance] getWeatherForCity: self.currentCity];
     }];
    
    [manager stopUpdatingLocation];
}


#pragma mark - currentLocationString

-(NSString*) currentLocationString {
    
    NSString* currentLocString = [NSString stringWithFormat:@"You are at:  %f   %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
    
    return currentLocString;
}


@end
