//
//  Actor.h
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 13/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Actor : NSManagedObject

@property (nonatomic, retain) NSString * actor;
@property (nonatomic, retain) NSString * passenger;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * hair;
@property (nonatomic, retain) NSNumber * iq;

@end
