//
//  ViewController.m
//  KMLTest
//
//  Created by Hoang Tuan Anh on 3/17/18.
//  Copyright © 2018 Hoang Tuan Anh. All rights reserved.
//

#import "ViewController.h"
#import <GMUKMLParser.h>
#import <GMUGeometryRenderer.h>
#import <GMUPlacemark.h>
#import <GMULineString.h>

@import GoogleMaps;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSString *path = [[NSBundle mainBundle] pathForResource:@"Untitled Path" ofType:@"kml"];
  NSURL *url = [NSURL fileURLWithPath:path];
  GMUKMLParser *parser = [[GMUKMLParser alloc] initWithURL:url];
  [parser parse];
  GMUGeometryRenderer *renderer = [[GMUGeometryRenderer alloc] initWithMap:_mapView
                                                                geometries:parser.placemarks
                                                                    styles:parser.styles];

  GMULineString *line = parser.placemarks.firstObject.geometry;
  for (int i = 0; i < line.path.count; i ++) {
    CLLocationCoordinate2D coorDinate = [line.path coordinateAtIndex:i];
    NSLog(@"%f, %f", coorDinate.latitude, coorDinate.longitude);
  }
  [renderer render];
  _mapView.camera = [GMSCameraPosition cameraWithLatitude: 37.421552 longitude:-122.084271 zoom:16];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
