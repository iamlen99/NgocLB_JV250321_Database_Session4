USE `session_04_ex`;

-- Hiển thị tên công trình, tên chủ nhân và tên chủ thầu của công trình đó
SELECT b.`name`, h.`name`, c.`name`
FROM building AS b
INNER JOIN `host` AS h
INNER JOIN `contractor` AS c
ON b.`host_id` = h.`id` AND b.`contractor_id` = c.`id`;

-- Hiển thị tên công trình (building), tên kiến trúc sư (architect) và 
-- thù lao của kiến trúc sư ở mỗi công trình (design)
SELECT b.`name`, a.`name`, d.`benefit`
FROM building AS b
INNER JOIN `architect` AS a
INNER JOIN `design` AS d
ON b.`id` = d.`building_id` AND d.`architect_id` = a.`id`;

-- Hãy cho biết tên và địa chỉ công trình (building) do chủ thầu
-- Công ty xây dựng số 6 thi công (contractor)
SELECT b.`name` AS 'Tên công trình', b.`address` AS 'Địa chỉ công trình', c.`name` AS 'Chủ thầu'
FROM building AS b
INNER JOIN `contractor` AS c
ON b.`contractor_id` = c.`id`
WHERE c.name = 'cty xd so 6';

-- Tìm tên và địa chỉ liên lạc của các chủ thầu (contractor) thi công 
-- công trình ở Cần Thơ (building) do kiến trúc sư Lê Kim Dung thiết kế (architect, design)
SELECT c.`name` AS 'Tên chủ thầu', c.`address` AS 'Địa chỉ liên lạc', b.`name` AS 'Địa chỉ công trình', a.`name` AS 'Kiến trúc sư'
FROM contractor AS c
INNER JOIN `building` AS b
INNER JOIN `design` AS d
INNER JOIN `architect` AS a
ON b.`contractor_id` = c.`id` 
	AND d.`building_id` = b.`id`
    AND d.`architect_id` = a.`id`
WHERE a.name = 'le kim dung' AND b.`city` = 'can tho';

-- Hãy cho biết nơi tốt nghiệp của các kiến trúc sư (architect) đã 
-- thiết kế (design) công trình Khách Sạn Quốc Tế ở Cần Thơ (building)
SELECT a.`name` AS 'Kiến trúc sư', a.`place` AS 'Nơi tốt nghiệp', b.`name` AS 'Tên công trình'
FROM architect AS a
INNER JOIN `building` AS b
INNER JOIN `design` AS d
ON b.`id` = d.`building_id` 
	AND d.`architect_id` = a.`id`
WHERE b.`city` = 'can tho'
	AND b.`name` = 'khach san quoc te';
    
-- Cho biết họ tên, năm sinh, năm vào nghề của các công nhân có chuyên môn hàn
-- hoặc điện (worker) đã tham gia các công trình (work) mà chủ thầu Lê Văn Sơn 
-- (contractor) đã trúng thầu (building)
SELECT w.`name` AS 'Họ tên', w.`birthday` AS 'Năm sinh', w.`year` AS 'Năm vào nghề',
 w.`skill` AS 'Chuyên môn', c.`name` AS 'Tên chủ thầu'
FROM worker AS w
INNER JOIN `work` 
INNER JOIN `contractor` AS c
INNER JOIN `building` AS b
ON w.`id` = `work`.`worker_id` 
	AND `work`.`building_id` = b.`id`
    AND c.`id` = b.`contractor_id`
WHERE w.`skill` IN ('han', 'dien')
	AND c.`name` = 'le van son';
    
-- Những công nhân nào (worker) đã bắt đầu tham gia công trình Khách sạn Quốc Tế ở Cần Thơ 
-- (building) trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994 (work) số ngày tương ứng là bao nhiêu 
-- BỎ chưa cần làm

-- Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP Hồ Chí Minh (architect)
--  và đã thiết kế ít nhất một công trình (design) có kinh phí đầu tư trên 400 triệu đồng (building)
SELECT a.`name` AS 'Họ tên', a.`birthday` AS 'Năm sinh',
 a.`place` AS 'Nơi tốt nghiệp', b.`cost` AS 'Chi phí đầu tư'
FROM architect AS a
INNER JOIN `design` AS d
INNER JOIN `building` AS b
ON a.`id` = d.`architect_id` 
	AND d.`building_id` = b.`id`
WHERE b.`cost` > 400;

-- 	Cho biết tên công trình có kinh phí cao nhất
SELECT `name` AS 'Công trình có chi phí cao nhất', `cost` AS 'Chi phí' FROM building
WHERE `cost` = (
	SELECT MAX(`cost`) FROM building
);

-- 	Cho biết tên các kiến trúc sư (architect) vừa thiết kế các công trình (design) do Phòng dịch vụ 
-- sở xây dựng (contractor) thi công vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
SELECT a.`name` AS 'Họ tên'
FROM architect AS a
INNER JOIN `design` AS d ON a.`id` = d.`architect_id` 
INNER JOIN `building` AS b ON d.`building_id` = b.`id`
INNER JOIN `contractor` AS c ON b.`contractor_id` = c.`id`
WHERE c.`name` IN ('phong dich vu so xd', 'le van son')
GROUP BY a.`name`, a.`id`
HAVING COUNT(DISTINCT c.`name`) = 2;

-- 	Cho biết họ tên các công nhân (worker) có tham gia (work) các công trình ở Cần Thơ (building) 
-- nhưng không có tham gia công trình ở Vĩnh Long
SELECT wkr.`name` AS 'Họ tên'
FROM worker AS wkr
INNER JOIN `work` AS wk ON wkr.`id` = wk.`worker_id` 
INNER JOIN `building` AS b ON wk.`building_id` = b.`id`
GROUP BY  wkr.`id`, wkr.`name`
HAVING 
	SUM(b.`city` = 'can tho') > 0 AND
    SUM(b.`city` = 'vinh long') = 0;

-- Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả các công trình 
-- do chủ thầu phòng Dịch vụ Sở xây dựng thi công
SELECT contractor.`name` AS 'Tên chủ thầu', building.`name` AS 'Tên công trình'
FROM contractor
INNER JOIN building ON contractor.`id` = building.`contractor_id` 
WHERE building.`cost` > (
	SELECT MAX(`cost`) FROM building AS b
	INNER JOIN contractor AS c ON c.`id` = b.`contractor_id`
	WHERE c.`name` = 'phong dich vu so xd'
);

-- Cho biết họ tên các kiến trúc sư có thù lao thiết kế một công trình nào đó dưới giá trị trung bình 
-- thù lao thiết kế cho một công trình
SELECT a.`name` AS 'Họ tên', b.`name` AS 'Tên công trình', b.`cost` AS 'Chi phí'
FROM architect AS a
INNER JOIN `design` AS d ON d.`architect_id` = a.`id`
INNER JOIN `building` AS b ON d.`building_id` = b.`id`
WHERE b.`cost` > (
	SELECT AVG(`cost`) FROM building
);

-- Tìm tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
SELECT a.`name` AS 'Họ tên', b.`name` AS 'Tên công trình', b.`cost` AS 'Chi phí'
FROM architect AS a
INNER JOIN `design` AS d ON d.`architect_id` = a.`id`
INNER JOIN `building` AS b ON d.`building_id` = b.`id`
WHERE b.`cost` = (
	SELECT MIN(`cost`) FROM building
);

-- Tìm họ tên và chuyên môn của các công nhân (worker) tham gia (work) các công trình
-- do kiến trúc sư Le Thanh Tung thiet ke (architect) (design)
SELECT DISTINCT w.`name` AS 'Họ tên công nhân'
FROM worker AS w
INNER JOIN `work` ON w.`id` = `work`.`worker_id` 
INNER JOIN `design` AS d ON `work`.`building_id` = d.`building_id`
INNER JOIN `architect` AS a ON d.`architect_id` = a.`id`
WHERE a.`name` ='le thanh tung';

-- Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
SELECT b.`name` AS 'Tên công trình', b.`city`, c.`name` AS 'Họ tên chủ thầu'
FROM contractor AS c
INNER JOIN `building` AS b ON b.`contractor_id` = c.`id`
GROUP BY b.`city`
HAVING COUNT(DISTINCT b.`city`) = 1;

SELECT DISTINCT
  c1.name AS contractor_1,
  c2.name AS contractor_2,
  b1.city AS shared_city
FROM building b1
JOIN contractor c1 ON b1.contractor_id = c1.id

JOIN building b2 ON b1.city = b2.city
JOIN contractor c2 ON b2.contractor_id = c2.id

WHERE c1.id < c2.id ;

-- Tìm tổng kinh phí của tất cả các công trình theo từng chủ thầu
SELECT c.`name` AS 'Tên chủ thầu', SUM(b.`cost`) AS 'Tổng chi phí'
FROM contractor AS c
INNER JOIN `building` AS b ON b.`contractor_id` = c.`id`
GROUP BY c.`id`;

-- Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các 
-- công trình lớn hơn 25 triệu
SELECT a.`name` AS 'Tên kiến trúc sư', SUM(d.`benefit`) AS 'Tổng thù lao'
FROM architect AS a
INNER JOIN `design` AS d ON d.`architect_id` = a.`id`
GROUP BY a.`id`
HAVING SUM(d.`benefit`) > 25;

-- Cho biết số lượng các kiến trúc sư có tổng thù lao thiết kế các
-- công trình lớn hơn 25 triệu
SELECT COUNT(`id`) AS 'Số lượng kiến trúc sư' FROM (
	SELECT a.`id` 
	FROM architect AS a
	INNER JOIN `design` AS d ON d.`architect_id` = a.`id`
	GROUP BY a.`id`
-- 	HAVING SUM(d.`benefit`) > 25
) AS count_architect;

-- Tìm tổng số công nhân đã than gia ở mỗi công trình
SELECT b.`name` AS 'Tên công trình', COUNT(wk.`worker_id`) AS 'Tổng số công nhân'
FROM building AS b
LEFT JOIN `work` AS wk ON b.`id` = wk.`building_id`
GROUP BY b.`id`;

-- Tìm tên và địa chỉ công trình có tổng số công nhân tham gia nhiều nhất
SELECT b.`name` AS 'Tên công trình', b.`address` AS 'Địa chỉ công trình', COUNT(wk.`worker_id`) AS 'Tổng số công nhân'
FROM building AS b
LEFT JOIN `work` AS wk ON b.`id` = wk.`building_id`
GROUP BY b.`id`
HAVING COUNT(wk.`worker_id`) >= ALL(
	SELECT COUNT(`worker_id`)
	FROM `work`
    GROUP BY `building_id`
);

-- Cho biêt tên các thành phố và kinh phí trung bình cho mỗi công trình của từng thành phố tương ứng
SELECT b.`city` AS 'Tên thành phố', AVG(b.`cost`) AS 'Kinh phí trung bình'
FROM building AS b
GROUP BY b.`city`;

-- Cho biết họ tên các công nhân có tổng số ngày tham gia vào các công trình lớn hơn tổng số ngày 
-- tham gia của công nhân Nguyễn Hồng Vân
SELECT wkr.`name` AS 'Họ tên', SUM(wk.`total`) AS 'Tổng số ngày tham gia'
FROM worker AS wkr
INNER JOIN `work` AS wk ON wkr.`id` = wk.`worker_id` 
GROUP BY  wkr.`id`,  wkr.`name`
HAVING SUM(wk.`total`) > (
	SELECT SUM(`work`.`total`) 
	FROM `work` 
	INNER JOIN worker ON worker.`id` = `work`.`worker_id` 
	WHERE worker.`name` = 'nguyen hong van'
);

-- Cho biết tổng số công trình mà mỗi chủ thầu đã thi công tại mỗi thành phố
SELECT c.`name` AS 'Tên chủ thầu', b.`city`, COUNT(b.`contractor_id`) AS 'Tổng số công trình'
FROM contractor AS c
INNER JOIN `building` AS b ON b.`contractor_id` = c.`id`
GROUP BY b.`contractor_id`, b.`city`;

-- Cho biết họ tên công nhân có tham gia ở tất cả các công trình
SELECT  wkr.`name` AS 'Tên công nhân'
FROM worker AS wkr
INNER JOIN `work` AS wk ON wk.`worker_id` = wkr.`id`
INNER JOIN building AS b ON b.`id` = wk.`building_id`
GROUP BY wk.`worker_id`
HAVING COUNT(wk.`building_id` ) = ( 
	SElECT COUNT(`id`) FROM building
);






