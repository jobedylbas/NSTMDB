//
//  TableViewCell.m
//  nsmoviedb
//
//  Created by Luiz Pedro Franciscatto Guerra on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import "TableViewCell.h"
#import "Movie.h"

@implementation TableViewCell

- (void)setData: (Movie *) movie {
    self.title.text = movie.title;
    self.movieDescriptionLabel.text = movie.overview;
    self.poster.image = [UIImage imageWithData: movie.poster];
    self.poster.layer.cornerRadius = 10;
    
    NSNumberFormatter *formatter = NSNumberFormatter.new;
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 1;
    self.rating.text = [formatter stringFromNumber:movie.score];
}

@end
