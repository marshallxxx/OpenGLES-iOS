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

#import "CubeLessonOES.h"
#import "SquareLesson.h"
#import "CubeLesson.h"
#import "CubeMotionRotationLesson.h"
#import "CubeAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

@dynamic view;

- (void)loadView {
    
    Class lesson = [ACTIVELESSON class];
    
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
    if ([lesson glesVersionUse] == GLES_VERSION_1) {
        self.view = [[GLESOneView alloc] initWithFrame:windowRect];
    } else {
        self.view = [[GLESTwoView alloc] initWithFrame:windowRect];
    }
    
    self.activeLesson = [lesson startLessonWithView:(GLView *)self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    glViewport(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
