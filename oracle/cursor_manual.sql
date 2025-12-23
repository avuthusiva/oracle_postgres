DECLARE
    v_cur_num NUMBER;
    v_emp EMP%ROWTYPE;
    v_deptno NUMBER := 10;
    v_row_count NUMBER:=0;
BEGIN
    v_cur_num := DBMS_SQL.OPEN_CURSOR;
    DBMS_OUTPUT.PUT_LINE(v_cur_num);
    DBMS_SQL.PARSE(v_cur_num,'select * from emp where deptno = :deptno',DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(v_cur_num,5,v_emp.hiredate);
    DBMS_SQL.DEFINE_COLUMN(v_cur_num,6,v_emp.sal);
    DBMS_SQL.BIND_VARIABLE(v_cur_num,':deptno',v_deptno);
    v_row_count:= DBMS_SQL.EXECUTE(v_cur_num);
    WHILE DBMS_SQL.FETCH_ROWS(v_cur_num) > 0
    LOOP
        DBMS_SQL.COLUMN_VALUE(v_cur_num,5,v_emp.hiredate);
        DBMS_SQL.COLUMN_VALUE(v_cur_num,6,v_emp.sal);
        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_emp.sal || ', Hire Date: ' || TO_CHAR(v_emp.hiredate, 'DD-MON-YYYY'));
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(v_cur_num);
    DBMS_OUTPUT.PUT_LINE('Cursor closed successfully.');
EXCEPTION
    WHEN OTHERS THEN
        IF DBMS_SQL.IS_OPEN(v_cur_num) THEN
            DBMS_SQL.CLOSE_CURSOR(v_cur_num);
        END IF;
        RAISE_APPLICATION_ERROR(-20001, 'An error occurred: ' || SQLERRM);
END;