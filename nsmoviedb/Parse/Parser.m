//
//  Parse.m
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "Network.h"
#import "Movie.h"

@implementation Parser

- (NSMutableArray*) popularMovies: (NSDictionary*) response {
    NSMutableArray *movies = [NSMutableArray array];
    Movie *_newMovie = [[Movie alloc] init];
    int counter = 0;
    for (NSDictionary *movie in response[@"results"]) {
        if (counter < 2) {
            counter++;
            _newMovie.title = movie[@"original_title"];
            _newMovie.score = movie[@"vote_average"];
            _newMovie.tmdbId = movie[@"id"];
            NSString *desc = movie[@"overview"];
            _newMovie.overview = desc;
            NSArray *genreIds = movie[@"genre_ids"];
            
            NSString *genreString = @"";
            for(NSNumber *genreId in genreIds) {
                NSString *genreName = [Parser genreName: genreId];
                genreString = [genreString stringByAppendingString: [genreName stringByAppendingString: @", "]];
                _newMovie.category = genreString;
            }
            [movies addObject:_newMovie];
        }
        
    }
//    NSLog(@"%@", movies);
    return movies;
}

- (NSMutableArray*) nowPlayingMovies: (NSDictionary*) response {
    NSMutableArray *movies = [NSMutableArray array];
    Network *network = [[Network alloc] init];
    for (NSDictionary *movie in response[@"results"]) {
        __block Movie *_newMovie = [[Movie alloc] init];
        NSString *desc = movie[@"overview"];
        NSArray *genreIds = movie[@"genre_ids"];
        NSString *genreString = @"";
        _newMovie.title = movie[@"original_title"];
        _newMovie.score = movie[@"vote_average"];
        _newMovie.tmdbId = movie[@"id"];
        NSURL *url = [network reqMoviePoster: [_newMovie.tmdbId stringValue]];
        NSLog(@"%@", url);
//        [network makePosterRequest: url
//                      completion: ^(NSData *data, NSError *error) {
//                          if (error) {
//                              NSLog(@"%@", [error localizedDescription]);
//                          } else {
//                              NSLog(@"data");
//                              _newMovie.poster = data;
//                          }
//                      }];
        
        _newMovie.overview = desc;
        
        for(NSNumber *genreId in genreIds) {
            NSString *genreName = [Parser genreName: genreId];
            genreString = [genreString stringByAppendingString: [genreName stringByAppendingString: @", "]];
            
            _newMovie.category = genreString;
        }
        
        [movies addObject:_newMovie];
    }
//    NSLog(@"%@", movies);
    return movies;
}

+ (NSString*) genreName: (NSNumber*) genreId {
//    NSString *genreString = @"";
    switch ([genreId intValue]) {
        case 28:
            return @"Action";
        case 16:
            return @"Animated";
        case 99:
            return @"Documentary";
        case 18:
            return @"Drama";
        case 10751:
            return @"Family";
        case 14:
            return @"Fantasy";
        case 36:
            return @"History";
        case 35:
           return @"Comedy";
        case 10752:
            return  @"War";
        case 80:
            return @"Crime,";
        case 10402:
            return @"Music";
        case 9648:
            return  @"Mystery";
        case 10749:
            return @"Romance";
        case 878:
            return @"Sci-fi";
        case 27:
            return @"Horror";
        case 10770:
            return  @"TV Movie";
        case 53:
            return  @"Thriller";
        case 37:
            return @"Western";
        case 12:
            return @"Adventure";
        default:
           return @"";

    }
}


@end
