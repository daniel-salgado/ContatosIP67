//
//  ContatosNoMapaViewController.h
//  ContatosIP67
//
//  Created by ios6233 on 7/26/16.
//  Copyright © 2016 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ContatosNoMapaViewController : UIViewController


@property IBOutlet MKMapView* mapa;

@property CLLocationManager* manager;

@end
