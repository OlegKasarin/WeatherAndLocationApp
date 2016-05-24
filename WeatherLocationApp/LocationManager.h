//
//  LocationManager.h
//  WeatherLocationApp
//
//  Created by apple on 20.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

extern NSString* const CLCurrentLocationDidChangeNotification;

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* currentLocation;
@property (strong, nonatomic) NSString* currentAddress;
@property (strong, nonatomic) NSString* currentCity;

+ (instancetype)sharedInstance;

- (NSString*)currentLocationString;

@end
