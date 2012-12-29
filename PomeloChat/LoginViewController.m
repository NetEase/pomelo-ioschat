//
//  LoginViewController.m
//  PomeloChat
//
//  Created by Johnny on 12-12-27.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactsViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) ContactsViewController *contactsViewController;

- (void)entryWithData:(NSDictionary *)data;

@end

@implementation LoginViewController

@synthesize nameText;
@synthesize channelText;
@synthesize contactsViewController;
@synthesize pomelo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // ...
    }
    return self;
}

- (IBAction)login:(id)sender
{
    NSString *name = nameText.text;
    NSString *channel = channelText.text;
    
    if (([name length] > 0) && ([channel length] > 0)) {
        [pomelo connectToHost:@"127.0.0.1" onPort:3014 withCallback:^(Pomelo *p){
            NSDictionary *params = [NSDictionary dictionaryWithObject:name forKey:@"uid"];
            [pomelo requestWithRoute:@"gate.gateHandler.queryEntry" andParams:params andCallback:^(NSDictionary *result){
                [pomelo disconnectWithCallback:^(Pomelo *p){
                    [self entryWithData:result];
                }];
            }];
        }];
    }
    //[self.navigationController pushViewController:self.contactsViewController animated:YES];
}

- (void)entryWithData:(NSDictionary *)data
{
    NSString *host = [data objectForKey:@"host"];
    NSInteger port = [[data objectForKey:@"port"] intValue];
    NSString *name = nameText.text;
    NSString *channel = channelText.text;
    [pomelo connectToHost:host onPort:port withCallback:^(Pomelo *p){
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                name, @"username",
                                channel, @"rid",
                                nil];
        [p requestWithRoute:@"connector.entryHandler.enter" andParams:params andCallback:^(NSDictionary *result){
            NSArray *userList = [result objectForKey:@"users"];
            [self.contactsViewController.contactList addObjectsFromArray:userList];
            [self.contactsViewController.contactList removeObject:name];
            [self.navigationController pushViewController:self.contactsViewController animated:YES]; 
        }];
    }];
}

- (IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Login";
    self.contactsViewController = [[ContactsViewController alloc] initWithStyle:UITableViewStylePlain];
    contactsViewController.pomelo = pomelo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameText:nil];
    [self setChannelText:nil];
    [super viewDidUnload];
}
@end
