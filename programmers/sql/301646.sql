-- https://school.programmers.co.kr/learn/courses/30/lessons/301646

-- GENOTYPE의 2 비트가 꺼져 있으면서 1 또는 4 비트가 켜진 레코드 개수를 계산
SELECT COUNT(ID) AS COUNT
FROM ECOLI_DATA
WHERE GENOTYPE & 2 = 0
  AND (GENOTYPE & 1 = 1 OR GENOTYPE & 4 = 4);

-- GENOTYPE의 2 비트가 꺼져 있으면서 1 또는 4 비트(5 = 0b0101) 중 하나라도 켜진 레코드 개수를 계산
SELECT COUNT(ID) AS COUNT
FROM ECOLI_DATA
WHERE GENOTYPE & 2 = 0
  AND GENOTYPE & 5 > 0;

-- GENOTYPE을 이진 문자열로 변환한 후, 마지막 두 번째 비트가 1이 아닌 경우를 제외하고 1 또는 세 번째 비트가 1인 경우 개수를 계산
SELECT COUNT(1) AS COUNT
FROM (
    SELECT BIN(GENOTYPE) AS GENOSTR
    FROM ECOLI_DATA
) A
WHERE GENOSTR NOT LIKE '%1_'
  AND (GENOSTR LIKE '%1' OR GENOSTR LIKE '%1__');

-- GENOTYPE의 하위 4비트를 이진 문자열로 변환 후, 두 번째 비트가 0이면서 마지막 비트 또는 세 번째 비트가 1인 경우 개수를 계산
SELECT COUNT(1) AS COUNT
FROM (
    SELECT LPAD(BIN(GENOTYPE & 15), 4, '0') AS GENOSTR
    FROM ECOLI_DATA
) A
WHERE GENOSTR LIKE '__0_'
  AND (GENOSTR LIKE '___1' OR GENOSTR LIKE '_1__');

-- GENOTYPE을 이진 문자열로 변환 후, 마지막 두 번째 비트가 1이 아닌 경우를 제외하고 마지막 비트 또는 세 번째 비트가 1인 경우 개수를 계산 (정규식을 사용)
SELECT COUNT(*) AS COUNT
FROM ecoli_data
WHERE BIN(genotype) NOT REGEXP('^*1.$')
  AND BIN(genotype) REGEXP('(^*1$)|(^*1..$)');
