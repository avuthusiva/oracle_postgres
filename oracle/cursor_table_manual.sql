DECLARE
    v_cur_no NUMBER;
    v_deptno NUMBER := 30; 
    v_empno DBMS_SQL.NUMBER_TABLE;
    v_ename DBMS_SQL.VARCHAR2_TABLE;
    v_min_val NUMBER := 0;
    v_max_val NUMBER;
    v_row_count NUMBER;
BEGIN
    SELECT COUNT(1) INTO v_max_val FROM emp WHERE deptno = v_deptno;
    v_cur_no := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cur_no,'select * from emp where deptno = :deptno',DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_ARRAY(v_cur_no,1,v_empno,v_max_val,v_min_val);
    DBMS_SQL.DEFINE_ARRAY(v_cur_no,2,v_ename,v_max_val,v_min_val);
    DBMS_SQL.BIND_VARIABLE(v_cur_no,':deptno',v_deptno);
    v_row_count := DBMS_SQL.EXECUTE(v_cur_no);
    --LOOP
        v_row_count := DBMS_SQL.FETCH_ROWS(v_cur_no);
        DBMS_SQL.COLUMN_VALUE(v_cur_no,1,v_empno);
        DBMS_SQL.COLUMN_VALUE(v_cur_no,2,v_ename);
        DBMS_OUTPUT.PUT_LINE('Row Count: ' || v_row_count);
        --EXIT WHEN v_row_count <> v_max_val;
    --END LOOP;
    FOR val IN 0 .. v_empno.COUNT 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Number: ' || v_empno(val) || 
                             ', Employee Name: ' || v_ename(val));
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(v_cur_no);
    EXCEPTION
        WHEN OTHERS THEN
            IF DBMS_SQL.IS_OPEN(v_cur_no) THEN
                DBMS_SQL.CLOSE_CURSOR(v_cur_no);
            END IF;
END;