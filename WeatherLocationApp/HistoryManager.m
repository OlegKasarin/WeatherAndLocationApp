//
//  HistoryManager.m
//  WeatherLocationApp
//
//  Created by apple on 21.05.16.
//  Copyright © 2016 OlegKasarin. All rights reserved.
//

#import "HistoryManager.h"

@implementation HistoryManager

+ (HistoryManager*) sharedInstance {
    
    static HistoryManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //
        sharedInstance = [[HistoryManager alloc] init];
        sharedInstance.itemObjects = [sharedInstance objectFromDisk];
    });
    return sharedInstance;
}


- (NSMutableArray*)objectFromDisk {
    
    NSString* directoryPath = [self directoryPath];
    
    NSArray* fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:NULL];
    
    NSMutableArray* objectsArray = [NSMutableArray array];
    
    for (NSString* fileName in fileList) {
        
        NSData* data = [NSData dataWithContentsOfFile:[[self directoryPath] stringByAppendingPathComponent:fileName]];
        NSArray* currentObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [objectsArray addObject:currentObject];
        
    }

    return objectsArray;
}


- (void)addObject: (ItemObject*) itemObject {
    
    [self.itemObjects addObject:itemObject];
    
    NSString* fileName = @([[NSDate date] timeIntervalSince1970]).stringValue; //unique id
    NSString* filePath = [[self directoryPath] stringByAppendingPathComponent:fileName]; //full address
    
    [NSKeyedArchiver archiveRootObject:itemObject toFile:filePath];
    
}

- (NSString*)directoryPath {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = [paths objectAtIndex:0];
    documentsDirectoryPath = [documentsDirectoryPath stringByAppendingPathComponent:@"objects"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return documentsDirectoryPath;
}

@end
