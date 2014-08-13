//
//  CoreDataManager.m
//  LostCharactersDataBase
//
//  Created by Alejandro Tami on 12/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "CoreDataManager.h"


@interface CoreDataManager()

@property NSManagedObjectContext *context;


@end

@implementation CoreDataManager

static CoreDataManager *coreDataManager = nil;

+ (instancetype) getInstance
{
    if (coreDataManager) {
        return coreDataManager;
    } else {
        coreDataManager = [CoreDataManager new];
        coreDataManager.context = [[[UIApplication sharedApplication] delegate] _managedObjectContext];
        
        return coreDataManager;
    }
}

@end
