//
//  ParametricSurfaceRepresentation.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 12/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LessonProtocol.h"
#import "GLHelperStructs.h"
#import "LightningStruct.h"

@interface ParametricSurfaceRepresentation : NSObject <LessonProtocol, OpenGLESViewDelegate> {
    GLuint programHandle;
    GLint positionAttribute;
    GLint colorAttribute;
    GLuint vertexBuffer;
    GLuint indexBuffer;
    
    ShaderLightValues lightValues;
    
    Animation rotationAnimation;
}

@end
