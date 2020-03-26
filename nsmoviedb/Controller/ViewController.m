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
#import "MovieDBService.h"
#import "MovieDetailsViewController.h"
#import <Foundation/Foundation.h>


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Movie *> *movies;
@property (strong, nonatomic) NSMutableArray<Movie *> *tableViewMovieSource;

@property (strong, nonatomic) NSData *image;
@property (strong, nonatomic) NSDictionary *response;
@property (strong, nonatomic) NSString *errorMessage;
@property (strong, nonatomic) MovieDBService *movieDBService;
@end

@implementation ViewController

NSString *cellID = @"cellID";
NSString *segueIdentifier = @"movieDetailSegueIdentifier";
NSString *sectionName01 = @"Popular Movies";
NSString *sectionName02 = @"Now Playing";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movies = NSMutableArray.new;
    self.movieDBService = MovieDBService.new;
    [self setNavigationBar];
    [self.movieDBService reqPopularMovies: ^(NSMutableArray *data, NSError *error) {
                      if (error) {
                          NSLog(@"%@", [error localizedDescription]);
                      } else {
                          [self.movies addObject: data[0]];
                          [self.movies addObject: data[1]];
                          [self.movieDBService reqNowPlayingMovies: ^(NSMutableArray *data, NSError *error) {
                              if (error) {
                                  NSLog(@"%@", [error localizedDescription]);
                              } else {
                                  [self.movies addObjectsFromArray: data];
                                  
                                  self.tableViewMovieSource = [[NSMutableArray <Movie *> alloc] initWithArray:self.movies];
                                  
                                  [self.tableView reloadData];
                              }
                          }];
                          
                      }
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
    return self.movies[(NSInteger)indexRow];
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

NSInteger currentIndex = 0;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentIndex = indexPath.row + indexPath.section*2;
    [self performSegueWithIdentifier:segueIdentifier sender:nil];
}

// Mark: Segue functions
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        MovieDetailsViewController *mdvc = [segue destinationViewController];
        mdvc.movie = [self feedTableView: currentIndex];
    }
}

@end
