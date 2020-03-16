//
//  Network.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 16/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#ifndef Network_h
#define Network_h

@interface Network : NSObject

FOUNDATION_EXPORT NSString *const key =  @"fb61737ab2cdee1c07a947778f249e7";

FOUNDATION_EXPORT NSString *const *popularURL = @"https://api.themoviedb.org/3/movie/popular?" ;

FOUNDATION_EXPORT NSString *const *nowPlayingURL = @"https://api.themoviedb.org/3/movie/now_playing?";

- (void) reqPopularMovies;

- (NSString*) reqNowPlayingMovies;

@end


#endif /* Network_h */
