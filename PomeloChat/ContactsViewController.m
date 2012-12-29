//
//  ContactsViewController.m
//  PomeloChat
//
//  Created by Johnny on 12-12-27.
//  Copyright (c) 2012年 netease pomelo team. All rights reserved.
//

#import "ContactsViewController.h"
#import "ChatViewController.h"

@interface ContactsViewController ()

@property (strong, nonatomic) ChatViewController *chatViewController;

- (void)initEvents;
@end

@implementation ContactsViewController

@synthesize contactList;
@synthesize chatViewController;
@synthesize pomelo;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.contactList = [[NSMutableArray alloc] initWithCapacity:1];
        [contactList addObject:@"All"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO
    //get contacts
    self.title = @"Contacts";
    self.navigationItem.hidesBackButton = YES;
    
    self.chatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    self.chatViewController.pomelo = pomelo;
    [self initEvents];
}

- (void)initEvents
{
    [pomelo onRoute:@"onAdd" withCallback:^(NSDictionary *data){
        NSLog(@"user add -----");
        NSString *name = [data objectForKey:@"user"];
        [self.tableView beginUpdates];
        [contactList addObject:name];
        NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[contactList count]-1 inSection:0]];
        [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    }];
    [pomelo onRoute:@"onLeave" withCallback:^(NSDictionary *data){
        NSLog(@"user leave ----");
        NSString *name = [data objectForKey:@"user"];
        if ([contactList containsObject:name]) {
            NSUInteger index = [contactList indexOfObject:name];
            [contactList removeObjectAtIndex:index];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]];
            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
}
- (void)viewDidUnload
{
    self.contactList = nil;
    self.chatViewController = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contactList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactsTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row = [indexPath row];
    cell.textLabel.text = [self.contactList objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    chatViewController.title = [contactList objectAtIndex:row];
    [self.navigationController pushViewController:chatViewController animated:YES];
}

@end
