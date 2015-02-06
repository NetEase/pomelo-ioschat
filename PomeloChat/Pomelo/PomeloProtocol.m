//
//  PomeloProtocol.m
//  iOS client for Pomelo
//
//  Created by Johnny on 12-12-24.
//  Copyright (c) 2012 netease pomelo team. All rights reserved.
//

#import "PomeloProtocol.h"

NSString* const PomeloException = @"PomeloException";

@implementation PomeloProtocol

+ (NSString *)encodeWithId:(NSInteger)id andRoute:(NSString *)route andBody:(NSString *)body
{
    if ([route length] > 255) {
        [NSException raise:PomeloException format:@"Pomelo: route length is too long!"];
        return nil;
    }
    
    NSString *msg = [NSString stringWithFormat:@"%C%C%C%C%C%@%@",
                     (unichar)((id >> 24) & 0xFF),
                     (unichar)((id >> 16) & 0xFF),
                     (unichar)((id >> 8) & 0xFF),
                     (unichar)(id & 0xFF),
                     (unichar)[route length],
                     route,
                     body];
    
    //    NSLog(@"send msg,%d, %d, %@",[route length] + [body length],[msg length],msg);
    
    return msg;
}
@end
