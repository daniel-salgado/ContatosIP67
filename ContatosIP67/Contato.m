//
//  Contato.m
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

//Override da description = toString() do C#
-(NSString*)description
{

//    return self.Nome;
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Email: %@, Endereço: %@, Site: %@",self.nome , self.telefone, self.email, self.endereco, self.site];
    
}


-(CLLocationCoordinate2D)coordinate //Tem que ser coordinate pois vem do MKAnnotation
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

-(NSString*)title
{
    return self.nome;
}

-(NSString*)subtitle
{
    return self.endereco;
}

@end
