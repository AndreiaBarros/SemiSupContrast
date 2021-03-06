require 'nn'
local model = nn.Sequential()
local feats = nn.Sequential()

-- Convolution Layers
feats:add(nn.SpatialConvolution(1, 16, 5, 5,1,1,1,1 ))
feats:add(nn.SpatialMaxPooling(2, 2))
feats:add(nn.ReLU(true))
feats:add(nn.SpatialBatchNormalization(16))

feats:add(nn.SpatialConvolution(16, 32, 3, 3,1,1,1,1))
feats:add(nn.ReLU(true))
feats:add(nn.SpatialBatchNormalization(32))

feats:add(nn.SpatialConvolution(32, 64, 3, 3,1,1,1,1))
feats:add(nn.ReLU(true))
feats:add(nn.SpatialBatchNormalization(64))

feats:add(nn.SpatialConvolution(64, 64, 3, 3,1,1,1,1))
feats:add(nn.SpatialMaxPooling(2, 2))
feats:add(nn.ReLU(true))
feats:add(nn.SpatialBatchNormalization(64))

feats:add(nn.SpatialConvolution(64, 128, 3, 3,1,1,1,1))
feats:add(nn.ReLU(true))
feats:add(nn.SpatialBatchNormalization(128))

local classifier = nn.Sequential()
classifier:add(nn.SpatialAveragePooling(6,6,1,1))
classifier:add(nn.View(-1):setNumInputDims(3))



model:add(feats):add(classifier)
model.inputSize = 28
model.reshapeSize = 28
model.inputMean = 128
model.inputStd = 128
model.regime = {
  epoch = {1,30,60,90,120},
  method = {'nag'},
  learningRate = {1e-1, 1e-2,1e-3,1e-4,1e-5}
}

return model
