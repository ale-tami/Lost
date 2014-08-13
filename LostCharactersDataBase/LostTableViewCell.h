//
//  LostTableViewCell.h
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 13/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *iqLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hairLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;

@end
