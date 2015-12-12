//
//  ShadersBuilder.h
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 11/10/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

@interface ShadersBuilder : NSObject

+ (GLuint) buildProgramWithVertexShaderFileName:(NSString *) vertexSahderFile andFragmentShaderFileName:(NSString *) fragmentShaderFile;

@end
