//
//  CurrentLocation.m
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "CurrentLocation.h"

@implementation CurrentLocation

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"CurrentLocation is initializing");
    
        
        
        self.weather = [[Weather alloc] initWeatherWithCity:@"Minsk"];
        
        
        [self currentLocationIdentifier];
    
    }
    return self;
}

-(void) currentLocationIdentifier {
    NSLog(@"currentLocationIdentifier");

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];

    [self.locationManager startUpdatingLocation];

}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locationManager didUpdateLocations locations: %@", locations);
    
    //[locations lastObject];
    //CLLocation* currentLocation = [locations objectAtIndex:0];
    self.currentLocation = [locations lastObject];
    
    NSLog(@"lat%f - lon%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);

    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSLog(@"%@",CountryArea);
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             //CountryArea = NULL;
         }
         /*---- For more results
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
          ------*/
     }];
}

-(NSString*) currentLocationString {
    
    NSString* currentLocString = [NSString stringWithFormat:@"You are at: %f %f", self.weather.coordinates.latitude, self.weather.coordinates.longitude];
    
    NSLog(@"%@", currentLocString);
    
    return currentLocString;
}

@end
