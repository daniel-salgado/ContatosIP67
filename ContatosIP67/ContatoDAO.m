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

//-(NSObject*)init ou -(id) init
-(id) init
{
    
    self = [super init];
    
    //nil significa nulo, null
    if (self)
    {
        self.contatos = [NSMutableArray new];
        self.coreData = [CoreDataInfra new];
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

-(void)adiciona : (Contato*) contato
{
    [self.contatos addObject:contato];
    NSLog(@"Contatos: %@", self.contatos);
    
}

-(Contato*)buscaContatoDaPosicao:(NSInteger)posicao
{
    return self.contatos[posicao];
}

-(Contato*)criaNovoContato
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Contato" inManagedObjectContext:self.coreData.managedObjectContext];
}
-(void)salva
{
    
    [self.coreData saveContext];
    
}

-(void)removeContato : (NSInteger*) posicaoDoContato;
{
    
    Contato* removeEsteContato = [self buscaContatoDaPosicao:*posicaoDoContato];
    
    [self.contatos removeObject:removeEsteContato];
    
    [self.coreData.managedObjectContext deleteObject:removeEsteContato];
    
    //[self.contatos removeObject:contato];
    
}

-(void)listaContatos
{
    
    NSFetchRequest* query = [NSFetchRequest fetchRequestWithEntityName:@"Contato"];
    
    NSSortDescriptor* ordermAlfabetica = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    
    query.sortDescriptors = @[ordermAlfabetica];
    
    
    NSArray* retornoDaQuery = [self.coreData.managedObjectContext executeFetchRequest:query error:nil];
    
    self.contatos = [retornoDaQuery mutableCopy];
    
}


@end
