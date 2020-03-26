//
//  Network.m
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 16/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Network.h"

@implementation Network
+ (void) makeRequest: (NSURL*) url completion:(void (^)(NSData *, NSError *))completionBlock {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        //Create a block to handle the background thread in the dispatch method.
        void (^runAfterCompletion)(void) = ^void (void) {
            if (error) {
                completionBlock (nil, error);
            } else {
                completionBlock(data, error);
            }
        };
        //Dispatch the queue
        // TODO: - AMW: Aqui vocês já estão voltando pra main antes de fazer o parsing. Vocês podem discutir de quem é a responsabilidade de fazer isso.
        dispatch_async(dispatch_get_main_queue(), runAfterCompletion);
       }];
        [task resume]; // to start the download task
}

@end
