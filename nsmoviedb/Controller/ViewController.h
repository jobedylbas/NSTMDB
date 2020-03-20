//
//  ViewController.h
//  nsmoviedb
//
//  Created by Jobe Diego Dylbas dos Santos on 16/03/20.
//  Copyright © 2020 Jobe Diego Dylbas dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

