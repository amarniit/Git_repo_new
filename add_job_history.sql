--------------------------------------------------------
--  File created - Wednesday-December-13-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ADD_JOB_HISTORY
----This is for git test
---This is created by Amar for git testing
-------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "HR"."ADD_JOB_HISTORY" 
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT /* APEX46882b */  INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;

/
