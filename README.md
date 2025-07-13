# Flutter E-Commerce App - FakeStoreAPI

This is a mini e-commerce Flutter app that uses the FakeStoreAPI.
The app allows users to log in, browse products, manage their cart, and view their profile information.

---

## How to Run the App

### Requirements:
- Flutter SDK (3.29.3 )
- Android Studio
- Physical device ya emulator

### Steps:
1. Clone the repo:
   ```bash
   git clone https://github.com/usmandev46/mini_ecommerce_veevoTech.git 
   cd mini_ecommerce_veevoTech
   
### login details:
    "username": "mor_2314"
    "password": "83r5^_"
  
### What Features Are Working:

1. 🔐 Login
   User authentication via /auth/login
   Stores token securely
   Redirects to home screen upon successful login

2. 🛍️ Product Listing
   Fetches products from /products
   Displays product image, title, and price
   pull-to-refresh

3. 📄 Product Details
   Fetch detailed info from /products
   Shows full description, image, and price
   Includes "Add to Cart" button

4. 🛒 Cart Management
   Fetch user cart from /carts/user/:userId
   Display items with quantity and total
   Increase/decrease quantity
   PUT request to update cart

5. 👤 User Profile
   Fetches data from /users/:id
   Shows name, email, address, phone

6. 🌓 Dark Mode Toggle
   Switch between light and dark themes using BLoC

7. 🚪 Logout
   Clears stored token
   Navigates back to login screen


### Developer Info
    Muhammad Usman
    Email: usmandev46@gmail.com
    Phone: 0341-7021654
    Location: Islamabad, Pakistan