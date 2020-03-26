//
//  MovieDBService.m
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 23/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDBService.h"
#import "Network.h"
#import "Parser.h"
//#import "Movie.h"


@implementation MovieDBService
- (NSURL*) popularMoviesURL {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@%@", BASE_URL, POPULAR_URL, KEY]];
}

- (NSURL*) nowPlayingMoviesURL {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@%@", BASE_URL, NOWPLAYING_URL, KEY]];
}

- (NSURL*) genreURL {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@%@", BASE_URL, GENRE_URL, KEY]];
}

- (NSURL*) moviePosterURL: (NSString *) path {
    return [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%@", POSTER_URL, path]];
}

- (void) makeMoviesRequest: (NSURL*) url handler: (void (^)(NSMutableArray*, NSError *)) completionBlock {
    __block NSMutableArray *movies;
    
    [Network makeRequest: url
              completion: ^(NSData *moviesData, NSError *error) {
                      if (error) {
                          NSLog(@"%@", [error localizedDescription]);
                          completionBlock(nil, error);
                      } else {
                          NSDictionary *moviesDic = [NSJSONSerialization JSONObjectWithData:moviesData options:NSJSONReadingMutableLeaves error:nil];
                          movies = [Parser parseMovies: moviesDic];
                          __block int i = 0;
                          for(Movie *movie in movies) {
                              // TODO: - Para cada movie, antes de liberar para que o usuário possa ver os filmes, estamos fazendo o request de buscar a imagem. Se a lista for enorme, isso pode demorar bastante e pode ser que o usuário nunca faça o scroll até a última célula da tabela. Não podemos fazer esse request somente quando o usuário passar na célula?
                              [Network makeRequest: [self moviePosterURL: movie.posterPath]
                                              completion: ^(NSData *posterData, NSError *error) {
                                                if (error) {
                                                    NSLog(@"%@", [error localizedDescription]);
                                                    completionBlock(movies, error);
                                                } else {
//                                                    NSLog(@"%@", [self moviePosterURL: movie.posterPath]);
                                                  movie.poster = posterData;
                                                  i++;
                                                  if(i == movies.count - 1) {
                                                      completionBlock(movies, error);
                                                  }
                                                }
                                            }];
                            }
                        }
    }];
}


- (void) reqPopularMovies: (void (^)(NSMutableArray*, NSError *)) completionBlock {
    [self makeMoviesRequest: [self popularMoviesURL]
                     handler: ^(NSMutableArray *data, NSError *error) {
                        if(error) {
                            NSLog(@"%@", [error localizedDescription]);
                            completionBlock(data, error);
                        }
                        else {
                            completionBlock(data, error);
                        }
                    }
     ];
}

- (void) reqNowPlayingMovies: (void (^)(NSMutableArray*, NSError *)) completionBlock {
    [self makeMoviesRequest: [self nowPlayingMoviesURL]
                     handler: ^(NSMutableArray *data, NSError *error) {
                        if(error) {
                            NSLog(@"%@", [error localizedDescription]);
                            completionBlock(data, error);
                        }
                        else {
                            completionBlock(data, error);
                        }
                    }
     ];
}

- (void) reqMovieGenres: (void (^)(NSDictionary*, NSError *))completionBlock {
    [Network makeRequest: [self genreURL]
        completion: ^(NSData *moviesData, NSError *error) {
                if (error) {
                    NSLog(@"%@", [error localizedDescription]);
                    completionBlock(nil, error);
                } else {
                    NSDictionary *jsonGenres = [NSJSONSerialization JSONObjectWithData:moviesData options:NSJSONReadingMutableLeaves error:nil];
                    completionBlock(jsonGenres[@"genres"], error);
                }
    }];
}

- (void) getMovieGenre: (Movie*) movie handler: (void (^)(NSError *))completionBlock {
    [self reqMovieGenres:^(NSDictionary *genres, NSError *error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            for(NSNumber *categorieId in movie.categoriesIds) {
                for(NSDictionary *genre in genres) {
                    
                    if(categorieId == genre[@"id"]) {
                        NSLog(@"%@", genre);
                        [movie.categories addObject: genre[@"name"]];
                    }
                }
            }
            completionBlock(error);

        }
    }];
}


@end
