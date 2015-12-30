//
//  LightningStruct.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 12/14/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#ifndef LightningStruct_h
#define LightningStruct_h

#import <OpenGLES/ES2/gl.h>

typedef struct {
    GLuint LightPosition;
    GLuint NormalMatrix;
    GLint Normal;
    GLint Ambient;
    GLint Diffuse;
    GLint Specular;
    GLint Shininess;
} ShaderLightValues;

ShaderLightValues ShaderLightInitValues(GLuint *program) {
    ShaderLightValues shaderValues;
    
    shaderValues.LightPosition = glGetUniformLocation(*program, "LightPosition");
    shaderValues.NormalMatrix = glGetUniformLocation(*program, "NormalMatrix");
    shaderValues.Normal = glGetAttribLocation(*program, "Normal");
    shaderValues.Ambient = glGetAttribLocation(*program, "AmbientMaterial");
    shaderValues.Diffuse = glGetAttribLocation(*program, "DiffuseMaterial");
    shaderValues.Specular = glGetAttribLocation(*program, "SpecularMaterial");
    shaderValues.Shininess = glGetAttribLocation(*program, "Shininess");
    
    return shaderValues;
};

#endif /* LightningStruct_h */
