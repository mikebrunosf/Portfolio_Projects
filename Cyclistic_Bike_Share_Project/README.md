# Cyclistic Case Study – Bike Share Usage Analysis

## Executive Summary
This project analyzes **5.5 million rides** from Chicago’s Cyclistic bike-share program (Sept 2024 – Aug 2025).  
Using **SQL Server** for cleaning and analysis and **Tableau Public** for visualization, I compared usage patterns between **annual members** and **casual riders**.  
Key insights show that **members dominate weekday commuting**, while **casual riders take longer leisure rides on weekends**.  
Based on these findings, I recommend **targeted marketing campaigns** to convert casual riders into members, especially during peak summer months and leveraging the popularity of **electric bikes**.


## 1. Business Task
Cyclistic, a bike-share company in Chicago, wants to maximize revenue growth by converting more **casual riders** into **annual members**.  
**Key question:** *How do annual members and casual riders use Cyclistic bikes differently?*  

---

## 2. Stakeholders
- **Lily Moreno** – Director of Marketing  
- **Marketing Analytics Team** – provides analysis and insights  
- **Executive Team** – approves the marketing strategy  

---

## 3. Constraints
- Only use publicly available Divvy/Cyclistic data  
- Focus on the most recent 12 months of trip data (Sept 2024 – Aug 2025)  
- Ensure reproducibility of steps  

---

## 4. Tools / Environment
- **SQL Server** – data cleaning, transformations, analysis queries  
- **Tableau Public** – data visualization & dashboard  
- **Excel/CSV** – used as a bridge between SQL Server and Tableau Public  
- **Markdown** – documentation  

---

## 5. Data Dictionary (Shell)
Updated as datasets were ingested.  

| File Name                  | Rows   | Columns | Key Columns            | Notes                                |
|-----------------------------|--------|---------|------------------------|--------------------------------------|
| 2024-09-divvy-tripdata.csv  | ~800k  | 13      | ride_id, member_casual | Includes Aug 31, 2024 anomaly noted  |
| 2024-10-divvy-tripdata.csv  | ~600k  | 13      | ride_id, member_casual |                                      |
| …                           | …      | …       | …                      |                                      |
| 2025-08-divvy-tripdata.csv  | ~700k  | 13      | ride_id, member_casual |                                      |

---

## 6. Planned Transformations
- `ride_length = ended_at - started_at`  
- `day_of_week = DATENAME(WEEKDAY, started_at)`  
- `month = FORMAT(started_at, 'yyyy-MM')`  
- `hour_of_day = DATEPART(HOUR, started_at)`  

---

## 7. Data-Quality Rules
- Remove rides with `ride_length <= 0`  
- Remove extreme outliers (`ride_length > 24 hours`)  
- Ensure `started_at < ended_at`  
- Exclude missing values in key fields (ride_id, started_at, ended_at)  
- Document anomalies: missing station names, August 2024 partial data  

---

## 8. Target Metrics (Members vs Casuals)
- Total rides (overall + by user type)  
- Average ride length   
- Ride frequency by month  
- Ride frequency by day of week  
- Ride frequency by hour of day  
- Bike type usage split (classic / electric / scooter)  

---

## 9. Planned Visuals
- **Pie chart** – member vs casual split  
- **Bar chart** – monthly trends  
- **Bar chart** – day of week usage  
- **Line chart** – hourly ride patterns  
- **Stacked bar chart** – bike type breakdown  

---

## 10. Key Results
- **Membership split**: Members ~63%, Casuals ~36%  
- **Ride duration**: Members ~11 min vs Casuals ~19 min  
- **Ride frequency by day**: Members dominate weekdays; Casuals peak on weekends  
- **Seasonality**: Summer (Jun–Aug) highest, Winter lowest  
- **Bike type**: Electric bikes most popular for both groups  
- **Hourly usage**:  
  - Members → sharp peaks at 8AM & 5PM (commuting)  
  - Casuals → gradual increase from 8AM to 5PM  

---

## 11. Dashboard
Interactive dashboard built in Tableau Public:  
🔗 *[https://public.tableau.com/app/profile/mike.bruno4206/viz/CyclisticCaseStudy_17577719768690/Dashboard1?publish=yes]*  

Contains:  
- Membership pie chart  
- Ride frequency by day, month, and hour  
- Ride duration comparison  
- Bike type breakdown  

---

## 12. Business Recommendations
1. **Target casual riders** with promotions highlighting weekday commuting benefits of membership.  
2. **Seasonal campaigns** in summer when casual usage is highest.  
3. **Leverage electric bike popularity** with member-exclusive perks.  
4. Emphasize **cost and time savings** in membership marketing.  

---




