# Allianz Customer Segmentation & Personalization

This project aims to optimize Allianz’s online insurance policy conversion rates through data-driven customer segmentation and predictive modeling. Built as part of a capstone project at the University of New Haven, it integrates structured data warehousing, clustering techniques, classification models, and a Power BI dashboard to deliver actionable insights for marketing personalization and lead prioritization.

---

## Executive Summary

Allianz faced a significant challenge: its online insurance platform lagged 12% behind competitors in policy conversion rates. This project addresses that gap using a machine learning–driven approach that analyzes customer, policy, and regional data. By building a data warehouse, segmenting customers, and predicting conversion probabilities, we aimed to uncover behavioral and financial patterns influencing purchase decisions and present them through a business intelligence dashboard.

---

## Key Business Outcomes

- **Segmented 25,000+ customers** into distinct clusters for targeted marketing, identifying a high-value segment with a **32% higher conversion likelihood**.
- **Predicted conversion likelihood** using logistic regression and random forest models, enabling sales prioritization and automation strategies.
- **Delivered an interactive Power BI dashboard** with 12+ KPIs, supporting Allianz’s marketing and strategy teams with region, income, and product-level insights.

---

## Data Preparation

Three datasets were provided by Allianz:

- **Funnel Data:** Policy quote journeys and conversion status.
- **Policy Data:** Customer financial profiles, car details, and demographics.
- **Regional Data:** ZIP-code level education and income metrics.

### Key Preparation Steps:
- Removed columns with > 40% missing data.
- Imputed missing values using median (numeric) and mode (categorical).
- Engineered new features including `Age`, `Conversion_Status`, and normalized income and savings fields.
- Encoded categorical variables and removed outliers via IQR filtering.
- Normalized numerical features to improve clustering performance.
- Split data into training and validation sets for supervised modeling.

---

## Predictive Modeling

### **Unsupervised Learning: Clustering**
- Applied **K-Means** and **Hierarchical Clustering** in R to identify customer segments.
- Identified 2 distinct clusters:
  - **Cluster A**: High-income, car-owning individuals with no loans—ideal for premium products.
  - **Cluster B**: Lower-income and higher loan burden—requiring tailored outreach.

- *Silhouette Score:* 0.195 — indicating moderate clustering but meaningful business segments.

### **Supervised Learning: Classification**
Models trained to predict conversion likelihood:

| Model              | Accuracy | Sensitivity | Specificity | Kappa   |
|--------------------|----------|-------------|-------------|---------|
| Logistic Regression| 82.0%    | Moderate    | 39.0%       | 0.0064  |
| Random Forest      | 75.4%    | **91.2%**   | 3.5%        | Higher  |

- **Random Forest** outperformed in sensitivity, making it effective for identifying likely converters.
- **Class imbalance** affected specificity; SMOTE and balanced weights were explored for future use.

---

## Recommendations & Conclusions

### Recommendations:
- Integrate the **random forest model into Allianz's CRM** to enable real-time lead scoring.
- **Target Cluster A** customers with premium policy campaigns via email and digital channels.
- Focus on **South Holland and Gelderland**, which showed higher conversion potential.
- Use insights from **income and car ownership** as strong signals in lead qualification.

### Conclusions:
- Financial factors like **income, loan status, savings**, and **car ownership** are strong predictors of policy conversion.
- **Segmented marketing strategies** are key to increasing online conversions.
- Combining data engineering, machine learning, and dashboarding enables Allianz to make faster, more accurate business decisions.

---



