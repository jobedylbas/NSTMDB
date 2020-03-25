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

+ (NSMutableArray*) parseMovies: (NSDictionary*) response genresDic: (NSMutableArray*) genres {
    NSMutableArray *movies = [NSMutableArray array];

    for (NSDictionary *movie in response[@"results"]) {
        Movie *_newMovie = Movie.new;
        _newMovie.title = movie[@"original_title"];
        _newMovie.score = movie[@"vote_average"];
        _newMovie.tmdbId = movie[@"id"];
        NSString *desc = movie[@"overview"];
        _newMovie.overview = desc;
        NSArray *genreIds = movie[@"genre_ids"];
        
        NSString *genreString = @"";
        for(NSNumber *genreId in genreIds) {
            NSString *genreName = [Parser genreName: genreId genresDic: genres];
            genreString = [genreString stringByAppendingString: [genreName stringByAppendingString: @", "]];
            _newMovie.category = genreString;
        }
        [movies addObject:_newMovie];
    }
    return movies;
}

+ (NSString*) genreName: (NSNumber*) genreId genresDic: (NSMutableArray*) genres {
    for(int i=0; i < genres.count; i++) {
        if(genreId == genres[i][@"id"]) {
            return genres[i][@"name"];
        }
    }
    return @"";
}

@end
