DELIMITER $$

CREATE PROCEDURE IdentifyHighValueCustomersAtRisk()
BEGIN
    -- Declare variables
    DECLARE high_value_threshold DECIMAL(10, 2);
    DECLARE total_customers INT;
    
    -- Set high value threshold (adjust as needed)
    SET high_value_threshold = 1000; -- Example threshold
    
    -- Get total number of customers
    SELECT COUNT(*) INTO total_customers FROM customer_data;
    
    -- Calculate churn rate
    IF total_customers > 0 THEN
        -- Calculate average total charges
        SELECT AVG(total_charges) INTO @avg_total_charges FROM customer_data;
        
        -- Identify high-value customers at risk of churning
        SELECT 
            customer_id,
            total_charges
        FROM 
            customer_churn_data
        WHERE 
            total_charges > high_value_threshold
            AND total_charges < @avg_total_charges
            AND churn_status = 'Yes';
    END IF;
END$$

DELIMITER ;
