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
    static NSString* key = @"fb61737ab2cdee1c07a947778f249e7";
    static NSString* popularURL = @"https://api.themoviedb.org/3/movie/popular?";
    printf("Network before call");
    NSString *url = [NSString stringWithFormat:@"%@%@", key, popularURL];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {

          NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data received: %@", myString);
    }] resume];
}

- (NSString *) reqNowPlayingMovies {
    return @"lola";
}


@end
