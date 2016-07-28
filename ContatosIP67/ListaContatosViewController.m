//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios6233 on 7/19/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"

@implementation ListaContatosViewController

//Inicializador para add botao no nav UINavigationController

-(id)init //ou (NSObeject*)
{
    
    self = [super init];
    
    if (self)  //Se self existe, é possível manipular a instancia
    {
        
        self.posicao = -1;
        
        self.dao = [ContatoDAO contatoDaoInstance];
        
        //Botão é um objeto e precisa ser criado
        UIBarButtonItem* botaoAdd = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                     target: self
                                     action: @selector(exibeFormulario)]; //@selector é o mesmo que método
        
        self.navigationItem.title = @"Contatos";
        
        self.navigationItem.rightBarButtonItem = botaoAdd;
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem; //Para incuir botão para deletar itens da tableview
        
        
        //Imagem no tabItem
        
        UIImage* iconeLista = [UIImage imageNamed:@"lista-contatos.png"];
        
        UITabBarItem* tab = [[UITabBarItem alloc] initWithTitle:@"Contatos"
                                                          image:iconeLista
                                                            tag:0];
        self.tabBarItem = tab;
        
        self.navigationItem.title = @"Contatos";
        
        //Imagem no tabItem
        
        
    }
    
    return self;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    if (self.posicao >= 0)
    {
        
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.posicao inSection:0];
        
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
        self.posicao = -1;
        
    }
}

-(void)viewDidLoad
{
    UILongPressGestureRecognizer* cliqueLongo = [[UILongPressGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(mostraMenu:)];
    
    [self.tableView addGestureRecognizer:cliqueLongo];
    
}

-(void)mostraMenu: (UIGestureRecognizer*) gesto
{
    
    if (gesto.state == UIGestureRecognizerStateBegan)
    {
        
        NSLog(@"Clique long acionado!");
        
        CGPoint pontoClicadoXY = [gesto locationInView:self.tableView];
        
        NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:pontoClicadoXY];
        
        if (indexPath)
        {
            
            Contato* contato = self.dao.contatos[indexPath.row];
            
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:contato];
            
            [self.gerenciador acoesDoController:self];
            
            
        }
        
    }
    
}


//-(void)exibeFormulario
-(void)exibeFormulario
{
    
    NSLog(@"Vai exibir o formulário");
    
    UIStoryboard* board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FormularioContatoViewController* formulario = [board instantiateViewControllerWithIdentifier:@"Form-Contato"];
    
    formulario.lista = self;
    
    
    //push serve para empilhar formulários...
    
    [self.navigationController pushViewController:formulario animated:YES];
    
}

-(void)exibeFormulario:(Contato*) contato
{
    
    NSLog(@"Vai exibir o formulário");
    
    UIStoryboard* board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FormularioContatoViewController* formulario = [board instantiateViewControllerWithIdentifier:@"Form-Contato"];
    
    formulario.lista = self;
    
    formulario.contato = contato;
    
    
    //push serve para empilhar formulários...
    [self.navigationController pushViewController:formulario animated:YES];
    
}


//Exibição dos dados na lista

-(NSInteger)numberOfSectionsInTableView:(UITableView *)table //override
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)table
numberOfRowsInSection:(NSInteger)section
{
    
    return [self.dao.contatos count];
    
}

//Cria uma nova cell
-(UITableViewCell*) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *) index
{
    
    //    UITableViewCell* linha = [[UITableViewCell alloc]
    //                             initWithStyle:UITableViewCellStyleDefault
    //                             reuseIdentifier:nil];
    
    //Verificando linha para reclicagem
    UITableViewCell* linha = [table dequeueReusableCellWithIdentifier: @"Linha"]; //Label da linhas que será reclicada
    
    if (!linha)
    {
        linha = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:@"Linha"]; //Label da linha para ser identificada e reclicada para reduzir recursos do IOS
        
        UIView* backgorund = [UIView new];
        
        backgorund.backgroundColor = [UIColor cyanColor];
        
        linha.selectedBackgroundView = backgorund;
        
    }
    
    
    
    Contato* contato = self.dao.contatos[index.row];
    
    linha.textLabel.text = contato.nome;
    
    return linha;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

//Exibição dos dados na lista

//Removendo item da TableView e DAO
-(void)tableView:(UITableView *)table
commitEditingStyle:(UITableViewCellEditingStyle)style
forRowAtIndexPath:(NSIndexPath *)path
{
    
    if (style == UITableViewCellEditingStyleDelete)
    {
        
        [self.dao.contatos removeObjectAtIndex:path.row];
        
        [table deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    
}

-(void)tableView:(UITableView *)table
didSelectRowAtIndexPath:(NSIndexPath *)path
{
    
    
    Contato* contatoSelecionado = self.dao.contatos[path.row];
    
    [self exibeFormulario:contatoSelecionado];
    
    
}

-(void)contatoAtualizado:(Contato *)contato
{
    NSLog(@"Contato atualizado: %@", contato.nome);
    self.posicao = [self.dao.contatos indexOfObject:contato];
}

-(void)contatoAdicionado:(Contato *)contato
{
    
    NSLog(@"Contato adicionado: %@", contato.nome);
    
    self.posicao = [self.dao.contatos indexOfObject:contato];
    
    
    
    
}

@end
