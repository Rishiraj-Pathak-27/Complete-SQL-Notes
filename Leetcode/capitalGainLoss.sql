-- 1393. Capital Gain/Loss

-- Write a solution to report the Capital gain/loss for each stock.
-- The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
-- Return the result table in any order.

SELECT s.stock_name AS stock_name,
       SUM(CASE
               WHEN s.operation_day = 'Sell' THEN s.price
               ELSE -price
           END) capital_gain_loss
FROM Stocks s
GROUP BY s.stock_name;