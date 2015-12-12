//
//  SquareLesson.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import "LessonProtocol.h"

@interface SquareLesson : NSObject <LessonProtocol, OpenGLESViewDelegate> {
    GLuint programHandle;
    GLint positionAttribute;
    GLint colorAttribute;
}

@end
