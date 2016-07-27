//
//  ViewController.m
//  ContatosIP67
//
//  Created by ios6233 on 7/18/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "FormularioContatoViewController.h"


@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (void)viewDidLoad //É iniciado após o init
{
    
    if (self.contato)
    {
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
        
        
        UIBarButtonItem* botaoAlterar = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Salvar"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(alteraContato)];
        
        self.navigationItem.rightBarButtonItem = botaoAlterar;
        
        
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Eita"
                                                                   message:@"Deu ruim na memória"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                                                              nil;
                                                              
                                                          }];
    
    [alert addAction:defaultAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
    
}

//Inicializador quando a classe é instanciada pelo storyboard.
-(NSObject*)initWithCoder:(NSCoder*)coder
{
    
    self = [super initWithCoder:coder];
    
    if(self)
    {
        self.dao = [ContatoDAO contatoDaoInstance];
        
        UIBarButtonItem* botao = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Adicionar"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(adicionaContato)];
        
        self.navigationItem.rightBarButtonItem = botao;
        
        
        
    }
    
    return self;
    
}

-(void)adicionaContato
{
    
    [self pegaDadosFormulario];
    [self.dao adiciona: self.contato];
    
    if (self.lista)
    {
        [self.lista contatoAdicionado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    //    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Foi!!!"
    //                                                                   message:@"Contato adicionado com sucesso"
    //                                                            preferredStyle:UIAlertControllerStyleAlert];
    //
    //    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
    //                                                          handler:^(UIAlertAction * action) {
    //                                                              [self.navigationController popViewControllerAnimated:YES];
    //
    //                                                          }];
    //
    //    [alert addAction:defaultAction];
    //    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}


-(void)alteraContato
{
    
    [self pegaDadosFormulario];
    
    if (self.lista)
    {
        [self.lista contatoAtualizado:self.contato];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//-(IBAction)pegaDadosFormulario //IBAction serve para deixar visísvel o método para o storyborad
-(void)pegaDadosFormulario
{
    
    NSString* texto = @"Botão Clicado";
    
    //@"%@"formata para não acessar diretamente a variável
    NSLog(@"%@",texto);
    
    
    if (!_contato)
        _contato = [Contato new];
    
    self.contato.nome = [self.nome text];
    self.contato.telefone = [self.telefone text];
    self.contato.endereco = [self.endereco text];
    self.contato.email = [self.email text];
    self.contato.site = [self.site text];
    
    
}





@end
