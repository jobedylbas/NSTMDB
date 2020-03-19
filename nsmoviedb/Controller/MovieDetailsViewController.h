//
//  MovieDetailsViewController.h
//  nsmoviedb
//
//  Created by Luiz Pedro Franciscatto Guerra on 17/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) Movie *movie;

@end

NS_ASSUME_NONNULL_END
