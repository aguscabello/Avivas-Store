# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Crear categorías
shoes_category = Category.find_or_create_by!(name: 'Shoes')
clothing_category = Category.find_or_create_by!(name: 'Clothing')
accessories_category = Category.find_or_create_by!(name: 'Accessories')

# Crear colores
red_color = Color.find_or_create_by!(name: 'Red')
blue_color = Color.find_or_create_by!(name: 'Blue')
black_color = Color.find_or_create_by!(name: 'Black')

# Crear productos

# Producto 1: Zapatillas deportivas negras
shoes_product = Product.new(
  name: 'Zapatillas Country OG SFTM',
  category: shoes_category,
  color: black_color,
  description: 'Desde los puristas de la moda urbana hasta los amantes del calzado deportivo, todos encontrarán alguna razón para enamorarse de estas Country OG SFTM de adidas Originals',
  price: 189000,
  stock: 5
)

shoes_product.images.attach(
  io: File.open(Rails.root.join('app', 'assets', 'images', 'zapatillas1.jpg')),
  filename: 'zapatillas_negras_1.jpg'
)

shoes_product.save!


# Producto 2: Gorra rosa
hat_product = Product.new(
  name: 'Gorra Running x Adizero HEAT.RDY Liviana',
  category: accessories_category,
  color: red_color,
  description: 'Una gorra de running ligera hecha parcialmente con materiales reciclados. Competí como nunca con esta gorra de running adidas HEAT.RDY. Su estructura liviana no se interpone en tu camino, y la ventilación cortada a láser se encarga de que el sudor no interrumpa tu rutina. La correa en la parte posterior ayuda a conseguir un ajuste perfecto. Podés subir la visera o bajarla para protegerte de los rayos del sol.',
  price: 53999,
  stock: 30
)

hat_product.images.attach(
  io: File.open(Rails.root.join('app', 'assets', 'images', 'gorra.jpg')),
  filename: 'gorra_rosa_1.jpg'
)

hat_product.save!


# Producto 3: Camiseta de Argentina
shirt_product = Product.new(
  name: 'Camiseta Aniversario 50 Años Selección Argentina',
  category: clothing_category,
  color: blue_color,
  description: 'Una camiseta de Argentina que marca el inicio de una colaboración ganadora, hecha en parte con materiales reciclados.
Parte de un uniforme especial que conmemora el aniversario número 50 de la primera colaboración entre Argentina y avivas.',
  price: 180000,
  stock: 100
)

shirt_product.images.attach(
  io: File.open(Rails.root.join('app', 'assets', 'images', 'camiseta.jpg')),
  filename: 'camiseta_argentina_1.jpg'
)

# Guardar el producto
shirt_product.save!

puts "Se han creado los productos correctamente"

User.create!(
  username: "admin",
  email: "admin@example.com",
  phone: "123456789",
  password: "password",
  role: "admin",
  joining_date: Date.today,
  active: true
)

User.create!(
  username: "manager",
  email: "manager@example.com",
  phone: "987654321",
  password: "password",
  role: "manager",
  joining_date: Date.today,
  active: true
)
