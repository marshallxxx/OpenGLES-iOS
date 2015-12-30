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
    
    lesson->programHandle = [ShadersBuilder buildProgramWithVertexShaderFileName:@"SimpleLighting.vert" andFragmentShaderFileName:@"Simple.frag"];
    glUseProgram(lesson->programHandle);
    
    lesson->positionAttribute = glGetAttribLocation(lesson->programHandle, "Position");
    
    lesson->lightValues = ShaderLightInitValues(&lesson->programHandle);
    
    [lesson setupLightning];
    [lesson initiateFigure];
    [lesson initiateAnimation];
    
    return lesson;
}

- (void)setupLightning {
    // Set up some default material parameters.
    glVertexAttrib3f(lightValues.Ambient, 0.04f, 0.04f, 0.04f);
    glVertexAttrib3f(lightValues.Specular, 0.5, 0.5, 0.5);
    glVertexAttrib1f(lightValues.Shininess, 50);
    
    // Set the light position.
    vec4 lightPosition(0.25, 0.25, 1, 0);
    glUniform3fv(lightValues.LightPosition, 1, lightPosition.Pointer());
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
    
    // Set the normal matrix.
    // It's orthogonal, so its Inverse-Transpose is itself!
    mat3 normalMatrix = modelviewMatrix.ToMat3();
    glUniformMatrix3fv(lightValues.NormalMatrix, 1, 0, normalMatrix.Pointer());
    
    // Set the projection matrix.
    GLint projectionUniform = glGetUniformLocation(programHandle, "Projection");
    mat4 projectionMatrix = mat4::Frustum(-1.6f, 1.6, -2.4, 2.4, 5, 10);
    glUniformMatrix4fv(projectionUniform, 1, 0, projectionMatrix.Pointer());
    
    // Set the diffuse color.
    vec3 color = vec3(0.5, 0.5, 0.5);
    glVertexAttrib4f(lightValues.Diffuse, color.x, color.y, color.z, 1);
    
    glEnableVertexAttribArray(positionAttribute);
    glEnableVertexAttribArray(lightValues.Normal);
    
    float stride = sizeof(float) * 6;
    glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, stride, 0);
    int offset = 2;
    glVertexAttribPointer(lightValues.Normal, 3, GL_FLOAT, GL_FALSE, stride, &offset);
    glVertexAttrib4f(colorAttribute, 0.8, 0.8, 0.8, 1.0);
    glDrawElements(GL_TRIANGLES, (*figure).GetTriangleIndexCount(), GL_UNSIGNED_SHORT, 0);
    
    glDisableVertexAttribArray(positionAttribute);
    glDisableVertexAttribArray(lightValues.Normal);
    
}

@end
