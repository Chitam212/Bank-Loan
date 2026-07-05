select * from dbo.financial_loan
---KPI
--Tong khoan vay va tong tien giải ngân
select COUNT(id) from dbo.financial_loan
select sum(loan_amount) from dbo.financial_loan

--
-- Đơn xin khoang vay trong tùng tháng
SELECT 
MONTH(issue_date) as 'Thang',
count(id) as 'Tong so ma vay'
FROM dbo.financial_loan
group by MONTH(issue_date)
order by count(id) desc

-- Đơn xin khoang vay trong tùng tháng
SELECT 
Day(issue_date) as 'Ngay',
count(id) as 'Tong so ma vay'
FROM dbo.financial_loan
group by Day(issue_date)
order by count(id) desc


--Lai xuat trung binh trong tung thang 
SELECT 
MONTH(issue_date) as 'Thang',
avg(int_rate)*100 as 'Lai xuat'
FROM dbo.financial_loan
group by MONTH(issue_date)
order by avg(int_rate) desc



--Thang ma bank giai ngan cao nhat va giai ngan bao nhieu?
select month(issue_date) as thang, sum(loan_amount) as 'Tong tien giai ngan'
from dbo.financial_loan 
group by month(issue_date)
order by sum(loan_amount) desc
--Thang g

--Tong khach hang. khach hang dã tra het du no va doanh thu (Good Loan)
select COUNT(id) as 'Good Loan'from dbo.financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current' 

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM dbo.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


---BAD LOAN ISSUED
SELECT COUNT(id) AS Bad_Loan_Applications FROM dbo.financial_loan
WHERE loan_status = 'Charged Off'

--TI LE NO XAU
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM dbo.financial_loan

--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM dbo.financial_loan
WHERE loan_status = 'Charged Off'

--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM dbo.financial_loan
WHERE loan_status = 'Charged Off'


--LOAN STATUS
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM dbo.financial_loan
GROUP BY loan_status

--Loi nhuan cua tung thang
SELECT 
    MONTH(issue_date) as 'Month',
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount ,
    SUM(total_payment) - SUM(loan_amount) AS Profit,
    (SUM(total_payment) - SUM(loan_amount))/SUM(loan_amount) *100  as 'Profit Rate'
FROM dbo.financial_loan
GROUP BY MONTH(issue_date) 
order by SUM(total_payment) desc

