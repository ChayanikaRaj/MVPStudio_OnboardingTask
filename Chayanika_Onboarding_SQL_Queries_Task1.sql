


-------> Ques(a). Display a list of all property names and their property id’s for Owner Id: 1426. 

             SELECT p.Name AS PropertyNames, op.PropertyId, op.OwnerId
             FROM OwnerProperty AS op
             INNER JOIN Property AS p ON p.Id = op.Id
             WHERE op.OwnerId = 1426

-------> Ques(b). Display the current home value for each property in question a).
  
             SELECT phv.PropertyId, op.OwnerId, phv.Value AS CurrentHomeValue
             FROM PropertyHomeValue AS phv
             INNER JOIN OwnerProperty AS op
             ON op.PropertyId = phv.PropertyId
             WHERE op.OwnerId = 1426 AND ISACTIVE ='1'
         

-------> Ques(c).For each property in question a), return the following:                                                                      
            (i) Using rental payment amount, rental payment frequency, tenant start date and 
             tenant end date to write a query that returns the sum of all payments from start date to end date. 
            (ii)Display the yield.

------> (i)
             SELECT p.Name AS PropertyName, op.PropertyId AS PropertyID, tp.StartDate AS StartDate, tp.EndDate AS EndDate, 
             tpf.Name AS TenantPaymentFrequencies, prp.Amount AS RentalPaymentAmount,
             CAST (((CASE
             WHEN tpf.Name = 'Weekly' THEN prp.Amount*52
	         WHEN tpf.Name = 'Fortnightly' THEN prp.Amount*26
	         WHEN tpf.Name = 'Monthly' THEN prp.Amount*12
             ELSE null END)/52)*DATEDIFF(Week,tp.StartDate,tp.EndDate) AS INT) AS TotalPayment
             FROM OwnerProperty AS op
             INNER JOIN Property AS p ON op.PropertyId = p.Id
             INNER JOIN PropertyRentalPayment AS prp ON prp.PropertyId = p.Id
             INNER JOIN TenantProperty AS tp ON tp.PropertyId =p.Id
             INNER JOIN TenantPaymentFrequencies AS tpf ON tpf.id = tp.PaymentFrequencyId
             WHERE Ownerid = 1426
 
 -----> (ii)  
             SELECT op.PropertyId, pf.Yield
             FROM PropertyFinance AS pf
             INNER JOIN OwnerProperty AS op On op.PropertyId = pf.PropertyId
             WHERE OwnerId =1426

--------> Ques(d). Display all the jobs available

             SELECT j.PropertyId, j.Id, j.JobDescription, js.Status, js.Id AS IsActive
             FROM Job AS j
             INNER JOIN JobMedia AS jm ON jm.JobId = j.Id
             INNER JOIN JobStatus AS js ON j.JobStatusId = js.Id
             WHERE js.Id = '1' AND Status = 'Open'

--------> Que(e). Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). 

             SELECT p.Name AS PropertyName, CONCAT(per.FirstName,' ' ,per.LastName) AS TenantName, tp.PaymentAmount, tpf.Name AS PaymentFrequency
             FROM OwnerProperty AS op
             INNER JOIN TenantProperty AS tp ON op.PropertyId = tp.propertyid
             INNER JOIN Property AS p ON p.Id = op.PropertyId
             INNER JOIN TenantPaymentFrequencies AS tpf ON tpf.Id = tp.paymentfrequencyid
             INNER JOIN Person AS per ON per.Id = tp.TenantId
             WHERE op.OwnerId = 1426		


 