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
        
        if (self.contato.foto)
        {
            
            [self.campoFoto setBackgroundImage:self.contato.foto forState:UIControlStateNormal];
            [self.campoFoto setTitle:nil forState:UIControlStateNormal];
            
        }
        
        
        UIBarButtonItem* botaoAlterar = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Salvar"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(alteraContato)];
        
        self.navigationItem.rightBarButtonItem = botaoAlterar;
        
    }
    
    
    [self.nome becomeFirstResponder]; //É um setFocus()
    
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
    
    _contato.nome = [self.nome text];
    _contato.telefone = [self.telefone text];
    _contato.endereco = [self.endereco text];
    _contato.email = [self.email text];
    _contato.site = [self.site text];
    _contato.foto = [self.campoFoto backgroundImageForState:UIControlStateNormal];
    
    
    
}



-(IBAction)tiraFoto:(id)sender
{
    
    //    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    //    {
    //        //Camera indisponível
    //        //usar biblioteca
    //        UIImagePickerController* picker = [UIImagePickerController new];
    //
    //        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //
    //        picker.allowsEditing = YES;
    //
    //        picker.delegate = self;
    //
    //        [self presentViewController: picker
    //                           animated: YES
    //                         completion: nil];
    //
    //    }
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancelar"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
        [actionSheet showInView:self.view];
        
        
    }
    else
    {
        
        UIImagePickerController* picker = [UIImagePickerController new];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage* foto = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [self.campoFoto setBackgroundImage:foto forState:UIControlStateNormal];
    [self.campoFoto setTitle:nil forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController * picker = [UIImagePickerController new];
    
    picker.delegate = self;
    picker.allowsImageEditing = YES;
    
    switch (buttonIndex)
    {
     
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
            
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            break;
            
    }

    
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

@end
