//
//  FirstViewController.m
//  WeatherLocationApp
//
//  Created by apple on 14.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (strong, nonatomic) LocationManager* locationManager;
@property (strong, nonatomic) WeatherManager* weatherManager;
@property (strong, nonatomic) HistoryManager* historyManager;
@property (strong, nonatomic) ItemObject* itemObject;

@property (weak, nonatomic) IBOutlet UILabel *currentCoordinatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;

@end

@implementation FirstViewController

+ (instancetype)StoryboardInstance {
  
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle] ] instantiateViewControllerWithIdentifier:@"Main"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [LocationManager  sharedInstance];
    self.weatherManager = [WeatherManager sharedInstance];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayInfo) name:CLCurrentLocationDidChangeNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayInfo) name:CLCurrentTempAndWeatherDidChangeNotification object:nil];
    
    if (self.itemObj) {
        
        self.currentCityLabel.text = self.itemObj.address;
        self.currentTempLabel.text = (self.itemObj.temperature < 1) ? @"weather is" :[NSString stringWithFormat:@"%.f°", self.itemObj.temperature];
        self.currentCoordinatesLabel.text = [NSString stringWithFormat:@"%f %f", self.itemObj.location.coordinate.latitude, self.itemObj.location.coordinate.longitude];
        self.currentWeatherLabel.text = ([self.itemObj.weatherDescription  isEqual: @"(null)"]) ? @"not available" : [NSString stringWithFormat:@"%@", self.itemObj.weatherDescription];
    } else {
        self.currentCoordinatesLabel.text = self.currentCityLabel.text = self.currentTempLabel.text = @"";
        self.currentWeatherLabel.text = @"Update you location!";
    }
    

}

- (void) displayInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentCityLabel.text = [[LocationManager  sharedInstance] currentAddress];
        self.currentCoordinatesLabel.text = [[LocationManager  sharedInstance] currentLocationString];
        
        self.currentTempLabel.text = ([[WeatherManager sharedInstance] temperature] == 0) ? @"loading..." : [NSString stringWithFormat:@"%.f°", [[WeatherManager sharedInstance] temperature]];
        self.currentWeatherLabel.text = [[WeatherManager sharedInstance] weatherDescription];
        
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd, yyyy  HH:mm"];
            
        NSString* dateString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
         
        self.itemObject = [[ItemObject alloc] initWithLocation:[[LocationManager sharedInstance] currentLocation]
                                                          City:[[LocationManager sharedInstance] currentCity]
                                                       Address:[[LocationManager sharedInstance] currentAddress]
                                                   Temperature:[[WeatherManager sharedInstance] temperature]
                                            WeatherDescription:[[WeatherManager sharedInstance] weatherDescription]
                                                       andDate:dateString];
        
        [[HistoryManager sharedInstance] addObject:self.itemObject];
        
    });
    
}

- (void)setItemObj: (ItemObject*) itemObj {

    _itemObj = itemObj;
    
    self.currentCityLabel.text = itemObj.address;
    self.currentTempLabel.text = [NSString stringWithFormat:@"%.f", itemObj.temperature];
    self.currentCoordinatesLabel.text = [NSString stringWithFormat:@"%f %f", itemObj.location.coordinate.latitude, itemObj.location.coordinate.longitude];
    self.currentWeatherLabel.text = [NSString stringWithFormat:@"%@", self.itemObj.weatherDescription];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
