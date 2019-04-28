FROM mysql:5.7

COPY student_dump2.sql /docker-entrypoint-initdb.d/
