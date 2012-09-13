//
//  AppDelegate.m
//  ClimbersBuddy
//
//  Created by Clark Barry on 8/21/12.
//  Copyright (c) 2012 CSHaus. All rights reserved.
//

#import "AppDelegate.h"
#import "MyClimbsViewController.h"
#import "SearchViewController.h"

@interface AppDelegate (Internal)
-(void)setUpAppearance;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self setUpAppearance];
    
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.tabBarItem.image = [UIImage imageNamed:@"SearchIcon.png"];
    UINavigationController *searchNC = [[UINavigationController alloc]initWithRootViewController:searchVC];
    
    MyClimbsViewController *myClimbsVC = [[MyClimbsViewController alloc]init];
    UINavigationController *myClimbsNC = [[UINavigationController alloc]initWithRootViewController:myClimbsVC];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:@[searchNC,myClimbsNC]];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setUpAppearance{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    UIFont *labelFont = [UIFont systemFontOfSize:5];
    [[UILabel appearance] setFont:labelFont];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //save myclimbs
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //save myclimbs
}



@end
