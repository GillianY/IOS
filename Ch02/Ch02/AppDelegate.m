//
//  AppDelegate.m
//  Ch02
//
//  Created by ucom Apple Instructor on 2016/11/25.
//  Copyright © 2016年 ucom Apple Instructor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"didFinishLaunchingWithOptions - 0");
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"INIT" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive - 2");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   NSLog(@"applicationDidEnterBackground - 3");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   NSLog(@"applicationWillEnterForeground - 4");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive - 1");
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyyMMdd";
    NSString * today = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",today);
    
    NSUserDefaults * nud = [NSUserDefaults standardUserDefaults];
    NSString * setting = [nud objectForKey:@"LAUNCHDATE"];
    //Case1
//    if (setting == nil){
//        [nud setObject:today forKey:@"LAUNCHDATE"];
//        [nud synchronize];
//        NSLog(@"FIRST RUN (Today)");
//    }else if(![setting isEqualToString:today]){
//        [nud setObject:today forKey:@"LAUNCHDATE"];
//        [nud synchronize];
//        NSLog(@"Today FIRST RUN");
//    }
    
    //Case2
    BOOL isUpdate = YES;
    if (setting == nil){
        NSLog(@"FIRST RUN (Today)");
    }else if(![setting isEqualToString:today]){
        NSLog(@"Today FIRST RUN");
    }else{
        isUpdate = NO;
    }
    if (isUpdate){
        [nud setObject:today forKey:@"LAUNCHDATE"];
        [nud synchronize];
    }
    
    //Case3
//    if (setting == nil || ![setting isEqualToString:today]){
//        [nud setObject:today forKey:@"LAUNCHDATE"];
//        [nud synchronize];
//        NSLog(@"Today FIRST RUN");
//    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate - 5");
}

@end
