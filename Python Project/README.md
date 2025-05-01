# Banking Dashboard Project

## Overview
This project presents an analytical dashboard for banking data using Python. It includes data preprocessing, exploration, and visualizations to derive insights from customer and account-related information. The project is developed in a Jupyter Notebook using popular data science libraries.

## Tools and Libraries Used
- **Python**: The primary programming language for scripting and analysis.
- **pandas**: Used extensively for data manipulation, cleaning, and transformation.
- **numpy**: Utilized for numerical operations and efficient data processing.
- **matplotlib**: Used for creating static visualizations to represent data trends.
- **seaborn**: Leveraged for advanced and aesthetically pleasing statistical plots.

## Data Source
- The banking dataset was sourced from a **MySQL Server**.
- Connected to the database using the `mysql-connector-python` library and imported data directly into pandas DataFrames.
- This integration allowed seamless analysis of live or staged data using Python.

## What I Worked On
- **Data Cleaning & Preprocessing**: Loaded raw banking datasets, handled missing values, formatted columns, and created new calculated fields using `pandas`.
- **Exploratory Data Analysis (EDA)**: Performed in-depth exploration of data distributions and trends using `seaborn` and `matplotlib`.
- **Visualizations**:
  - Account distribution by type and customer segments.
  - Monthly or yearly transaction and balance trends.
  - Correlation heatmaps and histograms to understand patterns.
- **Statistical Insights**: Used `numpy` for calculating descriptive statistics and transformations to enhance data quality.
- **Dashboard Development**: Designed a clean and readable dashboard layout within a Jupyter Notebook for easy interpretation of results.

## How to Run
1. Clone this repository or download the notebook file.
2. Install the required libraries:
   ```bash
   pip install pandas numpy matplotlib seaborn
   ```
3. Open the notebook in Jupyter or VS Code and run all cells sequentially.

## Sample Code Used
```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

df = pd.read_csv("bank_data.csv")
sns.countplot(x='Account_Type', data=df)
plt.show()
```

## Notes
- This project does not include any personally identifiable or sensitive financial information.
- It is intended for educational and demonstrative purposes only.
