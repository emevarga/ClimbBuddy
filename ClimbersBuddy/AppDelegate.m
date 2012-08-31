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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
