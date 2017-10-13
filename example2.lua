
disp = require ('./init.lua')

require 'image'
require 'socket'

require 'nn' -- for image upsampler
require 'torch' -- for generating matrixes

i = image.fabio()



thresholded = (i*10):long()+1 -- convert to 1-based index

-- create psudo-colours image


lut=image.jetColormap(10):t()

pseudo = lut:index(2,thresholded:view(-1)):view(3,thresholded:size()[1],thresholded:size()[2])


disp.image(i, { width=200, title='fabio', use_png=true})
disp.image(pseudo, { width=200, title='pseudo fabio', use_png=true})
