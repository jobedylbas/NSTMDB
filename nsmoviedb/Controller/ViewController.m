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
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Movie *> *movies;

@end

@implementation ViewController
{
    UITableView *tableView;
}
NSString *cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self->tableView registerClass: UITableViewCell.class forCellReuseIdentifier:cellID];
    [self feedTableView];
}

- (void)feedTableView {
    Movie *movie1 = Movie.new;
    movie1.title = @"Title 01";
    movie1.movieDescription = @"Descp 01";
    movie1.sinopse = @"Sinopse 01";
    movie1.story = @"Story 01";
    movie1.rating = @7.1;
    movie1.poster = NSData.new;
    
    Movie *movie2 = Movie.new;
    movie2.title = @"Title 02";
    movie2.movieDescription = @"Descp 02";
    movie2.sinopse = @"Sinopse 02";
    movie2.story = @"Story 02";
    movie2.rating = @7.2;
    movie2.poster = NSData.new;
    
    Movie *movie3 = Movie.new;
    movie3.title = @"Title 03";
    movie3.movieDescription = @"Descp 03";
    movie3.sinopse = @"Sinopse 03";
    movie3.story = @"Story 03";
    movie3.rating = @7.3;
    movie3.poster = NSData.new;
    
    [self.movies addObject:movie1];
    [self.movies addObject:movie2];
    [self.movies addObject:movie3];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_movies count] == 0 ? 3 : [_movies count];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    [cell setData: [_movies objectAtIndex:indexPath.row]];
    
    return cell;
}





@end



