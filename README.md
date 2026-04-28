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
* Overall churn rate = 20.37%
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
* Changing 'HasCrCard' datatype from BOOL → INT64
* Changing 'IsActiveMember' datatype from INT64 → INT64
* Changing 'Exited' datatype from BOOL → INT64

### **3. Checking Null and Outlier Data**
* There was no NULL values within the datset
* There is no outlier data, areas of intrest were: creditscore, age, balance, numofproducts, estimatedsalary, and all boolean columns that were previously and INT64

### **4. Data Standardization**
* Standardized column names to lowercase with snake_case formatting for consistency  
* Example: HasCrCard → has_credit_card, NumOfProducts → num_of_products
* Values for Balance and EstimatedSalary are assumed to be in EUR based on dataset context
* Rounding columns 'Balance' and 'EstimatedSalary' to 1 decimal point

### **5. Feature Engineering**
* Created Age groups (18-30, 31-50, 51+)
* Developed Balance groups (Low/Meduim/High)
* Organized Tenure groups (New = 0-2, Mid = 3-6, Long-Term = 7+)
* Generated NumOfProducts groups (1 product, 2-3 products, 4 products)

**Picture of Data Preperation Query:**
* ![image alt](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/9ee4b1eb1139884356b5c116794e67d0c20a23be/images/code%20pictures/cleaning_raw_data_readme_picture.png)

## 🔍 **Exploratory Data Analysis**
This section focuses on identifying key patterns and relationships in the data that influence customer churn. Rather than listing all intermediate steps, it highlights the most meaningful insights.

### **1. Age Group vs Churn Rate**
* Older customers have significantly higher churn (45%) compared to younger customers (8%), indicating that churn risk increases with age.
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/age_group_vs_churn_rate.sql)

### **2. Active Member vs Churn Rate**
* Active members show a significantly lower churn rate (14%) compared to inactive members (27%), suggesting that customer engagement is strongly linked to retention.
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/active_member_vs_churn_rate.sql)

### **3. Balance Group vs Churn Rate**
* The High Balance group is the primary concern, with a 25% churn rate across nearly 4,800 customers.
* The data suggests as balance increases, so does the likelihood of churn.
* Note, low balance group has the highest churn rate although the sample size of 77/10000 customers which is not enough to determine an accurate answer.
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/balance_group_vs_churn_rate.sql)

### **4. Country vs Churn Rate**
* Germany has the highest churn rate (32%), while Spain (17%) and France (16%) are significantly lower.
* France makes up 1/2 of the customers, while Germany and Spain both contribute 1/4 each to total customers.
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/country_vs_churn_rate.sql)

### **5. Gender vs Churn Rate**
* Female customers exhibit a notably higher churn rate (25%) compared to males (16%).
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/gender_vs_churn_rate.sql)

### **6. Num of Products vs Churn Rate**
* Customers with 2–3 products are the most loyal (12% churn), while those with only one product are twice as likely to leave (28%), and those with 4+ products show a 100% churn rate.
* Note, 4+ products has a low sample size of 60/10000 customers which is not enough to determine an accurate answer.
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/num_of_products_vs_churn_rate.sql)

### **7. Creating a Risk Score Calculator**
* By using the previous 6 analysis queries I was able to develop a calculator to predict weather customers are at high risk or low risk. I added 2 columns 'risk_score' and 'risk_group'.
* Here are the percentages each risk group came out to: Critical Risk = 45%, Medium Risk = 19%, Low Risk = 8%.

**Picture of Risk Calculator Query:**
* ![image alt](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/f39ea00025efa90e2e411677a476fe3bdafc4b78/images/code%20pictures/risk_calculator_readme_picture.png)

## 📈 **Power BI Dashboards**

An interactive dashboard was built to visualize churn rates, customer segments, and key drivers of churn for business interpretation.

## 💡 **Recommendations**

Key patterns in churn behavior were identified, and actionable recommendations were provided to improve customer retention.

## ⚠️ **Data Limitations & Future Work**

The analysis is based on a single dataset and does not include external behavioral or time-series data. Future work could include predictive modeling.
