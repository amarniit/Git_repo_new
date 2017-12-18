CREATE TABLE MY_AUDIT_DDL
(
  D             DATE,
  OSUSER        VARCHAR2(256 BYTE),
  CURRENT_USER  VARCHAR2(256 BYTE),
  HOST          VARCHAR2(256 BYTE),
  TERMINAL      VARCHAR2(256 BYTE),
  OWNER         VARCHAR2(4000 BYTE),
  TYPE          VARCHAR2(4000 BYTE),
  NAME          VARCHAR2(4000 BYTE),
  SYSEVENT      VARCHAR2(4000 BYTE),
  SQL_TXT       VARCHAR2(4000 BYTE)
)
LOGGING
NOCOMPRESS
NOCACHE
NOPARALLEL
MONITORING;





CREATE OR REPLACE TRIGGER my_audit_ddl_trg AFTER DDL ON DATABASE
DECLARE
      sql_text ora_name_list_t;
     stmt VARCHAR2(4000) := '';
      n NUMBER;
    BEGIN
      IF (ora_sysevent = 'ALTER USER')
      THEN
        NULL;
     ELSE
       n:=ora_sql_txt(sql_text);
           IF ( n IS NULL )
           THEN
                   stmt := 'null statement';
           ELSE
           FOR i IN 1..n
           LOOP
             stmt:=SUBSTR(stmt||sql_text(i),1,4000);
           END LOOP;
           END IF;
       INSERT INTO MY_AUDIT_DDL(d,
osuser,CURRENT_USER,host,terminal,owner,TYPE,NAME,sysevent,sql_txt)
       VALUES(
         SYSDATE,
         sys_context('USERENV','OS_USER') ,
         sys_context('USERENV','CURRENT_USER') ,
         sys_context('USERENV','HOST') ,
         sys_context('USERENV','TERMINAL') ,
         ora_dict_obj_owner,
         ora_dict_obj_type,
         ora_dict_obj_name,
         ora_sysevent,
         stmt
       );
     END IF;
   END;
/
