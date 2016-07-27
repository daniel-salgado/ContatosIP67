//
//  ContatoDAO.m
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ContatoDAO.h"

@implementation ContatoDAO

static ContatoDAO* defaultDao = nil;

-(void)adiciona : (Contato*) contato
{
    [self.contatos addObject:contato];
    NSLog(@"Contatos: %@", self.contatos);
    
}

//-(NSObject*)init ou -(id) init
-(id) init
{
 
    self = [super init];
    
    //nil significa nulo, null
    if (self)
    {
        self.contatos = [NSMutableArray new];
        
    }
    
    return self;
    
}

+(id)contatoDaoInstance
{
    
    if (!defaultDao)
    {
        defaultDao = [ContatoDAO new];
    }
    
    return defaultDao;
}


-(Contato*)buscaContatoDaPosicao:(NSInteger)posicao
{
    return self.contatos[posicao];
}


@end
