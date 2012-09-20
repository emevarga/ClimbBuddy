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

@end
