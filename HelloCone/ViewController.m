//
//  ViewController.m
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "ViewController.h"

#import "GLESOneView.h"
#import "GLESTWOView.h"

#import "LessonProtocol.h"
#import "SquareLesson.h"

@interface ViewController ()

@end

@implementation ViewController

@dynamic view;

- (void)loadView {
    
    Class lesson = [SquareLesson class];
    
    [lesson preconfig];
    
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
#ifdef OPENGLES1
    self.view = [[GLESOneView alloc] initWithFrame:windowRect];
#else 
    self.view = [[GLESTwoView alloc] initWithFrame:windowRect];
#endif
    
    [lesson startLessonWithView:(GLView *)self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
