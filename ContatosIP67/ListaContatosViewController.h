//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormularioContatoViewController.h"

@interface ListaContatosViewController : UITableViewController <LidaContatoCriado, UIActionSheetDelegate>


@property ContatoDAO* dao;

@property NSInteger posicao;

@end
