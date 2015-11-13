//
//  CubeMotionRotationLesson.m
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "CubeMotionRotationLesson.h"
#import "ShadersBuilder.h"
#import "CubeModel.h"
#import "Matrix.hpp"
#import "Quaternion.hpp"

#import <CoreMotion/CoreMotion.h>

@interface CubeMotionRotationLesson ()
@property (nonatomic) mat4 rotationMatrix;
@property (nonatomic, strong) CMMotionManager *cmManager;
@end

@implementation CubeMotionRotationLesson

@synthesize glView = _glView;

+ (GLES_VERSION)glesVersionUse {
    return GLES_VERSION_2;
}

+ (instancetype)startLessonWithView:(GLView *) openGLView {
    
    CubeMotionRotationLesson *lesson = [self new];
    openGLView.delegate = lesson;
    
    [openGLView setupDepthBuffer];
    
    lesson->programHandle = [ShadersBuilder buildProgramWithVertexShaderFileName:@"Simple.vert" andFragmentShaderFileName:@"Simple.frag"];
    glUseProgram(lesson->programHandle);
    
    lesson->positionAttribute = glGetAttribLocation(lesson->programHandle, "Position");
    lesson->colorAttribute = glGetAttribLocation(lesson->programHandle, "SourceColor");
    
    [lesson settingUpCoreMotion];
    
    return lesson;
}

- (void) settingUpCoreMotion {
    
    self.cmManager = [[CMMotionManager alloc] init];
    NSOperationQueue *mQueue = [NSOperationQueue mainQueue];
    
    [self.cmManager setGyroUpdateInterval:0.5];
    
    [self.cmManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical toQueue:mQueue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        
        float points[] = {
            (float)motion.attitude.rotationMatrix.m11,
            (float)motion.attitude.rotationMatrix.m12,
            (float)motion.attitude.rotationMatrix.m13,
            0.0f,
            (float)motion.attitude.rotationMatrix.m21,
            (float)motion.attitude.rotationMatrix.m22,
            (float)motion.attitude.rotationMatrix.m22,
            0.0f,
            (float)motion.attitude.rotationMatrix.m31,
            (float)motion.attitude.rotationMatrix.m32,
            (float)motion.attitude.rotationMatrix.m33,
            0.0f,
            0.0f,
            0.0f,
            0.0f,
            1.0f
        };
        
        self.rotationMatrix = mat4(points);
        
    }];

}

#pragma mark - OpenGLESViewDelegate

- (void) render {
    glClearColor(0.3, 0.3, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    mat4 translation = mat4::Translate(0, 0, -7);
    GLint modelviewUniform = glGetUniformLocation(programHandle, "ModelView");
    mat4 modelviewMatrix = self.rotationMatrix * translation;
    glUniformMatrix4fv(modelviewUniform, 1, 0, modelviewMatrix.Pointer());
    
    // Set the projection matrix.
    GLint projectionUniform = glGetUniformLocation(programHandle, "Projection");
    mat4 projectionMatrix = mat4::Frustum(-1.6f, 1.6, -2.4, 2.4, 5, 10);
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
        
        glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 3, &cubeVertices);
        Color4f color = sidesColors[i];
        glVertexAttrib4f(colorAttribute, color.R, color.G, color.B, color.A);
        
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, &cubeIndexes[6*i]);
        
    }
    
    glDisableVertexAttribArray(positionAttribute);
    
}

@end
