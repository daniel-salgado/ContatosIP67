//
//  GerenciadorDeAcoes.m
//  ContatosIP67
//
//  Created by ios6233 on 7/25/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "GerenciadorDeAcoes.h"

@implementation GerenciadorDeAcoes


-(id)initWithContato:(Contato *)contato
{
    
    self = [super init];
    
    if (self)
    {
        self.contato = contato;
    }
    
    return self;
    
}

-(void)acoesDoController:(UIViewController *)controller
{
    
    self.controller = controller;
    
    UIActionSheet *opcoes = [[UIActionSheet alloc]
                             initWithTitle:self.contato.nome
                             delegate:self
                             cancelButtonTitle:@"Cancelar"
                             destructiveButtonTitle:nil
                             otherButtonTitles:@"Ligar", @"Enviar e-mail", @"Visualizar site", @"Abrir Mapa", nil];
    
    [opcoes showInView:controller.view];
    
}

//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
-(void)actionSheet:(UIActionSheet *)menu clickedButtonAtIndex:(NSInteger)indice
{
    
    
    switch (indice) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self mostrarMapa];
            break;
        default:
            break;
    }
    
    
    
}

-(void)abrirAplicativoComURL: (NSString*) url
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}

-(void)ligar
{
    
    UIDevice* aparelho = [UIDevice currentDevice];
    
    
    if ([aparelho.model isEqualToString: @"iPhone"])
    {
        
        NSString* numero = [NSString stringWithFormat: @"tel:%@", self.contato.telefone];
        
        [self abrirAplicativoComURL: numero];
        
    }
    else
    {
        
        [[[UIAlertView alloc] initWithTitle: @"Impossível fazer ligação"
                                    message: @"Seu dispositivo não é um iPhone"
                                   delegate: nil
                          cancelButtonTitle: @"Ok"
                          otherButtonTitles: nil] show];
        
    }
    
}

-(void)abrirSite
{
    
    NSString* url = self.contato.site;
    
    if (![url hasPrefix: @"http://"])
        url = [NSString stringWithFormat:@"http://%@", url];
    
    [self abrirAplicativoComURL:url];
    
}

-(void)mostrarMapa
{
    
    //    NSString* url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", self.contato.endereco]
    NSString* url = [[NSString stringWithFormat:@"http://maps.apple.com/?q=%@", self.contato.endereco]
                     stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self abrirAplicativoComURL:url];
    
}

-(void)enviarEmail
{
    
    
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController* enviador = [[MFMailComposeViewController alloc] init]; //ou new
        
        [enviador setToRecipients:@[self.contato.email]];
        [enviador setSubject:@"Título do email"];
        
        enviador.mailComposeDelegate = self;
        
        [self.controller presentViewController:enviador
                                      animated:YES
                                    completion:nil];
        
        
    }
    else
    {
        
        UIAlertView* alerta = [[UIAlertView alloc] initWithTitle: @"Oops!"
                                                         message: @"Não é possível enviar email"
                                                        delegate: nil
                                               cancelButtonTitle: @"Ok"
                                               otherButtonTitles: nil];
        
        [alerta show];
        
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    
    [self.controller dismissViewControllerAnimated:YES
                                        completion:nil];
    
}

@end
