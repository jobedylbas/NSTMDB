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
#import "Network.h"
#import "Parser.h"
#import "MovieDetailsViewController.h"
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Movie *> *movies;
@property (strong, nonatomic) NSData *image;
@property (strong, nonatomic) NSDictionary *response;
@property (strong, nonatomic) NSString *errorMessage;
//@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) Parser *parser;
@property (strong, nonatomic) Network *network;
@end

@implementation ViewController

NSString *cellID = @"cellID";
NSString *segueIdentifier = @"movieDetailSegueIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.network = Network.new;
    NSURL *url =[self.network reqNowPlayingMovies];
    
    [Network makeRequest: url
                  completion: ^(NSDictionary *data, NSError *error) {
                      if (error) {
                          self.errorMessage = [error localizedDescription];
                      } else {
                          self.response = data;
                          self.parser = [[Parser alloc] init];
                          self.movies = [self.parser nowPlayingMovies: data];
                          __block int i = 0;
                          for(Movie *movie in self.movies) {
                              [Network makePosterRequest: [self.network reqMoviePoster: movie.posterPath]
                                        completion: ^(NSData *data, NSError *error) {
                                            if (error) {
                                                NSLog(@"%@", [error localizedDescription]);
                                            } else {
                                                movie.poster = data;
                                                NSLog(@"%i", i);
                                                i = i + 1;
                                                if(i == self.movies.count - 1) {
                                                    [self.tableView reloadData];
                                                }
                                            }
                                        }];
                          }
                      }
                  }];
}

- (Movie *)feedTableView: (NSInteger *) indexRow {
    NSLog(@"%@",  self.movies);
    return self.movies[(NSInteger)indexRow];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [_movies count];
    return self.movies.count;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
