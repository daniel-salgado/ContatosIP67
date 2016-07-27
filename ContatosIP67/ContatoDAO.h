//
//  ContatoDAO.h
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@interface ContatoDAO : NSObject

@property (strong) NSMutableArray<Contato*>* contatos;


-(void)adiciona : (Contato*) contato;

+(id)contatoDaoInstance;

-(Contato*)buscaContatoDaPosicao:(NSInteger)posicao;

@end
