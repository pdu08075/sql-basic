USE practice_sql;

-- 제약조건: 데이터베이스 테이블 컬럼에 삽입, 수정, 삭제 시 적용되는 규칙

-- NOT NULL 제약조건: 해당 컬러메에 null을 포함하지 못하도록 제약
-- (자기 자신 테이블 INSERT, UPDATE)에 영향을 미침
CREATE TABLE not_null_table (
	null_column INT NULL,
    not_null_column INT NOT NULL
);

-- NOT NULL 제약조건이 걸린 컬럼에 값을 지정하지 않음
INSERT INTO not_null_table (null_column) VALUES (1);
-- NOT NULL 제얒ㄱ조건이 걸린 컬럼에 null을 지정함
INSERT INTO not_null_table VALUES (null, null);

INSERT INTO not_null_table VALUES (1, 1);
INSERT INTO not_null_table VALUES (null, 2);
INSERT INTO not_null_table (not_null_column) VALUES (2);

SELECT * FROM not_null_table;

-- NOT NULL 제약조거닝 걸린 컬럼은 null로 수정할 수 없음
UPDATE not_null_table SET not_null_column = null;

-- UNIQUE 제약조건: 해당 컬럼에 중복된 데이터를 포함할 수 없도록 하는 제약
-- (자기 자신 테이블 INSERT, UPDATE)에 영향을 미침
CREATE TABLE unique_table (
	unique_column INT UNIQUE,
    not_unique_column INT
);

INSERT INTO unique_table VALUES (1, 1);
-- UNIQUE로 지정된 컬럼은 중복된 데이터를 삽입할 수 없음
INSERT INTO unique_table VALUES (1, 1);
-- 
INSERT INTO unique_table VALUES (2, 1);

SELECT * FROM unique_table;

-- UNIQUE로 지정된 컬럼은 중복된 데이터로 수정할 수 없음
UPDATE unique_table SET unique_column = 3;
UPDATE unique_table SET unique_column = 1 WHERE unique_column = 2;

-- NOT NULL + UNIQUE = 후보키
-- 후보키: 테이블에서 각레코드를 고유하게 식별할 수 있는 속성
-- 기본키: 테이블에서 각레코드를 고유하게 식별하기 위해 후보키에서 선택한 속성
-- 대체키: 후보키에서 기본키를 제외한 나머지 속성들

-- PRIMARY KEY 제약조건: 트겅 컬럼을 기본키로 지정
-- (INSERT, UPDATE)에 영향을 미침
CREATE TABLE key_table (
	primary_column INT PRIMARY KEY,
    surrogate_column INT NOT NULL UNIQUE
);

-- PRIMARY KEY 제약조건은 NOT NULL, UNIQUE 제약조건을 모두 가지고 있음
INSERT INTO key_table VALUES(null, 1);
INSERT INTO key_table (surrogate_column) VALUES (1);

INSERT INTO key_table VALUES (1, 1);
INSERT INTO key_table VALUES (1, 2);

-- PRIMARY KEY 제약을 두 개 이상 지정 불가능
CREATE TABLE composite_table (
	primary1 INT PRIMARY KEY,
    primary2 INT PRIMARY KEY
);

CREATE TABLE composite_table (
	primary1 INT,
    primary2 INT,
    CONSTRAINT primary_key PRIMARY KEY (primary1, primary2)
);

-- FOREIGN KEY 제약조건: 특정 컬럼을 다른 테이블 혹은 같은 테이블의 기본키 커럼과 연결하는 제약
-- FOREIGN KEY 제약조건을 특정 컬럼에 적용할 떄는 반드시 데이터 타입이 참조하고자 하는 컬럼의 타입과 일치해야 함
CREATE TABLE foriegn_table (
	primary1 INT PRIMARY KEY,
    foreign1 INT,
    CONSTRAINT foreign_key FOREIGN KEY(foreign1)
    REFERENCES key_table(primary_column)
);

SELECT * FROM key_table;

INSERT INTO foriegn_table VALUES (1, 0);
INSERT INTO foriegn_table VALUES (1, 1);

SELECT * FROM foriegn_table;




