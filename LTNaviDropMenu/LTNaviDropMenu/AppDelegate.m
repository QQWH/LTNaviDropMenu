//
//  AppDelegate.m
//  LTNaviDropMenu
//
//  Created by liangtong on 16/3/17.
//  Copyright © 2016年 com.personal.liangtong. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //NavigationBar 字体颜色
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:59/255.0 green:145/255.0 blue:233/255.0 alpha:1]];
    
    
    /**
     *  如果程序被完全干掉，锁屏状态下通过滑动消息，或者通过通知中心点击消息启动程序，会调用这个接口。
     *  你可以通过在这里进行拦截（拦截本地通知也是这里）。。
     *  关于推送部分，因为比较常用，建议你那边自己封装下。。
     **/
    
    //本地推送
    UILocalNotification * localNotify = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotify)
    {
        if (localNotify.userInfo) {
            //可以在这里处理本地通知相关的逻辑
        }
    }
    
    //通过点击通知栏信息启动时
    if(launchOptions != nil) {
        NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if(userInfo){
            //可以在这里处理远程推送的逻辑
        }
    }
    return YES;
}


/**
 *  以下两个方法，是在程序处于激活状态，
 *  或者后台运行的情况下，通过滑动，或者通知中心的时候会调用
 *  只会调用一个，自己根据需求选使用哪一个
 **/

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0){
    //没啥特别注意的
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    //最低版本iOS8 ，支持后台获取。。即受到推送后，如果需要访问网络获取准备数据，可以使用这个

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
