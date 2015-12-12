//
//  CubeLessonOES.m
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/13/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "CubeLessonOES.h"
#import "Matrix.hpp"
#import "CubeModel.h"

@implementation CubeLessonOES

@synthesize glView = _glView;

+ (GLES_VERSION)glesVersionUse {
    return GLES_VERSION_1;
}

+ (instancetype)startLessonWithView:(GLView *) openGLView {
    
    CubeLessonOES *lesson = [self new];
    openGLView.delegate = lesson;
    
    [openGLView setupDepthBuffer];
    
    glMatrixMode(GL_PROJECTION);
    glFrustumf(-1.6f, 1.6, -2.4, 2.4, 5, 10);
    
    glMatrixMode(GL_MODELVIEW);
    glTranslatef(0, 0, -7);
    glRotatef(45, 1, 1, 0);
    
    return lesson;
}

#pragma mark - OpenGLESViewDelegate

- (void) render {
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    Color4f colors[] = {
        Color4fMake(0.2, 0.8, 0.2, 1.0),
        Color4fMake(0.9, 0.3, 0.4, 1.0),
        Color4fMake(0.2, 0.2, 0.2, 1.0),
        Color4fMake(0.9, 0.1, 0.4, 1.0),
        Color4fMake(0.2, 0.8, 0.9, 1.0),
        Color4fMake(0.9, 0.4, 0.8, 1.0)
    };
    
    glEnableClientState(GL_VERTEX_ARRAY);
    
    int stride = sizeof(float) * 3;
    
    for (int i = 0; i < (cubeIndexCount / 6) - 1; i++) {
        glVertexPointer(3, GL_FLOAT, stride, &cubeVertices);
        
        Color4f color = colors[i];
        
        glColor4f(color.R, color.G, color.B, color.A);
        
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, &cubeIndexes[i*6]);
    }
    
    glDisableClientState(GL_VERTEX_ARRAY);
    
}


@end
