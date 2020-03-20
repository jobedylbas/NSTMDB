//
//  Movie.h
//  nsmoviedb
//
//  Created by Luiz Pedro Franciscatto Guerra on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#ifndef Movie_h
#define Movie_h

#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *movieDescription;
@property (strong, nonatomic) NSString *sinopse;
@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSData *poster;

@end

#endif /* Movie_h */
