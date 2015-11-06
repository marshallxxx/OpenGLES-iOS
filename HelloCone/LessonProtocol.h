//
//  LessonProtocol.h
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLView.h"

@protocol LessonProtocol <NSObject>

@required
+ (void)preconfig;
+ (void)startLessonWithView:(GLView *) openGLView;

@end
