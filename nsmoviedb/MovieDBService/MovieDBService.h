//
//  MovieDBService.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 23/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#ifndef MovieDBService_h
#define MovieDBService_h

#define KEY @"?api_key=fb61737ab2cdee1c07a947778f249e7d"
#define BASE_URL @"https://api.themoviedb.org/"
#define POPULAR_URL @"3/movie/popular"
#define NOWPLAYING_URL @"3/movie/now_playing"
#define POSTER_URL @"http://image.tmdb.org/t/p/w185"
#define GENRE_URL @"3/genre/movie/list"


@interface MovieDBService: NSObject

- (void) reqPopularMovies: (void (^)(NSMutableArray*, NSError *)) completionBlock;

- (void) reqNowPlayingMovies: (void (^)(NSMutableArray*, NSError *))completionBlock;

- (void) reqMovieGenres: (void (^)(NSMutableArray*, NSError *))completionBlock;

@end

#endif /* MovieDBService_h */
