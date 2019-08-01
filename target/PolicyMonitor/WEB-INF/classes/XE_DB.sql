/*All User's gets stored in APP_USER table*/
create table APP_USER (
   id int NOT NULL,
   sso_id VARCHAR(30) NOT NULL,
   password VARCHAR(100) NOT NULL,
   first_name VARCHAR(30) NOT NULL,
   last_name  VARCHAR(30) NOT NULL,
   email VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (sso_id)
);
   
/* USER_PROFILE table contains all possible roles */ 
create table USER_PROFILE(
   id INTEGER NOT NULL ,
   type VARCHAR(30) NOT NULL,
   PRIMARY KEY (id),
   UNIQUE (type)
);
   
/* JOIN TABLE for MANY-TO-MANY relationship*/  
CREATE TABLE APP_USER_USER_PROFILE (
    user_id INTEGER NOT NULL,
    user_profile_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, user_profile_id),
    CONSTRAINT FK_APP_USER FOREIGN KEY (user_id) REFERENCES APP_USER (id),
    CONSTRAINT FK_USER_PROFILE FOREIGN KEY (user_profile_id) REFERENCES USER_PROFILE (id)
);
  
/* Populate USER_PROFILE Table */
INSERT INTO USER_PROFILE(id,type)
VALUES (1,'USER');
  
INSERT INTO USER_PROFILE(id,type)
VALUES (2,'ADMIN');
  
/* INSERT INTO USER_PROFILE(id,type)
VALUES (3,'DBA'); */
  
  
/* Populate one Admin User which will further create other users for the application using GUI- abc125 */
INSERT INTO APP_USER(id, sso_id, password, first_name, last_name, email)
VALUES (1,'sameer','$2a$10$4eqIF5s/ewJwHK1p8lqlFOEm2QIA0S8g6./Lok.pQxqcxaBZYChRm', 'Sameer','Panda','sameer.panda@xyz.com');  
  
/* Populate JOIN Table */
/* Populate one Admin User which will further create other users for the application using GUI */
INSERT INTO APP_USER_USER_PROFILE (user_id, user_profile_id) 
  SELECT appuser.id, userprofile.id FROM app_user appuser, user_profile userprofile where appuser.sso_id = 'sameer' and userprofile.type = 'ADMIN';  
 
/* Create persistent_logins Table used to store rememberme related stuff*/
CREATE TABLE persistent_logins (
    username VARCHAR(64) NOT NULL,
    series VARCHAR(64) NOT NULL,
    token VARCHAR(64) NOT NULL,
    last_used TIMESTAMP NOT NULL,
    PRIMARY KEY (series)
);

CREATE TABLE APP_POLICY 
(
  POLICYID NUMBER NOT NULL 
, POLICYTYPE VARCHAR2(50) NOT NULL 
, POLICYAMOUNT DECIMAL NOT NULL 
, RENEWALAMOUNT DECIMAL 
, POLICYSTARTDATE DATE DEFAULT sysdate NOT NULL 
, POLICYENDDATE DATE NOT NULL 
, POLICYDESCRIPTION VARCHAR2(2000) 
, SSO_ID VARCHAR2(50) NOT NULL 
, constraint APP_USER_SSO_ID_FK FOREIGN KEY (SSO_ID) REFERENCES APP_USER(SSO_ID)
, CONSTRAINT APP_POLICY_POLICYID_PK PRIMARY KEY 
  (
    POLICYID 
  )
  ENABLE 
);

/* insert into APP_POLICY values (190730001,'Health',200000,12000,sysdate,TO_DATE('30/07/2020','dd/mm/yyyy'),'Health insurance policy','sameer'); */

CREATE TABLE APP_CLAIM 
(
  CLAIMID NUMBER NOT NULL 
, CLAIMTYPE VARCHAR2(50) NOT NULL 
, CLAIMAMOUNT DECIMAL NOT NULL 
, APPROVEDAMOUNT DECIMAL 
, CLAIMSTARTDATE DATE DEFAULT sysdate NOT NULL 
, CLAIMENDDATE DATE NOT NULL 
, CLAIMDESCRIPTION VARCHAR2(2000) 
, POLICYID NUMBER NOT NULL 
, REMARKS VARCHAR2(2000)
, STATUS VARCHAR2(50)
, CONSTRAINT APP_POLICY_POLICYID_FK FOREIGN KEY (POLICYID) REFERENCES APP_POLICY(POLICYID)
, CONSTRAINT APP_CLAIM_CLAIMID_PK PRIMARY KEY 
  (
    CLAIMID 
  )
  ENABLE 
);

/* insert into APP_CLAIM values (190730001,'Health',2000,0,sysdate,TO_DATE('30/07/2020','dd/mm/yyyy'),'Health insurance policy',190730001,'','NEW'); */
