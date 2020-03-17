//
//  Parse.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//  This Class transform an JsonObject of Network to movies

#import "Network.h"
#ifndef Parse_h
#define Parse_h
@interface Parse : NSObject

@property (strong, nonatomic) Network *network;
//@property (strong, nonatomic) NSArray<Movie> *popularMovies;
//@property (strong, nonatomic) NSArray<Movie> *nowPlayingMovies;

- (NSArray*) popularMovies;

- (NSArray*) nowPlayingMovies;

@end

#endif /* Parse_h */
