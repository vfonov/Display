
disp = require ('./init.lua')

require 'image'
require 'socket'

require 'nn' -- for image upsampler
require 'torch' -- for generating matrixes

i1 = image.lena()
i2 = image.fabio()

disp.image(i1, { title='lena' })

disp.images({i2, i2, i2, i2}, { width=200, title='super fabio', labels={'a', 'b', 'c', 'd'}})


-- use upsampler to show matrix as series of squares
local upsampler  = nn.SpatialUpSamplingNearest(20):float()

-- create a matrix with some noise
i3=torch.eye(10)+torch.rand(10,10)*0.3

-- displaying a matrix, upsampling it 10 times , using JPEG (default)
disp.image(torch.squeeze(upsampler:forward(i3:view(1,10,10):float())), { title='matrix in JPEG' })

-- displaying a matrix, upsampling it 10 times , use PNG for encoding to avoid JPEG artefacts, also compresses better
disp.image(torch.squeeze(upsampler:forward(image.y2jet(i3):float())), { title='jet matrix in PNG',use_png=true })



data = {}
for i=1,15 do
  table.insert(data, { i, math.random(), math.random() * 2 })
end

win = disp.plot(data, { labels={ 'position', 'a', 'b' }, title='progress' })

for i = 16,25 do
  socket.select(nil, nil, 0.2);
  table.insert(data, { i, math.random(), math.random() * 2 })
  disp.plot(data, { win=win })
end


