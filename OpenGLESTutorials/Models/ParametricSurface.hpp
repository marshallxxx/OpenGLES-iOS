//
//  ParametricSurface.hpp
//  OpenGLESTutorials
//
//  Created by Evghenii Nicolaev on 12/12/15.
//  Copyright © 2015 Evghenii Nicolaev. All rights reserved.
//

#ifndef ParametricSurface_hpp
#define ParametricSurface_hpp

#include <stdio.h>
#include <vector>
#include <OpenGLES/ES2/gl.h>

#include "Matrix.hpp"

using namespace std;

enum VertexFlags {
    VertexFlagsNormals = 1 << 0,
    VertexFlagsTexCoords = 1 << 1,
};

struct ISurface {
    virtual int GetVertexCount() const = 0;
    virtual int GetLineIndexCount() const = 0;
    virtual int GetTriangleIndexCount() const = 0;
    virtual void GenerateVertices(vector<float>& vertices, unsigned char flags = 0) const = 0;
    virtual void GenerateLineIndices(vector<unsigned short>& indices) const = 0;
    virtual void GenerateTriangleIndices(vector<unsigned short>& indices) const = 0;
    virtual ~ISurface() {}
};

struct ParametricInterval {
    ivec2 Divisions;
    vec2 UpperBound;
    vec2 TextureCount;
};

class ParametricSurface : ISurface {
public:
    int GetVertexCount() const;
    int GetLineIndexCount() const;
    int GetTriangleIndexCount() const;
    void GenerateVertices(vector<float>& vertices, unsigned char flags) const;
    void GenerateLineIndices(vector<unsigned short>& indices) const;
    void GenerateTriangleIndices(vector<unsigned short>& indices) const;
protected:
    void SetInterval(const ParametricInterval& interval);
    virtual vec3 Evaluate(const vec2& domain) const = 0;
    virtual bool InvertNormal(const vec2& domain) const { return false; }
private:
    vec2 ComputeDomain(float i, float j) const;
    vec2 m_upperBound;
    ivec2 m_slices;
    ivec2 m_divisions;
};

#endif /* ParametricSurface_hpp */
