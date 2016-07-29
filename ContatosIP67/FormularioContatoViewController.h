//
//  ViewController.h
//  ContatosIP67
//
//  Created by ios6233 on 7/18/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ContatoDAO.h"

//Protocol é o mesmo que interface no C#. Cria uma assinatura para o método chamado. Poliformismo
@protocol LidaContatoCriado <NSObject>

-(void)contatoAtualizado : (Contato* ) contato;
-(void)contatoAdicionado : (Contato* ) contato;

@end

@interface FormularioContatoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

//propriedade iboutlet para deixar visivel
//Vinculo da variavel com layout
@property IBOutlet UITextField* nome;
@property IBOutlet UITextField* telefone;
@property IBOutlet UITextField* endereco;
@property IBOutlet UITextField* email;
@property IBOutlet UITextField* site;

@property ContatoDAO* dao;

@property (strong) Contato* contato;

@property id <LidaContatoCriado> lista;

@property IBOutlet UIButton* campoFoto;


@property IBOutlet UITextField* latitude;
@property IBOutlet UITextField* longitude;


@property IBOutlet UIActivityIndicatorView* rodinha;

-(IBAction)tiraFoto:(id)sender;

-(IBAction)buscarCoordenadas:(id)sender;




@end

