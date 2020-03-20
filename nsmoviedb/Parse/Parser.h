//
//  Parse.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//  This Class transform an JsonObject of Network to movies

#ifndef Parse_h
#define Parse_h
@interface Parser : NSObject

//@property (strong, nonatomic) Network *network;
//@property (strong, nonatomic) NSArray<Movie> *popularMovies;
//@property (strong, nonatomic) NSArray<Movie> *nowPlayingMovies;
//@property (strong, nonatomic) NSData *poster;
- (NSMutableArray*) popularMovies: (NSDictionary*) response;

- (NSMutableArray*) nowPlayingMovies: (NSDictionary*) response;

+ (NSString*) genreName: (NSNumber*) genreId;

@end

#endif /* Parse_h */
