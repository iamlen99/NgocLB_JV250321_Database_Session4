USE `session_04_ex`;

-- Hien thi thu lao trung binh cua tung kien truc su
SELECT a.name, AVG(d.benefit) AS 'Thù lao trung bình'
FROM architect AS a
INNER JOIN design AS d
ON a.`id` = d.`architect_id`
GROUP BY d.`architect_id`;

-- Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố
SELECT city, SUM(cost) AS 'Chi phí đầu tư' 
FROM building
GROUP BY city ;

-- Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
SELECT `name`, SUM(`benefit`) AS 'Tổng thù lao' 
FROM (
	SELECT architect.name, design.benefit 
	FROM architect
	LEFT JOIN design
	ON `architect`.`id` = `design`.`architect_id`
) AS architect_benefit
GROUP BY `name`
HAVING SUM(`benefit`) > 50;

SELECT b.`name`, SUM(d.`benefit`) FROM building AS b
INNER JOIN design AS d
ON d.`building_id` = b.`id`
GROUP BY d.`building_id`
HAVING SUM(d.`benefit`) > 50;

-- Tìm các thành phố có ít nhất hai kiến trúc sư tốt nghiệp
SELECT DISTINCT `place` FROM architect
GROUP BY `place`
HAVING COUNT(id) >= 2;