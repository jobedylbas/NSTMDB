//
//  Movie.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 16/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#ifndef Movie_h
#define Movie_h

@interface Movie : NSObject

@property (strong, nonatomic) NSData *poster;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSFloat *score;

@end

#endif /* Movie_h */
