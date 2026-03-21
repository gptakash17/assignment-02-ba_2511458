// OP1: insertMany() – insert all 3 documents

db.products.insertMany([
  {
    product_id: 1,
    name: "Smartphone",
    category: "Electronics",
    price: 25000,
    brand: "Samsung",
    specs: {
      ram: "8GB",
      storage: "128GB",
      battery: "5000mAh"
    },
    warranty_years: 1
  },
  {
    product_id: 2,
    name: "T-Shirt",
    category: "Clothing",
    price: 799,
    brand: "Nike",
    sizes: ["S", "M", "L", "XL"],
    material: "Cotton",
    color: "Black"
  },
  {
    product_id: 3,
    name: "Milk",
    category: "Groceries",
    price: 60,
    brand: "Amul",
    expiry_date: new Date("2024-12-30"),
    nutrition: {
      calories: 150,
      protein: "8g",
      fat: "5g"
    }
  }
]);

// OP2: find() – Electronics with price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: find() – Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

// OP4: updateOne() – add discount_percent
db.products.updateOne(
  { name: "Smartphone" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex()
db.products.createIndex({ category: 1 });

// Explanation:
// Index improves query speed when filtering by category