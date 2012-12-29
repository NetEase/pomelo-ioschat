//
//  ChatViewController.m
//  PomeloChat
//
//  Created by Johnny on 12-12-27.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@property (strong, nonatomic) NSMutableString *chatStr;
- (void)initEvents;
@end

@implementation ChatViewController

@synthesize inputTextField;
@synthesize chatTextField;
@synthesize chatStr;
@synthesize pomelo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.chatStr = [[NSMutableString alloc] initWithCapacity:10];
    }
    return self;
}

- (IBAction)send:(id)sender
{
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          inputTextField.text, @"content",
                          self.target, @"target",
                          nil];
    
    if ([self.target isEqualToString:@"*"]) {
        [pomelo notifyWithRoute:@"chat.chatHandler.send" andParams:data];
    } else {
        [pomelo requestWithRoute:@"chat.chatHandler.send" andParams:data andCallback:^(NSDictionary *result){
            [chatStr appendFormat:@"you says to %@: %@\n", self.target, [data objectForKey:@"content"]];
            [self updateChat];
        }];
    }
    inputTextField.text = @"";
    [inputTextField resignFirstResponder];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    if ([self.title isEqualToString:@"All"]) {
        self.target = @"*";
    } else {
        self.target = self.title;
    }
}

- (void)updateChat
{
    self.chatTextField.text = chatStr;
}

- (void)initEvents
{
    [pomelo onRoute:@"onChat" withCallback:^(NSDictionary *data){
        NSLog(@"onChat------");
        NSString *target = [[data objectForKey:@"target"] isEqualToString:@"*"] ? @"" : @" to you";
        [chatStr appendFormat:@"%@ says%@: %@\n", [data objectForKey:@"from"], target, [data objectForKey:@"msg"] ];
        [self updateChat];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initEvents];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setChatTextField:nil];
    [self setInputTextField:nil];
    self.chatStr = nil;
    self.target = nil;
    [self.pomelo offRoute:@"onChat"];
    [super viewDidUnload];
}
@end
