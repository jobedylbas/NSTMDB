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

+ (NSMutableArray*) parseMovies: (NSDictionary*) response genresDic: (NSMutableArray*) genres;

+ (NSString*) genreName: (NSNumber*) genreId genresDic: (NSMutableArray*) genres;

@end

#endif /* Parse_h */
