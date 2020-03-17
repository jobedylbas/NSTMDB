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

- (void) reqPopularMovies {
    static NSString* key = @"fb61737ab2cdee1c07a947778f249e7d";
    static NSString* popularURL = @"https://api.themoviedb.org/3/movie/popular?api_key=";
    NSString *_url = [NSString stringWithFormat:@"%@%@", popularURL, key];
    NSLog(@"%@", _url);

    NSURL *url = [[NSURL alloc]initWithString:_url];
    //type your URL u can use initWithFormat for placeholders
//    NSURLSession *session = [NSURLSession sharedSession];  //use NSURLSession class
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    //You then can use NSURLSessionDownloadTask or NSURLSessionUploadTask
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//        [self loadDataFromDictionary:(NSArray*)jsonObject];
        NSLog(@"data: %@",jsonObject);
       }];
        [task resume]; // to start the download task
}

- (NSString *) reqNowPlayingMovies {
    NSLog(@"hello from NSLog");

    return @"lola";
}


@end
