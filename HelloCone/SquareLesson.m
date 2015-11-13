/*
 *  Description
 *
 * Simple OpenGL ES application which draws a square with fixed color
 *
 *
 *
 */

#import "SquareLesson.h"
#import "ShadersBuilder.h"

#import "SquareModel.h"

@implementation SquareLesson

@synthesize glView = _glView;

+ (GLES_VERSION)glesVersionUse {
    return GLES_VERSION_2;
}

+ (instancetype)startLessonWithView:(GLView *) openGLView {
    
    SquareLesson *lesson = [self new];
    openGLView.delegate = lesson;
    lesson->_glView = openGLView;
    
    lesson->programHandle = [ShadersBuilder buildProgramWithVertexShaderFileName:@"Simple.vert" andFragmentShaderFileName:@"Simple.frag"];
    glUseProgram(lesson->programHandle);
    
    lesson->positionAttribute = glGetAttribLocation(lesson->programHandle, "Position");
    lesson->colorAttribute = glGetAttribLocation(lesson->programHandle, "SourceColor");
    
    return lesson;
}

#pragma mark - OpenGLESViewDelegate

- (void) render {
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(positionAttribute);

    int sizeOfVertex = sizeof(float) * 2;
    
    glVertexAttribPointer(positionAttribute, 2, GL_FLOAT, GL_FALSE, sizeOfVertex, &squareVertices);
    
    
    glDrawArrays(GL_TRIANGLES, 0, sizeof(squareVertices) / sizeOfVertex);
    
    glDisableVertexAttribArray(positionAttribute);
    
}

@end
