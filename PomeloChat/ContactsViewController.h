//
//  ContactsViewController.h
//  PomeloChat
//
//  Created by Johnny on 12-12-27.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pomelo.h"

@interface ContactsViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *contactList;
@property (weak, nonatomic) Pomelo *pomelo;

@end
