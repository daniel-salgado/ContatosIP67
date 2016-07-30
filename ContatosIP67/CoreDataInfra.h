//
//  CoreDataInfra.h
//  ContatosIP67
//
//  Created by ios6233 on 7/29/16.
//  Copyright © 2016 Caelum. All rights reserved.
//
//  Esse CoreData foi feito a partir das properties que estava na AppDelegate.
//  Vamos utilizar apenas essa classe para persistir e salvar os dados para qualquer cadastro




#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataInfra : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
