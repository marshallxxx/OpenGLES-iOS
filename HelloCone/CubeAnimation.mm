//
//  CubeAnimation.m
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/13/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "CubeAnimation.h"
#import "ShadersBuilder.h"
#import "CubeModel.h"
#import "Matrix.hpp"
#import "Quaternion.hpp"

struct Animation {
    float fromValue;
    float toValue;
    float currentValue;
    float duration;
    float timeElapsed;
    BOOL animationStopped;
};

struct AnimationCircle {
    float radius;
    float currentValue;
    float duration;
    float timeElapsed;
    BOOL animationStopped;
};

@implementation CubeAnimation {
    Animation rotationAnimation;
    AnimationCircle movingAnimation;
}

@synthesize glView = _glView;

+ (GLES_VERSION)glesVersionUse {
    return GLES_VERSION_2;
}

+ (instancetype)startLessonWithView:(GLView *) openGLView {
    
    CubeAnimation *lesson = [self new];
    openGLView.delegate = lesson;
    
    [openGLView setupDepthBuffer];
    
    lesson->programHandle = [ShadersBuilder buildProgramWithVertexShaderFileName:@"Simple.vert" andFragmentShaderFileName:@"Simple.frag"];
    glUseProgram(lesson->programHandle);
    
    lesson->positionAttribute = glGetAttribLocation(lesson->programHandle, "Position");
    lesson->colorAttribute = glGetAttribLocation(lesson->programHandle, "SourceColor");
    
    [lesson initializeVBOs];
    [lesson initiateAnimation];
    
    return lesson;
}

- (void)initializeVBOs {
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(cubeVertices), &cubeVertices[0], GL_STATIC_DRAW);
    
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(cubeIndexes), &cubeIndexes[0], GL_STATIC_DRAW);
    
}

- (void)initiateAnimation {
    //Rotation Animation
    rotationAnimation.fromValue = 0;
    rotationAnimation.toValue = 360;
    rotationAnimation.duration = 2.f;
    rotationAnimation.timeElapsed = 0;
    
    //Move Animation
    movingAnimation.radius = 2;
    movingAnimation.duration = 4.f;
    movingAnimation.timeElapsed = 0;
}

- (void) updateAnimation:(float)timestamp {
    
    if (rotationAnimation.timeElapsed == 0.0f) {
        rotationAnimation.timeElapsed = 1.0f;
        movingAnimation.timeElapsed = 1.0f;
    } else {
        rotationAnimation.timeElapsed += timestamp;
        movingAnimation.timeElapsed += timestamp;
    }
    
    rotationAnimation.currentValue = rotationAnimation.timeElapsed / rotationAnimation.duration * rotationAnimation.toValue;
    
    //Update move animation
    
    if (movingAnimation.duration <= movingAnimation.timeElapsed) {
        movingAnimation.timeElapsed = 0;
    }
    
    movingAnimation.currentValue = TwoPi / (movingAnimation.duration / movingAnimation.timeElapsed);
    
}

float LinearTween(float t, float start, float end)
{
    return t * start + (1 - t) * end;
}

float QuadraticEaseIn(float t, float start, float end)
{
    return LinearTween(t * t, start, end);
}

#pragma mark - OpenGLESViewDelegate

- (void) render {
    glClearColor(0.3, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    mat4 translation = mat4::Translate(movingAnimation.radius * cos(movingAnimation.currentValue), 0, movingAnimation.radius * sin(movingAnimation.currentValue) + -7);
    mat4 rotation = mat4::RotateZ(45.0f);
    
    mat4 rotationY;
    if (rotationAnimation.animationStopped == NO) {
        rotationY = mat4::RotateY(rotationAnimation.currentValue);
    }
    
    GLint modelviewUniform = glGetUniformLocation(programHandle, "ModelView");
    mat4 modelviewMatrix =  rotation * rotationY * translation;
    glUniformMatrix4fv(modelviewUniform, 1, 0, modelviewMatrix.Pointer());
    
    // Set the projection matrix.
    GLint projectionUniform = glGetUniformLocation(programHandle, "Projection");
    mat4 projectionMatrix = mat4::Frustum(-1.6f, 1.6, -2.4, 2.4, 4, 10);
    glUniformMatrix4fv(projectionUniform, 1, 0, projectionMatrix.Pointer());
    
    Color4f sidesColors[] = {
        Color4fMake(1.0f, 0.f, 0.f, 1.0f),
        Color4fMake(0.0f, 1.f, 0.f, 1.0f),
        Color4fMake(0.0f, 0.f, 1.f, 1.0f),
        Color4fMake(1.0f, 0.5f, 1.f, 1.0f),
        Color4fMake(0.4f, 0.f, 7.f, 1.0f),
        Color4fMake(0.8f, 0.3f, 0.6f, 1.0f)
    };
    
    glEnableVertexAttribArray(positionAttribute);
    
    for (int i = 0; i < cubeIndexCount / 6; i++) {
        
        glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 3, 0);
        Color4f color = sidesColors[i];
        glVertexAttrib4f(colorAttribute, color.R, color.G, color.B, color.A);
        
        int ioff = i * 6;
        const GLvoid* offset = (GLvoid*) ioff;
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, offset);
        
    }
    
    glDisableVertexAttribArray(positionAttribute);
    
}

@end
