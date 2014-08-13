//
//  AddGuyViewController.m
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 12/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "AddGuyViewController.h"
#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Actor.h"


@interface AddGuyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *actorTextField;
@property (weak, nonatomic) IBOutlet UITextField *passengerTextField;
@property (weak, nonatomic) IBOutlet UITextField *hairTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *iqTextField;
@property (weak, nonatomic) IBOutlet UILabel *savedLabel;

@end

@implementation AddGuyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.savedLabel.alpha = 0.0;
}



- (IBAction)onSave:(UIBarButtonItem *)sender {
    
    //ViewController *vc = (ViewController*)self.navigationController.topViewController;
    ViewController *vc = (ViewController*)[self.navigationController.viewControllers objectAtIndex:0];
    
    Actor *actor = [NSEntityDescription insertNewObjectForEntityForName:@"Actor" inManagedObjectContext:vc.managedObjectContext];
    actor.actor = self.actorTextField.text;
    actor.passenger = self.passengerTextField.text;
    actor.hair = self.hairTextField.text;
    actor.age = [NSNumber numberWithInt:[self.ageTextfield.text intValue]];
    actor.iq = [NSNumber numberWithInt:[self.iqTextField.text intValue]];
    
    [vc.managedObjectContext save:nil];
    
    self.actorTextField.text = nil;
    self.passengerTextField.text = nil;
    self.hairTextField.text = nil;
    self.ageTextfield.text = nil;
    self.iqTextField.text = nil;
    
    [self.actorTextField resignFirstResponder];
    [self.passengerTextField resignFirstResponder];
    [self.hairTextField resignFirstResponder];
    [self.ageTextfield resignFirstResponder];
    [self.iqTextField resignFirstResponder];
    
    [UIView animateWithDuration:1.5 animations:^{
        self.savedLabel.alpha = 1.0;
        self.savedLabel.alpha = 0.0;
    }];
    
    
}


@end
