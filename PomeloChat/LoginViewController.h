//
//  LoginViewController.h
//  PomeloChat
//
//  Created by Johnny on 12-12-27.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pomelo.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *channelText;

@property (weak, nonatomic) Pomelo *pomelo;

@end
