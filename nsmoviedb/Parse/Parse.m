//
//  Parse.m
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse.h"
#import "Network.h"
@implementation Parse

- (NSArray*) popularMovies {
    self.network = [[Network alloc] init];
    
    return [[NSArray alloc] init];
}

- (NSArray*) nowPlayingMovies {
    self.network = [[Network alloc] init];
    
    return [[NSArray alloc] init];
}


@end
