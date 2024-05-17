# Pipeline

1. Maak SQL scripts voor schams: RAW, ARCHIVED, CLEANSED
2. importeer source data in RAW
3. data cleaning => RAW naar ARCHIVED en CLEANSED
4. maak SQL scripts voor Data Warehouse/sterschema
5. import van CLEANSED naar DWH
6. prep data lake: exporteer tabellen naar parquet files
7. upload parquet files naar S3 (eerst bucket aanmaken)
8. maak Athena tables
9. gebruik Athena in BI tool naar keuze
