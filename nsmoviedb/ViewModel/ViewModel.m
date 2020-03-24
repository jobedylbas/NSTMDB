//
//  ViewModel.m
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 23/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"
#import "Network.h"
#import "Parser.h"
#import "Movie.h"


@implementation ViewModel
- (NSURL*) popularMoviesURL {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", POPULAR_URL, KEY]];
}

- (NSURL*) nowPlayingMoviesURL {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", NOWPLAYING_URL, KEY]];
}

- (NSURL*) genreURL {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", GENRE_URL, KEY]];
}

- (NSURL*) moviePosterURL: (NSString *) path {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", POSTER_URL, path]];
}



- (void) reqPopularMovies: (void (^)(NSMutableArray*, NSError *)) completionBlock {
    __block Parser *parser = Parser.new;
    __block NSMutableArray *movies;
    
    [Network makeRequest: [self popularMoviesURL]
                  completion: ^(NSDictionary *moviesDic, NSError *error) {
                      if (error) {
                          NSLog(@"%@", [error localizedDescription]);
                      } else {
                          [Network makeRequest: [self genreURL]
                                    completion: ^(NSDictionary *data, NSError *error) {
                              if (error) { NSLog(@"%@", [error localizedDescription]); }
                              else {
                                  movies = [Parser popularMovies: moviesDic
                                                           genresDic: data[@"genres"]];
//                                  NSLog(@"%@", movies);
                                  __block int i = 0;
                                  for(Movie *movie in movies) {
                                      [Network makePosterRequest: [self moviePosterURL: movie.posterPath]
                                                      completion: ^(NSData *data, NSError *error) {
                                                        if (error) {
                                                            NSLog(@"%@", [error localizedDescription]);
                                                        } else {
                                                          movie.poster = data;
                                                          NSLog(@"%i", i);
                                                          i = i + 1;
                                                          if(i == movies.count - 1) {
                                                              completionBlock(movies, error);
                                                          }
                                                        }
                                                    }];
                                  }
                              }
                          }];
                      }}];
}

- (void) reqNowPlayingMovies: (void (^)(NSMutableArray*, NSError *)) completionBlock {
    Parser *parser = Parser.new;
    
    [Network makeRequest: [self nowPlayingMoviesURL]
                  completion: ^(NSDictionary *data, NSError *error) {
                      if (error) {
                          NSLog(@"%@", [error localizedDescription]);
                      } else {
                          NSMutableArray *movies = [parser nowPlayingMovies: data];
                          __block int i = 0;
                          for(Movie *movie in movies) {
                              [Network makePosterRequest: [self moviePosterURL: movie.posterPath]
                                        completion: ^(NSData *data, NSError *error) {
                                            if (error) {
                                                NSLog(@"%@", [error localizedDescription]);
                                            } else {
                                                movie.poster = data;
                                                NSLog(@"%i", i);
                                                i = i + 1;
                                                if(i == movies.count - 1) {
                                                    completionBlock(movies, error);
                                                }
                                            }
                                        }];
                          }
                      }
                  }];
}


@end
