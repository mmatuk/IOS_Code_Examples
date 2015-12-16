//
//  ViewController.swift
//  LiquidMetal
//
//  Created by csit267-8 on 11/20/15.
//  Copyright © 2015 ccbcmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gravity: Float = 9.80665
    let ptmRatio: Float = 32.0
    let particleRadius: Float = 9
    var particleSystem: UnsafeMutablePointer<Void>!

    var device: MTLDevice! = nil
    var metalLayer: CAMetalLayer! = nil
    
    var particleCount: Int = 0
    var vertexBuffer: MTLBuffer! = nil
    
    func createMetalLayer() {
        device = MTLCreateSystemDefaultDevice()
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
    }
    
    func printParticleInfo()
    {
        let count = Int(LiquidFun.particleCountForSystem(particleSystem))
        print("There are \(count) particles present")
        
        let positions = UnsafePointer<Vector2D>(LiquidFun.particlePositionsForSystem(particleSystem))
        
        for i in 0..<count
        {
            let position = positions[i]
            print("particle: \(i) position: (\(position.x), \(position.y))")
        }
    }
    
    func refreshVertexBuffer () {
        particleCount = Int(LiquidFun.particleCountForSystem(particleSystem))
        let positions = LiquidFun.particlePositionsForSystem(particleSystem)
        let bufferSize = sizeof(Float) * particleCount * 2
        vertexBuffer = device.newBufferWithBytes(positions, length: bufferSize, options: MTLResourceOptions.CPUCacheModeDefaultCache)
    }
    
    func makeOrthographicMatrix(left left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) -> [Float] {
        let ral = right + left
        let rsl = right - left
        let tab = top + bottom
        let tsb = top - bottom
        let fan = far + near
        let fsn = far - near
        
        return [2.0 / rsl, 0.0, 0.0, 0.0,
            0.0, 2.0 / tsb, 0.0, 0.0,
            0.0, 0.0, -2.0 / fsn, 0.0,
            -ral / rsl, -tab / tsb, -fan / fsn, 1.0]
    }
    
    var uniformBuffer: MTLBuffer! = nil
    
    func refreshUniformBuffer () {
        // 1
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = Float(screenSize.width)
        let screenHeight = Float(screenSize.height)
        let ndcMatrix = makeOrthographicMatrix(left: 0, right: screenWidth,
            bottom: 0, top: screenHeight,
            near: -1, far: 1)
        var radius = particleRadius
        var ratio = ptmRatio
        
        // 2
        let floatSize = sizeof(Float)
        let float4x4ByteAlignment = floatSize * 4
        let float4x4Size = floatSize * 16
        let paddingBytesSize = float4x4ByteAlignment - floatSize * 2
        let uniformsStructSize = float4x4Size + floatSize * 2 + paddingBytesSize
        
        // 3
        uniformBuffer = device.newBufferWithLength(uniformsStructSize, options: MTLResourceOptions.CPUCacheModeDefaultCache)
        let bufferPointer = uniformBuffer.contents()
        memcpy(bufferPointer, ndcMatrix, float4x4Size)
        memcpy(bufferPointer + float4x4Size, &ratio, floatSize)
        memcpy(bufferPointer + float4x4Size + floatSize, &radius, floatSize)
    }
    
    var pipelineState: MTLRenderPipelineState! = nil
    var commandQueue: MTLCommandQueue! = nil
    
    func buildRenderPipeline() {
        // 1
        let defaultLibrary = device.newDefaultLibrary()
        let fragmentProgram = defaultLibrary?.newFunctionWithName("basic_fragment")
        let vertexProgram = defaultLibrary?.newFunctionWithName("particle_vertex")
        
        // 2
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexProgram
        pipelineDescriptor.fragmentFunction = fragmentProgram
        pipelineDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm
        
        do
        {
            pipelineState =  try device.newRenderPipelineStateWithDescriptor(pipelineDescriptor)
        } catch
        {
            print("Error occurred when creating render pipeline state: \(error)");
        }

        // 3
        commandQueue = device.newCommandQueue()
    }
    
    func render() {
        let drawable = metalLayer.nextDrawable()
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable!.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].storeAction = .Store
        renderPassDescriptor.colorAttachments[0].clearColor =
            MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        
        let commandBuffer = commandQueue.commandBuffer()
        
        if let renderEncoder: MTLRenderCommandEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor) {
            renderEncoder.setRenderPipelineState(pipelineState)
            renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
            renderEncoder.setVertexBuffer(uniformBuffer, offset: 0, atIndex: 1)
            
            renderEncoder.drawPrimitives(.Point, vertexStart: 0, vertexCount: particleCount, instanceCount: 1)
            renderEncoder.endEncoding()
        }
        
        commandBuffer.presentDrawable(drawable!)
        commandBuffer.commit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LiquidFun.createWorldWithGravity(Vector2D(x: 0, y: -gravity))
        
        particleSystem = LiquidFun.createParticleSystemWithRadius(
            particleRadius / ptmRatio, dampingStrength: 0.2, gravityScale: 1, density: 1.2)
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = Float(screenSize.width)
        let screenHeight = Float(screenSize.height)
        
        LiquidFun.createParticleBoxForSystem(particleSystem,
            position: Vector2D(x: screenWidth * 0.5 / ptmRatio, y: screenHeight * 0.5 / ptmRatio),
            size: Size2D(width: 50 / ptmRatio, height: 50 / ptmRatio))
        
        createMetalLayer()
        refreshVertexBuffer()
        refreshUniformBuffer()
        buildRenderPipeline()
        render()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

