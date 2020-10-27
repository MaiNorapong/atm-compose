FROM mysql

ENV MYSQL_ROOT_PASSWORD password
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password
      
# Add SQL script to initialise database
COPY create_db.sql /docker-entrypoint-initdb.d/init_db.sql
COPY my.cnf /etc/mysql/my.cnf

# Replace mysql's docker-entrypoint.sh with our own to grant MYSQL_USER access to *all databases* if not specified.
COPY mysql-docker-entrypoint.sh /entrypoint.sh

# Use entrypoint.sh to init db with our SQL script. Kill the process after enough time to do all that passes.
RUN /entrypoint.sh mysqld & sleep 30 && kill $!

EXPOSE 3306
