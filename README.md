# 🏦 **Bank Customer Churn Analysis**

## 📌 **Project Overview**

This project analyzes customer churn behavior using a banking dataset containing customer demographic, financial, and account activity information. The dataset includes attributes such as age, credit score, geography, account balance, number of products, and customer activity status. The goal is to explore patterns in customer behavior and identify key factors associated with churn. The analysis is performed using SQL for data exploration and Power BI for interactive visualization.

## ❓ **Problem Statement**

The bank is experiencing customer attrition and wants to understand why customers are leaving. The objective of this analysis is to identify the key drivers of churn by comparing churned and retained customers across demographic, financial, and behavioral factors, and to provide data-driven recommendations to improve customer retention.

## 📊 **Understanding Data**

### **1. Data Structure**
* The dataset contains 10,000+ customer records
* Each row represents 1 customer (no duplicates)
* Each column represents customer attributes such as demographics, account information, and activity status

### **2. Column Overview**
* RowNumber → customer row number in the database
* CustomerId → unique customer identifier
* Surname → customer last name
* CreditScore → current customer credit score
* Geography → country the customer lives in
* Gender → customer gender, only grouped into male and female
* Age → age of customer
* Tenure → how many years the customer has been with this bank
* Balance → current amount of money in the bank
* NumOfProducts → number of bank products used
* HasCrCard → true/false for if the customer has a credit card or not
* IsActiveMember → true/false for if the customer is active currently
* EstimatedSalary → customer current year estimated annual salary
* Exited → true/false for if customer has left the bank (churn)

### **3. Basic Dataset Snapshot** (no deep analysis)
* Customers exist across 3 different countries (Germany, France, Spain)
* Average customer age is 38.9 with a wide range which includes 18 - 92
* Mix of long and short staying customers
* Mix of low balance and high balance customers
* Mix of low income and hight income earners 

## 🧹 **Data Preparation**

### **1. Removing Irrelevant Columns**
* Removing 'RowNumber' becuase i already have a unique ID for every customer and it is irrelvant for analysis
* Removing Surname because it doesnt help customer analysis

### **2. Fixing Data Types**
* Changing 'HasCrCard' datatype from INT64 → BOOL
* Changing 'IsActiveMember' datatype from INT64 → BOOL
* Changing 'Exited' datatype from INT64 → BOOL

### **3. Checking Null and Outlier Data**
* There was no NULL values within the datset
* There is no outlier data, areas of intrest were: creditscore, age, balance, numofproducts, estimatedsalary, and all boolean columns that were previously and INT64

### **4. Data Standardization**
* Standardized column names to lowercase with snake_case formatting for consistency  
* Example: HasCrCard → has_credit_card, NumOfProducts → num_of_products
* Values for Balance and EstimatedSalary are assumed to be in EUR based on dataset context

### **5. Feature Engineering**
* Created Age groups (18-30, 31-50, 51+)
* Developed Balance groups (Low/Meduim/High)
* Organized Tenure groups (New = 0-2, Mid = 3-6, Long-Term = 7+)
* Generated NumOfProducts groups (1 product, 2-3 products, 4 products)

## 🔍 **Exploratory Data Analysis**

Analysis was performed to compare churned vs non-churned customers across key variables such as age, balance, geography, and engagement.

## 📈 **Power BI Dashboards**

An interactive dashboard was built to visualize churn rates, customer segments, and key drivers of churn for business interpretation.

## 💡 **Recommendations**

Key patterns in churn behavior were identified, and actionable recommendations were provided to improve customer retention.

## ⚠️ **Data Limitations & Future Work**

The analysis is based on a single dataset and does not include external behavioral or time-series data. Future work could include predictive modeling.
