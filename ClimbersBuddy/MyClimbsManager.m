//
//  MyClimbsManager.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 9/13/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "MyClimbsManager.h"
#import "ClimbInfo.h"
#import "CommonDefines.h"

static NSMutableArray *__myClimbs = nil;

@interface MyClimbsManager (Helper)
+(NSMutableArray *)getMyClimbs;
+(NSMutableArray *)loadMyClimbs;
+(NSString *)getDocumentsDirectory;
+(ClimbInfo *)climbForPath:(NSString *)path;
@end

@implementation MyClimbsManager

+(NSArray *)myClimbs{
    if(!__myClimbs){
        [[self class] loadMyClimbs];
    }
    return [NSArray arrayWithArray:__myClimbs];
}

+(NSMutableArray *)getMyClimbs{
    if(!__myClimbs){
        [[self class]loadMyClimbs];
    }
    return __myClimbs;
}

+(BOOL)myClimbsContains:(ClimbInfo *)climb{
    NSMutableArray *myClimbs = [[self class]getMyClimbs];
    for(ClimbInfo *aClimb in myClimbs){
        if([aClimb.name isEqualToString:climb.name] && [aClimb.locationName isEqualToString:climb.locationName] && [aClimb.wallName isEqualToString:climb.wallName]){
            return YES;
        }
    }
    return NO;
}

+(void)addClimb:(ClimbInfo *)climb{
    NSMutableArray *myClimbs = [[self class]getMyClimbs];
    if(![myClimbs containsObject:climb]){
        [myClimbs addObject:climb];
    }
    NSString *filePath = [[self class] getDocumentsDirectory];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.climb",climb.name,climb.wallName]];
    NSError *error;
    if(![[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error]){
        NSLog(@"Error savingToMyClimbs: %@",[error localizedDescription]);
        return;
    }
    filePath = [filePath stringByAppendingPathComponent:DATA_FILE];
    NSMutableData *climbData = [[NSMutableData alloc]init];
    NSKeyedArchiver *writer = [[NSKeyedArchiver alloc]initForWritingWithMutableData:climbData];
    [writer encodeObject:climb forKey:DATA_KEY];
    [writer finishEncoding];
    [climbData writeToFile:filePath atomically:YES];
}

+(NSString *)getDocumentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"MyClimbs"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    return documentsDirectory;
}

+(ClimbInfo *)climbForPath:(NSString *)path{
    path = [path stringByAppendingPathComponent:DATA_FILE];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSKeyedUnarchiver *reader = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    ClimbInfo *climb = [reader decodeObjectForKey:DATA_KEY];
    return climb;
}

+(NSMutableArray *)loadMyClimbs{
    __myClimbs = [[NSMutableArray alloc]initWithCapacity:5];
    NSString *dataDirectory = [[self class]getDocumentsDirectory];
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:dataDirectory error:&error];
    for(NSString *file in files){
        NSString *fullPath = [dataDirectory stringByAppendingPathComponent
                              :file];
        ClimbInfo *climb = [[self class] climbForPath:fullPath];
        if(climb){
            [__myClimbs addObject:climb];
        }
    }
    return __myClimbs;
}


@end
