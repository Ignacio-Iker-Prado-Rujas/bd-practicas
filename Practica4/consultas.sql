
--1 
select *
from CLIENTES
order by APELLIDO;
--2
select 	RESTAURANTES.NOMBRE, DIAS.NOMBRE AS DIA, TO_CHAR(HORA_APERTURA, 'HH24:MI'), TO_CHAR(HORA_CIERRE, 'HH24:MI')
from RESTAURANTES, HORARIOS, DIAS
where codigo = restaurante AND "dia semana" = dia
ORDER BY RESTAURANTES.NOMBRE;
 --3
SELECT DISTINCT CLIENTES.DNI, CLIENTES.NOMBRE, CLIENTES.APELLIDOS
FROM (CONTIENE NATURAL INNER JOIN PLATOS), PEDIDOS, CLIENTES
WHERE PLATOS.CATEGORIA = 'picante' AND PEDIDOS.CODIGO = CONTIENE.PEDIDO AND CLIENTES.DNI = PEDIDOS.CLIENTE AND PLATO = PLATOS.NOMBRE;
 --4
 SELECT DNI
 FROM CLIENTES C1
 WHERE NOT EXISTS ((SELECT CODIGO
                FROM RESTAURANTES)
                MINUS
                (SELECT RESTAURANTE
                FROM CLIENTES C2, PEDIDOS, CONTIENE
                WHERE C2.DNI=CLIENTE AND CODIGO=PEDIDO AND C1.DNI=C2.DNI ));
--5
SELECT DISTINCT DNI, NOMBRE, APELLIDOS
FROM CLIENTES, PEDIDOS
WHERE DNI=CLIENTE AND ESTADO <> 'ENTREGADO';
--6
SELECT CODIGO, ESTADO, FECHA_HORA_PEDIDO, FECHA_HORA_ENTREGA,"importe total", CLIENTE
FROM PEDIDOS
WHERE PEDIDOS."importe total" = (SELECT MAX("importe total")
                        FROM PEDIDOS);
--7
SELECT DNI, NOMBRE, APELLIDOS, "Valor medio pedidos"
FROM CLIENTES, (  SELECT CLIENTE, AVG("importe total") AS "Valor medio pedidos"
                   FROM PEDIDOS
                   GROUP BY CLIENTE)
WHERE DNI=CLIENTE
--8
SELECT CODIGO, NOMBRE, SUM(UNIDADES) AS "Platos vendidos", SUM(UNIDADES*PRECIO) as "Precio acumulado"
FROM (SELECT RESTAURANTES.CODIGO,RESTAURANTES.NOMBRE, CONTIENE.PLATO, UNIDADES, PRECIO
      FROM RESTAURANTES, CONTIENE, PLATOS
      WHERE RESTAURANTES.CODIGO=CONTIENE.RESTAURANTE AND CONTIENE.RESTAURANTE=PLATOS.RESTAURANTE AND PLATO=PLATOS.NOMBRE)
GROUP BY CODIGO, NOMBRE;
--9
SELECT DISTINCT C.NOMBRE, C.APELLIDOS
FROM PLATOS P, CONTIENE CONT, PEDIDOS P, CLIENTES C
WHERE PRECIO>15 AND P.RESTAURANTE=CONT.RESTAURANTE AND P.NOMBRE=CONT.PLATO AND CONT.PEDIDO=P.CODIGO AND P.CLIENTE=C.DNI 
--10
SELECT DNI, NOMBRE, APELLIDOS, COUNT(RESTAURANTE) AS "N�mero restaurantes"
FROM(SELECT DNI, NOMBRE, APELLIDOS, RESTAURANTE
    FROM CLIENTES C, "Areas Cobertura" A
    WHERE C."codigo postal"=A."codigo postal")
GROUP BY DNI, NOMBRE, APELLIDOS;