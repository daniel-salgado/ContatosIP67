//
//  ContatoDAO.h
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
#import "CoreDataInfra.h"

@interface ContatoDAO : NSObject

@property (strong) NSMutableArray<Contato*>* contatos;
@property (strong) CoreDataInfra* coreData;

-(void)adiciona : (Contato*) contato;

+(id)contatoDaoInstance;

-(Contato*)buscaContatoDaPosicao:(NSInteger)posicao;

-(Contato*)criaNovoContato;
-(void)salva;

-(void)listaContatos;

-(void)removeContato : (NSInteger*) posicaoDoContato;


@end
