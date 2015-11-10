//
//  GLView.m
//  HelloCone
//
//  Created by Evghenii Nicolaev on 11/6/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#import "GLView.h"

@implementation GLView

@synthesize context = _context, delegate =_delegate;

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (instancetype)initWithFrame:(CGRect) frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupLayer];
        [self setupContext];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        [self setupDisplayLink];
        
    }
    return self;
}

- (void)setupLayer {
    CAEAGLLayer *layer = (CAEAGLLayer *)super.layer;
    layer.opaque = YES;
}

- (void)setupContext {
    NSLog(@"Class is abstract should rewrite method: setupContext");
    exit(EXIT_FAILURE);
}

- (void)setupRenderBuffer {
    NSLog(@"Class is abstract should rewrite method: setupRenderBuffer");
    exit(EXIT_FAILURE);
}

- (void)setupFrameBuffer {
    NSLog(@"Class is abstract should rewrite method: setupFrameBuffer");
    exit(EXIT_FAILURE);
}

- (void)setupDisplayLink {
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(render)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)render {
    NSLog(@"Class is abstract should rewrite method: render");
    exit(EXIT_FAILURE);
}


@end
