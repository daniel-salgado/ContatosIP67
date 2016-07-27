//
//  GerenciadorDeAcoes.h
//  ContatosIP67
//
//  Created by ios6233 on 7/25/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Contato.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface GerenciadorDeAcoes : NSObject<UIActionSheetDelegate,MFMailComposeViewControllerDelegate>

@property Contato* contato;
@property UIViewController* controller;

-(id)initWithContato:(Contato*) contato;

-(void)acoesDoController:(UIViewController*)controller;





@end
