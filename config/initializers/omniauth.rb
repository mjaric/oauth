Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'u6QRMBUhzeef9iWnGqBsNQ', 'zsFp9YKfu951JsFtS7Vq2GbjlIJAS1z1kkYhjPpOHQ'
  provider :facebook, '312896235499693', '218d8cbc9e9e5e8f3fb8b2590f4c7321'
end