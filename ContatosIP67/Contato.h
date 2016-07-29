//
//  Contato.h
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Contato : NSObject <MKAnnotation>

@property (strong) NSString* nome;
@property (strong) NSString* telefone;
@property (strong) NSString* email;

@property (strong) NSString* endereco;
@property (strong) NSNumber* latitude;
@property (strong) NSNumber* longitude;

@property (strong) NSString* site;
@property (strong) UIImage* foto;


@end
