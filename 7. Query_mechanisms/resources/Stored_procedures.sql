-- creating stored procedure
Create or replace procedure update_sales_price(v_sales_id INT, v_new_price DECIMAL(8,2))
Language plpgsql
AS $$
Begin
  update sales
  SET pricepaid = v_new_price
  where salesid = v_sales_id;
  if not found then
    raise notice ‘no sales record found for sales id %’, v_sales_id;
  end if;
End;
$$;

-- calling the stored procedure for non existing salesid
Call update_sales_price(1234567, 100.00);

-- calling the stored procedure for existing salesid
Call update_sales_price(123456, 3300.00);

-- query to get data for existing salesid
Select * from sales where salesid = 123456