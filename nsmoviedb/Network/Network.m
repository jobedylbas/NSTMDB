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
+ (void) makeRequest: (NSURL*) url completion:(void (^)(NSDictionary *, NSError *))completionBlock {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        //Create a block to handle the background thread in the dispatch method.
        void (^runAfterCompletion)(void) = ^void (void) {
            if (error) {
                completionBlock (nil, error);
            } else {
                NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                completionBlock(jsonObject, error);
            }
        };
        //Dispatch the queue
        dispatch_async(dispatch_get_main_queue(), runAfterCompletion);
       }];
        [task resume]; // to start the download task
//    NSLog(@"data: %@",jsonObject);
}

+ (void) makePosterRequest: (NSURL*) url completion:(void (^)(NSData *, NSError *))completionBlock {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
//        NSLog(@"data");
        //Create a block to handle the background thread in the dispatch method.
        void (^runAfterCompletion)(void) = ^void (void) {
            if (error) {
//                NSLog(@"%@", error);
                completionBlock (nil, error);
            } else {
//                NSLog(@"%@", data);
                NSData *_data = data;
                completionBlock(_data, error);
            }
        };
        //Dispatch the queue
        dispatch_async(dispatch_get_main_queue(), runAfterCompletion);
       }];
        [task resume]; // to start the download task
//    NSLog(@"data: %@",jsonObject);
}

- (NSURL*) reqPopularMovies {
    static NSString* key = @"fb61737ab2cdee1c07a947778f249e7d";
    static NSString* popularURL = @"https://api.themoviedb.org/3/movie/popular?api_key=";
    NSURL *url = [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", popularURL, key]];
    
    return url;
}

- (NSURL*) reqNowPlayingMovies {
    static NSString* key = @"fb61737ab2cdee1c07a947778f249e7d";
    static NSString* nowPlayingURL = @"https://api.themoviedb.org/3/movie/now_playing?api_key=";
    NSURL *url = [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", nowPlayingURL, key]];
    return url;
//     [Network makeRequest: url
//                  completion: ^(NSDictionary *data, NSError *error) {
//                      if (error) {
//                          self.errorMessage = [error localizedDescription];
//                      } else {
//                          self.response = data;
//                      }
//                  }];
}

- (NSURL*) reqMoviePoster:(NSString *) path {
    static NSString *prefix = @"http://image.tmdb.org/t/p/w185";
    NSURL *url = [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", prefix, path]];
    
    return url;
}


@end
