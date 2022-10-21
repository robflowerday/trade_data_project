# trade_data_project

Task 1:
The task here is to use Python or Go to read 2 files with json data and
populate an appropriate database with their contents. 

A simple solution would be to use pandas and SQLite by installing
their packages and creating a file named db_file.db and using the
following in a python file:

from sqlite3 import connect
connection = connect(db_file.db)

trades = pd.read_json("data/trades.json", lines=True, convert_dates=["events_timestamp])
value_data = pd.read_json("data/valuedata.json", lines=True, convert_dates=["when_timestamp])

trades.to_sql("data/trades.json", connection)
valuedata.to_sql("data/valuedata.json", connection)

The main drawbacks of this solution is that it's not scalable. SQLite
works very slowly with large amounts of data.

I believe it is appopriate to use an SQL based database over a No-SQL
solution like Mongo-DB due to the relational nature of task 2. I have
then considered 3 options. MySQL, PostgreSQL and SQLite.

SQLite is not suitable for reasons stated above, I have chosen to use
PostgreSQL over MySQL partially as I'm more used to Posetgres, but
also because it is typically faster where lots of write operations
are required. In this case it has been suggested to make my solution
scalable to accept messages from Kafka. With trade data, this would
suggest that the incoming data would be constant and would need to be
analysed in real-time, making write time important.

I have used docker and docker-compose and so rather than having the
same postgres version, it is only important that docker and
docker-compose are installed on your machine.

Once installed, you then need to install the only python requirement
(psycopg2) which is used to connect to the created postgres database.
I recommend doing this within a python virtual environment. If using
python3 on linux this can be done with the following commands:
python3 -m venv venv
source venv/bin/activate

The dependency can be installed using pip install -r requirements.txt

I have used a docker in an attempt to reduce the change of errors
caused by different machine environments.

I have used docker-compose with the idea that this could be further
extended by creating a Kafka service in a docker container that speaks
with the db service. If a Kafka service is introduced, the json
responses could be parsed in a similar way as the files are currently,
though it would likely make sense to create a function to handle this
parsing.

Overview of commands to run for task one if using Linux with Python3,
Docker and Docker Compose installed:

- git clone https://github.com/robflowerday/trade_data_project.git
- cd trade_data_project
- python3 -m venv venv
- source venv/bin/activate
- pip install -r requirements.txt
- docker-compose up -d
- python3 main.py

This will create and populate a database with tables trades and
valuedata. It will also return the results of a select query as
requested in task 2, this query is also saved in
'task_2_separated_query.sql' for easy use externally.
