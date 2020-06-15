class Postage < ActiveHash::Base
  self.data = [
      {id: 1, name: '100'}, {id: 2, name: '200'}, {id: 3, name: '300'}
  ]
end
