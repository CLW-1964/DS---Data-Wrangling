# load libraries
library(dplyr)
library(tidyr)

# 0: download csv file and create local dataframe
refine_original_df <- read.csv("~/Springboard/3_1 Data Wrangling Ex_1/refine_original.csv")

# 1: Clean up brand names
refine_original_df <- refine_original_df %>%
  mutate(company = tolower(company)) %>%
  mutate(company = sub('ak.*', 'akzo', company),
        company = sub('.*ps', 'philips', company),
        company = sub('un.*', 'unilever', company))

# 2: Separate the product code and product number into separate columns
# add two new columns called product_code and product_number
refine_original_df <- refine_original_df %>%
  separate(Product.code...number, c("product_code", "product_number"), sep = '-')
refine_original_df
# 3: Add product categories
refine_original_df <- refine_original_df %>%
  mutate("product_category" = case_when(
    product_code == 'p' ~ 'Smartphone',
    product_code == 'v' ~ 'TV',
    product_code == 'x' ~ 'Laptop',
    product_code == 'q' ~ 'Tablet'
  ) )

# 4: Adding full address
refine_original_df <- refine_original_df %>%
  unite('full_address', c("address", "city", "country"), sep = ',', remove = FALSE)

# 5: Create dummy variables for company and product category

refine_original_df <- refine_original_df %>%
  mutate("company_akzo" = if_else(company == 'akzo', 1,0),
         "company_philips" = if_else(company == 'philips', 1, 0),
         "company_unilever" = if_else(company == 'unilever', 1, 0),
         "company_van_houten" = if_else(company == 'van houten', 1, 0),
         
         "product_smartphone" = if_else(product_code == 'p', 1, 0),
         "product_tv" = if_else(product_code == 'v', 1, 0),
         "product_laptop" = if_else(product_code == 'x', 1, 0),
         "product_tablet" = if_else(product_code == 'q', 1, 0))

# 6: Create refine_clean csv



write.csv(refine_original_df, "~/Springboard/3_1 Data Wrangling Ex_1/refine_clean.csv" )