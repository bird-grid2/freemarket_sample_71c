class ShippingMethod < ActiveHash::Base
  self.data = [
    {id: 1, name: 'らくらくFURIMA便'},
    {id: 2, name: 'ゆうパック便'},
    {id: 3, name: 'クロネコヤマト便'},
    {id: 4, name: '普通郵便'}
  ]
end 