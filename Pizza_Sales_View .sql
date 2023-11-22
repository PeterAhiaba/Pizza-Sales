Create view Pizza_Sales_View AS
WITH PizzaSales AS (
    -- Your existing query remains the same
    SELECT
        o.order_id,
        o.`date`,
        CAST(o.`time` AS TIME) AS order_time,
        od.pizza_id,
        pt.`name` AS Pizza_Name,
        pt.category,
        pz.size,
        pz.price AS Unit_price,
        od.quantity,
        od.quantity * pz.price AS Amount_Per_Pizza
    FROM
        orders o
    JOIN
        order_details od ON o.order_id = od.order_id
    JOIN
        pizzas pz ON od.pizza_id = pz.pizza_id
    JOIN
        pizza_types pt ON pz.pizza_type_id = pt.pizza_type_id
)

SELECT
    order_id,
    `date`,
    order_time AS Original_Time,
    EXTRACT(HOUR FROM order_time) AS Hour_of_Day,
    pizza_id,
    Pizza_Name,
    category,
    size,
    Unit_price,
    SUM(quantity) AS Total_qty,
    SUM(Amount_Per_Pizza) AS Amount_per_order
FROM
    PizzaSales
GROUP BY
    order_id,
    `date`,
    order_time,
    EXTRACT(HOUR FROM order_time), -- Grouping by the hour of the day
    pizza_id,
    Pizza_Name,
    category,
    size,
    Unit_price