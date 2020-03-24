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
@property (strong, nonatomic) NSMutableArray<Movie *> *tableViewMovieSource;

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
NSString *sectionName01 = @"Popular Movies";
NSString *sectionName02 = @"Now Playing";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
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
        self.tableViewMovieSource = [[NSMutableArray <Movie *> alloc] initWithArray:self.movies];
                  }];
}

- (void) setNavigationBar {
    UISearchController *searchController = UISearchController.new;
    self.navigationItem.searchController = searchController;
    searchController.searchBar.delegate = self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.tableViewMovieSource = [[NSMutableArray <Movie *> alloc] initWithArray:self.movies];
    [self filterDataArray:searchText];
    [self.tableView reloadData];
//    [self.movies filterUsingPredicate: @"SELF contains[c] 's'" ];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.tableViewMovieSource = [[NSMutableArray <Movie *> alloc] initWithArray:self.movies];
    [self.tableView reloadData];
}

- (void) filterDataArray:(NSString *)substring {
    if (substring.length == 0) { return; }
    substring = substring.lowercaseString;
    NSMutableArray <Movie *> *aux = NSMutableArray.new;
    self.tableViewMovieSource = [[NSMutableArray <Movie *> alloc] initWithArray:self.movies];
    for ( Movie * movie in self.tableViewMovieSource) {
        if ([movie.title.lowercaseString containsString:substring]) {
            [aux addObject: movie];
        }
    }
    self.tableViewMovieSource = aux;
}

// Mark: TableView Functions
- (Movie *)feedTableView: (NSInteger *) indexRow {
    return self.tableViewMovieSource[(NSInteger)indexRow];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger size = self.tableViewMovieSource.count;
    if (section == 0) {
        return size > 2 ? 2 : size;
    } else if (section == 1) {
        return size > 2 ? size - 2 : 0;
    }
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setData: [self feedTableView: indexPath.section == 0 ? indexPath.row : indexPath.row + 2]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return sectionName01;
    } else if (section == 1) {
        return sectionName02;
    } else {
        return @"";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = UIColor.systemBackgroundColor;
}

// Mark: Segue functions
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        MovieDetailsViewController *mdvc = [segue destinationViewController];
        NSInteger *row = [[self tableView] indexPathForSelectedRow].row;
        row = row == nil ? 0 : row;
        mdvc.movie = [self feedTableView:row];
    }
}

@end
