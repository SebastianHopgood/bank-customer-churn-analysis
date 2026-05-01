# 🏦 **Bank Customer Churn Analysis**

## 📌 **Project Overview**

This project analyzes customer churn behavior using a banking dataset containing customer demographic, financial, and account activity information. The dataset includes attributes such as age, credit score, geography, account balance, number of products, and customer activity status. The goal is to explore patterns in customer behavior and identify key factors associated with churn. The analysis is performed using SQL for data exploration and Power BI for interactive visualization.

## ❓ **Problem Statement**

The bank is currently facing a 20.4% customer churn rate, with a significant $384.64M in balance at risk. While 51.5% of the customer base remains active, a critical segment—primarily middle-aged female customers in Germany with high account balances—is churning at an accelerated rate.

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
* Middle aged people ages 50-59 have the highest churn rate (56%). Age groups 40-49 and 60-69 also have high churn rates which are 31% and 35%.
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

### **6. Number of Products vs Churn Rate**
* Customers with 2–3 products are the most loyal (12% churn), while those with only one product are twice as likely to leave (28%), and those with 4+ products show a 100% churn rate.
* Note, 4+ products has a low sample size of 60/10000 customers which is not enough to determine an accurate answer.
* [View SQL Query](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/3c1277b6de565995a52534455967439263b34a3a/sql/analysis_queries/num_of_products_vs_churn_rate.sql)

### **7. Creating a Risk Score Calculator**
* By using the previous 6 analysis queries I was able to develop a calculator to predict weather customers are at low, medium and critical risk. I added 2 columns 'risk_score' and 'risk_group'.
* Here is the churn rate for each risk group: Critical Risk = 42%, Medium Risk = 11%, Low Risk = 3%.

**Picture of Risk Calculator Query:**
* ![image alt](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/fe012f24e12a7503b494818629c650f4dc1bd714/images/code%20pictures/risk_calculator_readme.png)

## 📈 **Power BI Dashboards**
The visualization phase is split into two strategic layers to move from broad context to actionable customer churn insights.

**Page 1: Bank Market Overview (The "Baseline")**

Before analyzing why customers leave, it is critical to understand the bank's current footprint. This page provides a comprehensive profile of the 10,000 customers to establish a "source of truth" for stakeholders to relate it to sample size and total customer contributions for each grouping. 

**Key points to take away from Market Overview:**
* **Geographic Distribution:** France accounts for 50% of the customer base, while Germany and Spain each hold 25%.
* **Balance Distribution:** Customer balances are highly polarized, with most individuals falling into either the "Low" or "High" balance brackets.
* **Product Penetration:** 99% of customers hold 1–3 products; adoption of 4+ products is extremely rare (0.77%).
* **Customer Tenure:** The portfolio is primarily mid-term, with 35.3% of the total base (approx. 3,500 customers) remaining long-term.
* **Demographics:** The majority of the customer base is female and falls within the middle-age bracket.
* **Risk Profile:** The portfolio is segmented into Low Risk (2k), Medium Risk (4.4k), and Critical Risk (3.6k) categories.
* **Key Performance Indicators (KPIs):**
  * Total Customers: 10,000
  * Average Age: 38.9 years
  * Average Tenure: 5 years
  * Activity Rate: 51.5% of lifetime customers remain active.

**Dashboard Preview:**
* ![image alt](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/9cca5c8276c229bb766ca7f0774e83c792012801/images/dashboard%20pictures/bank_market_overview_dashboard_preview_done.png)

**Page 2: Customer Churn Breakdown (The "Diagnostic")**
Once the baseline is established, this page isolates the variables driving customer chrum changes.

**Key points to take away from Churn Breakdown:**
* **Overall Churn Rate:** The benchmark churn rate for the bank is 20.4%.
* **Balance vs. Churn Correlation:** A direct correlation exists between higher account balances and increased churn risk. While the "low balance" segment shows the highest nominal rate, the small sample size (0.77% of customers) requires further validation.
* **Demographic Vulnerability:**
   * **Age:** Customers aged 40–60 exhibit the highest attrition rate across all age brackets.
   * **Gender:** Females have a significantly higher churn rate (25%) compared to males (16%).
* **Critical Risk Profile:** Customers classified as "Critical Risk" have a 41.7% churn rate. Typical attributes in this segment include:
  * Ages 40–59 and female.
  * High account balances in Germany.
  * Inactive membership status.
  * Holding only 1 or 4+ products.
* **Product "Sweet Spot":** Holding 2–3 products is the optimal engagement level, resulting in the lowest observed churn rates.
* **Geographic Risk:** Germany is the highest-risk region, with more total churned customers than France and Spain combined

**Dashboard Preview:**
* ![image alt](https://github.com/SebastianHopgood/bank-customer-churn-analysis/blob/882e7e95ac359ab3c072768b4b1c9d7589075d81/images/dashboard%20pictures/customer_churn_breakdown_dashboard_preview.png)

## 💡 **Recommendations**

* **Targeted Retention for "Critical Risk" Segments:** Implement a loyalty or "save" program specifically for female customers in Germany aged 40–60. This segment represents the highest concentration of churn and "Balance at Risk."
* **Product Diversification:** Since 2–3 products is the "sweet spot" for retention, launch a cross-selling campaign to move customers holding only 1 product into a 2-product tier.
* **Re-engagement of Inactive Members:** With inactive members churning at 26.9%, the bank should use personalized email triggers or interest-rate incentives to bring inactive users back into the app or service.
* **Balance-Tier Incentives:** High-balance customers are churning at a higher rate. The bank should offer "Premier" or "Gold" tier benefits (e.g., dedicated support, better rates) to high-value individuals to increase their switching costs.
* **Germany-Specific Market Research:** Conduct a deep dive into the German market. Since its churn is higher than France and Spain combined, there may be a competitive local bank or a specific service gap in that region.
* **Address the "4+ Product" Outlier:** Investigate why churn spikes for the 77 customers with 4+ products. This often indicates "product fatigue" or poor user experience when managing multiple accounts.

Key patterns in churn behavior were identified, and actionable recommendations were provided to improve customer retention.

## ⚠️ **Data Limitations & Future Work**

The analysis is based on a single dataset and does not include external behavioral or time-series data. Future work could include predictive modeling.
