//
//  AppDelegate.m
//  TabBarTest
//
//  Created by zry on 2016/12/26.
//  Copyright © 2016年 ZRY. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    UITabBarController *tab = [[UITabBarController alloc] init];
    
    FirstViewController *vc1 = [[FirstViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    SecondViewController *vc2 = [[SecondViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    ThirdViewController *vc3 = [[ThirdViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    FourthViewController *vc4 = [[FourthViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    UIImage *img1 = [UIImage imageNamed:@"message"];
    UIImage *imgSelect1 = [UIImage imageNamed:@"message_selected"];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"消息" image:img1 selectedImage:imgSelect1];
    
    UIImage *img2 = [UIImage imageNamed:@"contacts"];
    UIImage *imgSelect2 = [UIImage imageNamed:@"contacts_selected"];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"联系人" image:img2 selectedImage:imgSelect2];
    
    UIImage *img3 = [UIImage imageNamed:@"discover"];
    UIImage *imgSelect3 = [UIImage imageNamed:@"discover_selected"];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"发现" image:img3 selectedImage:imgSelect3];
    
    UIImage *img4 = [UIImage imageNamed:@"me"];
    UIImage *imgSelect4 = [UIImage imageNamed:@"me_selected"];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"我" image:img4 selectedImage:imgSelect4];
    nav1.tabBarItem = item1;
    nav2.tabBarItem = item2;
    nav3.tabBarItem = item3;
    nav4.tabBarItem = item4;
    
    
    [tab setViewControllers:@[nav1,nav2,nav3,nav4]];
    
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
