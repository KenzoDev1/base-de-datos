-- Actividad 3.1

-- CASO 1

/*
SET SERVEROUTPUT ON;

VAR B_RUT NUMBER
EXEC :B_RUT:=11846972;

DECLARE

V_NOMBRE VARCHAR2(57);
V_RUT VARCHAR2(12);
V_SUELDO EMPLEADO.SUELDO_EMP%TYPE;
V_BONIFICACION EMPLEADO.SUELDO_EMP%TYPE;

BEGIN

SELECT E.NOMBRE_EMP||' '||E.APPATERNO_EMP||' '||E.APMATERNO_EMP,
E.NUMRUT_EMP||'-'||E.DVRUT_EMP,
E.SUELDO_EMP,
E.SUELDO_EMP/100*40
INTO V_NOMBRE, V_RUT, V_SUELDO, V_BONIFICACION
FROM EMPLEADO E
WHERE E.NUMRUT_EMP=:B_RUT;

DBMS_OUTPUT.PUT_LINE('DATOS CALCULO BONIFICACION EXTRA DEL 40% DEL SUELDO');
DBMS_OUTPUT.PUT_LINE('Nombre Empleado: '||V_NOMBRE);
DBMS_OUTPUT.PUT_LINE('RUN: '||V_RUT);
DBMS_OUTPUT.PUT_LINE('Sueldo: '||V_SUELDO);
DBMS_OUTPUT.PUT_LINE('Bonifacion extra: '||V_BONIFICACION);

END;
*/

-- CASO 2

/*

SET SERVEROUTPUT ON;

VAR B_RUT NUMBER
EXEC :B_RUT:=13050258;

VAR B_RENTA_MIN NUMBER
EXEC :B_RENTA_MIN:=800000;

DECLARE

V_NOMBRE VARCHAR2(57);
V_RUT VARCHAR2(12);
V_ID_ESTCIVIL CLIENTE.ID_ESTCIVIL%TYPE;
V_RENTA CLIENTE.RENTA_CLI%TYPE;
V_DESC_ESTCIVIL ESTADO_CIVIL.DESC_ESTCIVIL%TYPE;

BEGIN

SELECT C.NOMBRE_CLI||' '||C.APPATERNO_CLI||' '||C.APMATERNO_CLI,
C.NUMRUT_CLI||'-'||C.DVRUT_CLI,
C.ID_ESTCIVIL,
C.RENTA_CLI
INTO V_NOMBRE, V_RUT, V_ID_ESTCIVIL, V_RENTA
FROM CLIENTE C
WHERE C.NUMRUT_CLI =:B_RUT AND C.RENTA_CLI >=:B_RENTA_MIN;

SELECT DESC_ESTCIVIL
INTO V_DESC_ESTCIVIL
FROM ESTADO_CIVIL
WHERE ID_ESTCIVIL = V_ID_ESTCIVIL;

DBMS_OUTPUT.PUT_LINE('DATOS DEL CLIENTE');
DBMS_OUTPUT.PUT_LINE('-----------------');
DBMS_OUTPUT.PUT_LINE('Nombre: '||V_NOMBRE);
DBMS_OUTPUT.PUT_LINE('RUN: '||V_RUT);
DBMS_OUTPUT.PUT_LINE('Estado civil: '||V_DESC_ESTCIVIL);
DBMS_OUTPUT.PUT_LINE('Renta: '||TO_CHAR(V_RENTA,'L9G999G999'));

END;

*/

-- CASO 3

/*

SET SERVEROUTPUT ON;

-- Bean para buscar el empleado a procesar
VAR B_RUT NUMBER
EXEC :B_RUT:=12260812;

-- Bean para el porcentaje de aumento en todos los empleados SIMULACION 1

VAR B_PORC NUMBER
EXEC :B_PORC:=8.5;

-- Bean para el porcentaje de aumento para empleados que cumplan con un rango de sueldo SIMULACION 2

VAR B_PORC2 NUMBER
EXEC :B_PORC2:=20;

-- Bean para rango de sueldo minimo SIMULACION 2

VAR B_RANGOMIN NUMBER
EXEC :B_RANGOMIN:=200000;

-- Bean para rango de sueldo maximo SIMULACION 2

VAR B_RANGOMAX NUMBER
EXEC :B_RANGOMAX:=400000;

DECLARE

V_NOMBRE VARCHAR2(57);
V_RUT VARCHAR2(12);
V_SUELDO EMPLEADO.SUELDO_EMP%TYPE;
V_SUELDO_RE NUMBER;
V_REAJUSTE NUMBER;

V_SUELDO_RE2 NUMBER;
V_REAJUSTE2 NUMBER;

BEGIN

-- SIMULACION 1

SELECT NOMBRE_EMP||' '||APPATERNO_EMP||' '||APMATERNO_EMP,
NUMRUT_EMP||'-'||DVRUT_EMP,
SUELDO_EMP,
ROUND(SUELDO_EMP+SUELDO_EMP/100*:B_PORC),
ROUND(SUELDO_EMP/100*:B_PORC)
INTO V_NOMBRE, V_RUT, V_SUELDO, V_SUELDO_RE, V_REAJUSTE
FROM EMPLEADO
WHERE NUMRUT_EMP =:B_RUT;

-- SIMULACION 2

SELECT ROUND(SUELDO_EMP+SUELDO_EMP/100*:B_PORC2),
ROUND(SUELDO_EMP/100*:B_PORC2)
INTO V_SUELDO_RE2, V_REAJUSTE2
FROM EMPLEADO
WHERE NUMRUT_EMP =:B_RUT AND SUELDO_EMP >=:B_RANGOMIN AND SUELDO_EMP <=:B_RANGOMAX;

DBMS_OUTPUT.PUT_LINE('NOMBRE DEL EMPLEADO: '||V_NOMBRE);
DBMS_OUTPUT.PUT_LINE('RUN: '||V_RUT);
DBMS_OUTPUT.PUT_LINE('SIMULACION 1: Aumentar en '||:B_PORC||'% el salario de todos los empleados');
DBMS_OUTPUT.PUT_LINE('Sueldo actual: '||V_SUELDO);
DBMS_OUTPUT.PUT_LINE('Sueldo reajustado: '||V_SUELDO_RE);
DBMS_OUTPUT.PUT_LINE('Reajuste: '||V_REAJUSTE);

DBMS_OUTPUT.PUT_LINE('SIMULACION 2: Aumentar en '||:B_PORC2||'% el salario de los empleados que poseen entre '
||LTRIM(TO_CHAR(:B_RANGOMIN,'L999G999'))||' y '||LTRIM(TO_CHAR(:B_RANGOMAX,'L999G999')));
DBMS_OUTPUT.PUT_LINE('Sueldo actual: '||V_SUELDO);
DBMS_OUTPUT.PUT_LINE('Sueldo reajustado: '||V_SUELDO_RE2);
DBMS_OUTPUT.PUT_LINE('Reajuste: '||V_REAJUSTE2);

END;

*/

-- CASO 4

/*

SET SERVEROUTPUT ON;

VAR B_ID_TIP_PROP VARCHAR2(1)
EXEC :B_ID_TIP_PROP:='A';


DECLARE

V_TIPO_PROP TIPO_PROPIEDAD.DESC_TIPO_PROPIEDAD%TYPE;
V_TOTAL_PROP NUMBER(1);
V_TOTAL_ARRI NUMBER;

BEGIN
    
SELECT DESC_TIPO_PROPIEDAD
INTO V_TIPO_PROP
FROM TIPO_PROPIEDAD
WHERE ID_TIPO_PROPIEDAD =:B_ID_TIP_PROP;

SELECT 
COUNT(NRO_PROPIEDAD),
SUM(VALOR_ARRIENDO)
INTO V_TOTAL_PROP, V_TOTAL_ARRI
FROM PROPIEDAD
WHERE ID_TIPO_PROPIEDAD =: B_ID_TIP_PROP;

DBMS_OUTPUT.PUT_LINE('RESUMEN DE: '||V_TIPO_PROP);
DBMS_OUTPUT.PUT_LINE('Total de Propiedades: '||V_TOTAL_PROP);
DBMS_OUTPUT.PUT_LINE('Valor Total arriendo: '||LTRIM(TO_CHAR(V_TOTAL_ARRI,'L9G999G999')));

END;

*/