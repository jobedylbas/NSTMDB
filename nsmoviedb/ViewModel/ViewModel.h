//
//  ViewModel.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 23/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#ifndef ViewModel_h
#define ViewModel_h

#define KEY @"fb61737ab2cdee1c07a947778f249e7d"
#define POPULAR_URL @"https://api.themoviedb.org/3/movie/popular?api_key="
#define NOWPLAYING_URL @"https://api.themoviedb.org/3/movie/now_playing?api_key="
#define POSTER_URL @"http://image.tmdb.org/t/p/w185"
#define GENRE_URL @"https://api.themoviedb.org/3/genre/movie/list?api_key="


@interface ViewModel: NSObject

- (void) reqPopularMovies: (void (^)(NSMutableArray*, NSError *)) completionBlock;

- (void) reqNowPlayingMovies: (void (^)(NSMutableArray*, NSError *))completionBlock;

- (NSURL*) popularMoviesURL;

- (NSURL*) nowPlayingMoviesURL;

- (NSURL*) moviePosterURL: (NSString*) movieId;



@end

#endif /* ViewModel_h */
