//
//  ParametricSurfaceRepresentation.m
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 12/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "ParametricSurfaceRepresentation.h"
#import "ShadersBuilder.h"
#import "ParametricEquations.hpp"

#import <vector>

@implementation ParametricSurfaceRepresentation
{
    ISurface *figure;
}

@synthesize glView = _glView;

+ (GLES_VERSION)glesVersionUse {
    return GLES_VERSION_2;
}

+ (instancetype)startLessonWithView:(GLView *) openGLView {
    ParametricSurfaceRepresentation *lesson = [self new];
    openGLView.delegate = lesson;
    
    [openGLView setupDepthBuffer];
    
    lesson->programHandle = [ShadersBuilder buildProgramWithVertexShaderFileName:@"Simple.vert" andFragmentShaderFileName:@"Simple.frag"];
    glUseProgram(lesson->programHandle);
    
    lesson->positionAttribute = glGetAttribLocation(lesson->programHandle, "Position");
    lesson->colorAttribute = glGetAttribLocation(lesson->programHandle, "SourceColor");
    
    [lesson initiateFigure];
    [lesson initiateAnimation];
    
    return lesson;
}

- (void) initiateFigure {
    figure = (ISurface *)new Torus(1.4f, 0.3f);
//    figure = (ISurface *)new KleinBottle(0.2f);
//    figure = (ISurface *)new MobiusStrip(1);
//    figure = (ISurface *)new Cone(3, 1);
    
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

- (void) initiateAnimation {
    rotationAnimation.fromValue = 0;
    rotationAnimation.toValue = 360;
    rotationAnimation.currentValue = 0;
    rotationAnimation.duration = 5.0f;
    rotationAnimation.timeElapsed = 0;
    rotationAnimation.animationStopped = false;
}

#pragma mark - OpenGLESViewDelegate

- (void) updateAnimation:(float)timestamp {
    if (rotationAnimation.timeElapsed == 0.0f) {
        rotationAnimation.timeElapsed = 1.0f;
    } else {
        rotationAnimation.timeElapsed += timestamp;
    }
    
    rotationAnimation.currentValue = rotationAnimation.timeElapsed / rotationAnimation.duration * rotationAnimation.toValue;
}

- (void) render {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClearColor(0.3, 0.3, 0.3, 1.0);
    
    mat4 rotationY;
    if (rotationAnimation.animationStopped == NO) {
        rotationY = mat4::RotateY(rotationAnimation.currentValue);
    }
    
    mat4 translation = mat4::Translate(0, 0, -7);
    GLint modelviewUniform = glGetUniformLocation(programHandle, "ModelView");
    mat4 modelviewMatrix = rotationY * translation;
    glUniformMatrix4fv(modelviewUniform, 1, 0, modelviewMatrix.Pointer());
    
    // Set the projection matrix.
    GLint projectionUniform = glGetUniformLocation(programHandle, "Projection");
    mat4 projectionMatrix = mat4::Frustum(-1.6f, 1.6, -2.4, 2.4, 5, 10);
    glUniformMatrix4fv(projectionUniform, 1, 0, projectionMatrix.Pointer());
    
    glEnableVertexAttribArray(positionAttribute);
    
    glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 6, 0);
    glVertexAttrib4f(colorAttribute, 0.8, 0.8, 0.8, 1.0);
    glDrawElements(GL_TRIANGLES, (*figure).GetTriangleIndexCount(), GL_UNSIGNED_SHORT, 0);
    
    glDisableVertexAttribArray(positionAttribute);
    
}

@end
