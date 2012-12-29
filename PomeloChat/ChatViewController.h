//
//  ChatViewController.h
//  PomeloChat
//
//  Created by Johnny on 12-12-27.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pomelo.h"

@interface ChatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *chatTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) NSString *target;

@property (weak, nonatomic) Pomelo *pomelo;

@end
