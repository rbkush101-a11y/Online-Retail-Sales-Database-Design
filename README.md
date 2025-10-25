# Online-Retail-Sales-Database-Design

📘 Introduction

This project demonstrates the design and implementation of a normalized SQL database for an e-commerce platform.
It simulates a real-world online retail system with entities like customers, products, orders, payments, and inventory.

The project was created as part of an SQL Developer Internship task to strengthen database design, normalization, and query writing skills.

🎯 Objective

To design a 3NF (Third Normal Form) database schema for an online retail store and perform key business analytics using SQL queries.

🧰 Tools & Technologies
MySQL Workbench — database design, schema creation, and queries
dbdiagram.io — ER diagram creation
GitHub — version control and project showcase

🗂️ Database Design Overview

Entities:
customer — Stores customer information
product — Contains product catalog details
orders — Tracks orders placed by customers
order_item — Line items per order
payment — Payment transactions linked to orders
inventory — Tracks available product stock

Relationships:
One customer → many orders
One order → many order items
One order → one or more payments
One product → many order items

🔧 Steps Followed
1. Created a dedicated database online_retail
2. Defined entities and relationships based on the e-commerce domain
3. Normalized the schema to Third Normal Form (3NF)
4. Created tables using DDL scripts with primary and foreign key constraints
5. Populated tables with sample data
6. Implemented analytical SQL queries for:
            1. Total revenue from successful payments
            2. Monthly revenue trend
            3. Best-selling products
            4. Customer lifetime value
7. Created a view v_order_summary to simplify order and payment tracking

🧩 Deliverables
✅ ER Diagram (via dbdiagram.io)
✅ SQL Schema (DDL statements)
✅ Sample Data (INSERT queries)
✅ Analytical SQL Queries & View
✅ README Documentation

🏁 Conclusion
This project demonstrates strong understanding of database normalization, schema design, and data analysis with SQL.
It forms a solid foundation for building scalable database-backed applications or preparing for SQL developer interviews.

👨‍💻 Author

Rishabh Kushwaha
📧 rbkush101@gmail.com
🔗 www.linkedin.com/in/rishabh-kushwaha10