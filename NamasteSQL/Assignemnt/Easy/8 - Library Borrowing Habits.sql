SELECT 
  Borrowers.BorrowerName, 
  GROUP_CONCAT(Books.BookName ORDER BY Books.BookName ASC) AS BookList
FROM Borrowers
INNER JOIN Books ON Borrowers.BookID = Books.BookID
GROUP BY Borrowers.BorrowerName
ORDER BY Borrowers.BorrowerName ASC;