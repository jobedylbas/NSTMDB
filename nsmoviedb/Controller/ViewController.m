//
//  ViewController.m
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 16/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
#import "TableViewCell.h"
#import "MovieDetailsViewController.h"
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Movie *> *movies;

@end

@implementation ViewController

NSString *cellID = @"cellID";
NSString *segueIdentifier = @"movieDetailSegueIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self feedTableView];
}

- (Movie *)feedTableView: (NSInteger *) indexRow {
    
    Movie *movie1 = Movie.new;
    movie1.title = @"Super long title one: home comming";
    movie1.overview = @"My String";
//    movie1.sinopse = @"Sinopse 01";
//    movie1.story = @"Story 01";
    movie1.score = @7.1;
    movie1.poster = NSData.new;
    
    Movie *movie2 = Movie.new;
    movie2.title = @"Smol title 2";
    movie2.overview = @"Descp 02";
//    movie2.sinopse = @"Sinopse 02";
//    movie2.story = @"Story 02";
    movie2.score= @7.2;
    movie2.poster = NSData.new;
    
    Movie *movie3 = Movie.new;
    movie3.title = @"Normal third name";
    movie3.overview = @"Descp 03";
//    movie3.sinopse = @"Sinopse 03";
//    movie3.story = @"Story 03";
    movie3.score = @7.3;
    movie3.poster = NSData.new;
    
    switch ( (NSInteger) indexRow) {
        case 0:
            return movie1;
            break;
        case 1:
            return movie2;
            break;
        case 2:
            return movie3;
            break;
        default:
            return Movie.new;
            break;
    }
//    [self.movies addObject:movie1];
//    [self.movies addObject:movie2];
//    [self.movies addObject:movie3];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [_movies count];
    return 3;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    [cell setData: [_movies objectAtIndex:indexPath.row]];
    [cell setData: [self feedTableView:indexPath.row]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        MovieDetailsViewController *mdvc = [segue destinationViewController];
        NSInteger *row = [[self tableView] indexPathForSelectedRow].row;
        row = row == nil ? 0 : row;
        mdvc.movie = [self feedTableView:row];
    }
}

@end
