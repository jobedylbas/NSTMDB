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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData: (Movie *) movie {
//    [self.poster.image initWithData:movie.poster];
    self.title.text = movie.title;
    self.movieDescriptionLabel.text = movie.overview;
    self.poster.image = [UIImage imageWithData: movie.poster];
    self.poster.layer.cornerRadius = 10;
    
    NSNumberFormatter *formatter = NSNumberFormatter.new;
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 1;
    self.rating.text = [formatter stringFromNumber:movie.score];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
