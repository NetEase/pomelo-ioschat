//
//  AppDelegate.h
//  PomeloChat
//
//  Created by Johnny on 12-12-11.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pomelo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, PomeloDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) Pomelo *pomelo;

@end
