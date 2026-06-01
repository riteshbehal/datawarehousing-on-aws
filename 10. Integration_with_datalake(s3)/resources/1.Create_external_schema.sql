CREATE EXTERNAL SCHEMA demo_spectrum_schema
FROM DATA CATALOG
DATABASE 'demo_spectrum_db'
IAM_ROLE 'arn:aws:iam::<account-id>:role/redshift-spectrum-role'
CREATE EXTERNAL DATABASE IF NOT EXISTS;