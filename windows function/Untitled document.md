### **SQL Window Functions Explanation and Examples**

#### **Introduction to Window Functions**

SQL window functions are used for performing calculations across a set of table rows that are somehow related to the current row. These functions allow you to carry out data analysis tasks such as ranking, running totals, moving averages, and more, without having to group data into subsets. Window functions operate on a "window" of rows with a defined relationship to the current row.

#### **1\. Basic Window Function: ROW\_NUMBER()**

**Purpose**: Generates a unique sequential integer to each row, starting at 1 for the first row in each partition.

**SQL Query**:

`SELECT`  
    `EmpID,`  
    `DeptID,`  
    `EmpName,`  
    `Salary,`  
    `ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber`  
`FROM`  
    `Employees;`

**Explanation**: This query assigns a row number to each employee based on their salary in descending order. The employee with the highest salary gets the row number 1, the next gets 2, and so on.

#### **2\. Partitioning with ROW\_NUMBER()**

**Purpose**: Generates a unique number for each row to reset across partitions in the data.

**SQL Query**:

`SELECT`  
    `EmpID,`  
    `DeptID,`  
    `EmpName,`  
    `Salary,`  
    `ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS RowNumber`  
`FROM`  
    `Employees;`

**Explanation**: This example partitions the data by `DeptID`, so the row number resets for each department. Within each department, employees are numbered according to their salary in descending order.

#### **3\. RANK() and DENSE\_RANK()**

**Purpose**: Assigns a rank to each row within a partition of a result set, with gaps in the ranking for tied values in RANK, and no gaps for DENSE\_RANK.

**SQL Query**:

`SELECT`  
    `EmpID,`  
    `DeptID,`  
    `EmpName,`  
    `Salary,`  
    `RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS Rank,`  
    `DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS DenseRank`  
`FROM`  
    `Employees;`

**Explanation**: Both functions rank employees within each department based on salary. `RANK()` leaves gaps in the ranking if there are ties, whereas `DENSE_RANK()` does not. For instance, if two employees are tied for the highest salary, they both receive rank 1, but the next employee gets rank 3 with `RANK()` and rank 2 with `DENSE_RANK()`.

#### **4\. LAG() and LEAD()**

**Purpose**: Accesses data from a previous row (LAG) or a following row (LEAD) without the need for a self-join.

**SQL Query**:

`SELECT`  
    `EmpID,`  
    `EmpName,`  
    `Salary,`  
    `LAG(Salary, 1) OVER (ORDER BY Salary) AS PreviousSalary,`  
    `LEAD(Salary, 1) OVER (ORDER BY Salary) AS NextSalary`  
`FROM`  
    `Employees;`

**Explanation**: `LAG()` returns the salary of the previous row, and `LEAD()` returns the salary of the next row in the dataset ordered by salary. This is useful for comparing rows within a result set.

#### **Key Concepts**

* **Window Frame**: Refers to the set of rows considered by the function for each row. Defined using the `OVER()`clause.  
* **Partitioning**: The `PARTITION BY` keyword divides the data into partitions which the window function operates on independently.  
* **Ordering**: The `ORDER BY` in the `OVER()` clause is used to determine the order of the rows for processing by the window function.

