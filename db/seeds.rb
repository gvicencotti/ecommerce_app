Product.create([
  { name: "Laptop", description: "A powerful laptop.", price: 999.99, stock: 10 },
  { name: "Headphones", description: "Noise-cancelling headphones.", price: 199.99, stock: 50 },
  { name: "Smartphone", description: "Latest model smartphone.", price: 799.99, stock: 20 }
])

DeliveryOption.create(name: 'Standard Delivery', price: 5.00)
DeliveryOption.create(name: 'Express Delivery', price: 10.00)
DeliveryOption.create(name: 'Next Day Delivery', price: 20.00)
