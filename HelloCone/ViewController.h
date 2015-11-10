//
//  ViewController.h
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLESViewProtocol.h"
#import "LessonProtocol.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) UIView<GLESViewProtocol> *view;
@property (nonatomic, strong) id<LessonProtocol> activeLesson;
@end

