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
                          [self.tableView reloadData];
                      }
                  }];
//    [self feedTableView];
}

- (Movie *)feedTableView: (NSInteger *) indexRow {
    NSLog(@"%@",  self.movies);
    return self.movies[(NSInteger)indexRow];
//    Movie *movie1 = Movie.new;
//    movie1.title = @"Title 01";
//    movie1.overview = @"My String";
////    movie1.sinopse = @"Sinopse 01";
////    movie1.story = @"Story 01";
//    movie1.score = @7.1;
//    movie1.poster = NSData.new;
//
//    Movie *movie2 = Movie.new;
//    movie2.title = @"Title 02";
//    movie2.overview = @"Descp 02";
////    movie2.sinopse = @"Sinopse 02";
////    movie2.story = @"Story 02";
//    movie2.score= @7.2;
//    movie2.poster = NSData.new;
//
//    Movie *movie3 = Movie.new;
//    movie3.title = @"Title 03";
//    movie3.overview = @"Descp 03";
////    movie3.sinopse = @"Sinopse 03";
////    movie3.story = @"Story 03";
//    movie3.score = @7.3;
//    movie3.poster = NSData.new;
//
//    switch ( (NSInteger) indexRow) {
//        case 0:
//            return movie1;
//            break;
//        case 1:
//            return movie2;
//            break;
//        case 2:
//            return movie3;
//            break;
//        default:
//            return Movie.new;
//            break;
//    }
//    [self.movies addObject:movie1];
//    [self.movies addObject:movie2];
//    [self.movies addObject:movie3];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [_movies count];
    return self.movies.count;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    [cell setData: [_movies objectAtIndex:indexPath.row]];
    [cell setData: [self feedTableView:indexPath.row]];
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:segueIdentifier sender:indexPath];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        MovieDetailsViewController *vc = segue.destinationViewController;
        NSInteger *row = [[self tableView] indexPathForSelectedRow].row;
        row = row == nil ? 0 : row;
        vc.movie = [self feedTableView: row];
        
    }
}

//override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//    if (segue.identifier == "showQuestionnaire") {
//        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! QuestionnaireController
//        let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
//        let patientQuestionnaire = patientQuestionnaires[row] as! PatientQuestionnaire
//        controller.selectedQuestionnaire = patientQuestionnaire
//    }
//}
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self prepareForSegue:UIStoryboard.new sender:self];
//}
//
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [segue destinationViewController];
//    if ([segue.identifier isEqualToString:segueIdentifier]) {
//
//        MovieDetailsViewController *vc = segue.destinationViewController;
//
//    }
//}

@end




// movieDetailSegueIdentifier
