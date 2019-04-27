FROM mysql:5.7

COPY student_dump1.sql /docker-entrypoint-initdb.d/
