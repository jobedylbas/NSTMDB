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
#import "ViewModel.h"
#import "MovieDetailsViewController.h"
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Movie *> *movies;
@property (strong, nonatomic) ViewModel *viewModel;
@end

@implementation ViewController

NSString *cellID = @"cellID";
NSString *segueIdentifier = @"movieDetailSegueIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = ViewModel.new;
    
    [self.viewModel reqPopularMovies: ^(NSMutableArray *data, NSError *error) {
                      if (error) {
                          NSLog(@"%@", [error localizedDescription]);
                      } else {
                          self.movies = data;
                          [self.tableView reloadData];
                      }
    }];

}

- (Movie *)feedTableView: (NSInteger *) indexRow {
    NSLog(@"%@",  self.movies);
    
    return self.movies[(NSInteger)indexRow];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
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
