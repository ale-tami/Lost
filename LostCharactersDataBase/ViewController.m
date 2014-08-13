//
//  ViewController.m
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 12/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "PlistManager.h"
#import "Actor.h"
#import "LostTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *search;

@property NSMutableArray *actors;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.search.delegate = self;
    
    if (![self loadData]) {
        
        NSArray * actorsArray = [[PlistManager getInstance] deserializeData];
        
        for (NSDictionary *dict in actorsArray) {
            
            Actor *actor = [NSEntityDescription insertNewObjectForEntityForName:@"Actor" inManagedObjectContext:self.managedObjectContext];
            actor.actor = [dict objectForKey:@"actor"];
            actor.passenger = [dict objectForKey:@"passenger"];
            
            [self.managedObjectContext save:nil];
            
        }
    }
    
    [self.tableView reloadData]; 
    
}

- (BOOL) loadData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Actor"];

    self.actors = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:request error:nil]];
    
    if (self.actors.count == 0) {
        return NO;
    } else {
        [self.tableView reloadData];
        return YES;
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //Too expensive?
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"actor" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Actor"];
    
    request.sortDescriptors = sortDescriptors;
    //request.predicate = [NSPredicate predicateWithFormat:@"(actor like %@) or (passenger like %@)", searchText, searchText];
    if ([searchText length] != 0) {
            request.predicate = [NSPredicate predicateWithFormat:@"actor BEGINSWITH %@", searchText];
    }

    self.actors = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:request error:nil]];
    [self.tableView reloadData];
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Smoke Monsta";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Actor *actor = [self.actors objectAtIndex:indexPath.row];
    [self.actors removeObjectAtIndex:indexPath.row];
    [self.managedObjectContext deleteObject:actor];
    [self.managedObjectContext save:nil];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.actors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Actor *actor = [self.actors objectAtIndex:indexPath.row];
    cell.actorLabel.text = actor.actor;
    cell.passengerLabel.text = actor.passenger;
    cell.hairLabel.text = actor.hair;
    cell.ageLabel.text = [actor.age stringValue];
    cell.iqLabel.text = [actor.iq stringValue];
    
    return cell;

}


@end
