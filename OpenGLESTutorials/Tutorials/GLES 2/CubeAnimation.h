//
//  CubeAnimation.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/13/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import "LessonProtocol.h"

@interface CubeAnimation : NSObject <LessonProtocol, OpenGLESViewDelegate> {
    GLuint programHandle;
    GLint positionAttribute;
    GLint colorAttribute;
    GLuint vertexBuffer;
    GLuint indexBuffer;
}



@end
