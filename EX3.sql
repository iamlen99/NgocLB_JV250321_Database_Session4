USE `session_04_ex`;

-- Hien thi cong trinh co chi phi cao nhat
SELECT * FROM building
WHERE cost = (
	SELECT MAX(`cost`) FROM building
);  

-- Hien thi cong trinh co chi phi lon hon tat 
-- ca cong trinh duoc xay dung o Can Tho
SELECT * FROM building
WHERE cost > ALL (
	SELECT cost FROM building
    WHERE city = 'can tho'
);  
-- Tra ve bang rong vi khong co cong trinh nao co chi phi
-- lon hon tat ca cong trinh duoc xay dung o Can Tho

-- Hien thi cong trinh co chi phi lon hon mot trong cac cong 
-- trinh duoc xay dung o Can Tho
SELECT * FROM building
WHERE cost > ANY (
	SELECT cost FROM building
    WHERE city = 'can tho'
);

-- Hien thi cac cong trinh chua co kien truc su thiet ke

