//
//  LightingLesson.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 12/13/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LessonProtocol.h"
#import <OpenGLES/ES1/gl.h>
#import "GLHelperStructs.h"

@interface LightingLesson : NSObject<LessonProtocol> {
    AnimationCircle lightRotationAnimation;
}

@end
