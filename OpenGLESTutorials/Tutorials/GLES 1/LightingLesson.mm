//
//  LightingLesson.m
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 12/13/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "LightingLesson.h"
#import "ParametricEquations.hpp"

#import <vector>

@implementation LightingLesson
{
    ISurface *figure;
    
    GLuint vertexBuffer;
    GLuint indexBuffer;
}

@synthesize glView = _glView;

+ (GLES_VERSION)glesVersionUse {
    return GLES_VERSION_1;
}

+ (instancetype)startLessonWithView:(GLView *) openGLView {
    LightingLesson *lesson = [self new];
    openGLView.delegate = lesson;
    
    [openGLView setupDepthBuffer];
    
    // Initialize Lightning
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, GL_TRUE);
    
    [lesson setMatrices];
    [lesson initModels];
    [lesson initLightAnimation];
    
    // Set up the material properties
    vec4 specular(0.5f, 0.5f, 0.5f, 1);
    glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, specular.Pointer());
    glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, 50.0f);
    
    return lesson;
}

- (void) setMatrices {
    glMatrixMode(GL_PROJECTION);
    glFrustumf(-1.6f, 1.6, -2.4, 2.4, 5, 10);
}

- (void) initModels {
    
    figure = (ISurface *)new TrefoilKnot(2);
    
    vector<float> vertices;
    (*figure).GenerateVertices(vertices, VertexFlagsNormals);
    
    vector<unsigned short> indices;
    (*figure).GenerateTriangleIndices(indices);
    
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, vertices.size() * sizeof(float), &vertices[0], GL_STATIC_DRAW);
    
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, indices.size() * sizeof(GLushort), &indices[0], GL_STATIC_DRAW);
    
    
}

- (void) initLightAnimation {
    lightRotationAnimation.radius = 2;
    lightRotationAnimation.currentValue = 0;
    lightRotationAnimation.duration = 3.0f;
    lightRotationAnimation.timeElapsed = 0;
    lightRotationAnimation.animationStopped = false;
}

- (void) updateAnimation:(float)timestamp {
    
    if (lightRotationAnimation.timeElapsed == 0.0f) {
        lightRotationAnimation.timeElapsed = 0.1f;
    } else {
        lightRotationAnimation.timeElapsed += timestamp;
    }
    
    //Update move animation
    lightRotationAnimation.currentValue = TwoPi / (lightRotationAnimation.duration / lightRotationAnimation.timeElapsed);
    
    if (lightRotationAnimation.duration <= lightRotationAnimation.timeElapsed) {
        lightRotationAnimation.timeElapsed = 0;
    }
}

- (void)render {
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClearColor(0.5, 0.5, 0.5, 1.0);
    
    // Set the light position.
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    vec4 lightPosition(lightRotationAnimation.radius * cos(lightRotationAnimation.currentValue), 0, lightRotationAnimation.radius * sin(lightRotationAnimation.currentValue), 0);
    glLightfv(GL_LIGHT0, GL_POSITION, lightPosition.Pointer());
    
    // Set back ModelView Matrix
    glMatrixMode(GL_MODELVIEW);
    glTranslatef(0, 0, -7);
    
    // Draw
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_NORMAL_ARRAY);
    
    int stride = sizeof(float) * 6;
    glVertexPointer(3, GL_FLOAT, stride, 0);
    const GLvoid* normalOffset = (const GLvoid*) sizeof(vec3);
    glNormalPointer(GL_FLOAT, stride, normalOffset);
    glColor4f(0.9, 0.2, 0.2, 1.0);
    glDrawElements(GL_TRIANGLES, (*figure).GetTriangleIndexCount(), GL_UNSIGNED_SHORT, 0);
    
    glDisableClientState(GL_VERTEX_ARRAY);
    glDisableClientState(GL_NORMAL_ARRAY);
    
}

@end
