//
//  ShadersBuilder.m
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/10/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "ShadersBuilder.h"

@implementation ShadersBuilder

+ (NSString *)getContentOfFile:(NSString *) file {
    NSString *path = [[NSBundle mainBundle] pathForResource:[file stringByDeletingPathExtension] ofType:[file pathExtension]];
    
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (error == nil) {
        return content;
    } else {
        return nil;
    }
}

+ (GLuint)buildShaderWithFileName:(NSString *) shaderFile andShaderType:(GLenum) shaderType {
    
    GLuint shaderHandle = glCreateShader(shaderType);
    
    NSString *contentOfShader = [self getContentOfFile:shaderFile];
    GLint lenght = (GLint)[contentOfShader length];
    const char *str = [contentOfShader UTF8String];
    
    glShaderSource(shaderHandle, 1, &str, &lenght);
    glCompileShader(shaderHandle);
    
    //Check if compiled
    GLint success;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE) {
        char message[256];
        glGetShaderInfoLog(shaderHandle, sizeof(message), 0, &message[0]);
        NSLog(@"Failed to compile shader %@, with error: %@", shaderFile, [NSString stringWithUTF8String:message]);
        exit(EXIT_FAILURE);
    }
    
    return shaderHandle;
}

+ (GLuint)buildProgramWithVertexShaderFileName:(NSString *) vertexSahderFile andFragmentShaderFileName:(NSString *) fragmentShaderFile
{
    GLuint vertexHandle = [self buildShaderWithFileName:vertexSahderFile andShaderType:GL_VERTEX_SHADER];
    GLuint fragmentHandle = [self buildShaderWithFileName:fragmentShaderFile andShaderType:GL_FRAGMENT_SHADER];
    
    GLuint programHandle = glCreateProgram();
    
    glAttachShader(programHandle, vertexHandle);
    glAttachShader(programHandle, fragmentHandle);
    
    glLinkProgram(programHandle);
    
    //Check if linked
    GLint success;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &success);
    if (success == GL_FALSE) {
        char message[256];
        glGetProgramInfoLog(programHandle, sizeof(message), 0, &message[0]);
        NSLog(@"Failed to link shader program with error: %@", [NSString stringWithUTF8String:message]);
        exit(EXIT_FAILURE);
    }
    
    return programHandle;
}

@end
