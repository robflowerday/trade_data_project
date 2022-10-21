import json

from psycopg2 import connect

from sql_queries import (
    create_trades_table,
    create_valuedata_table,
    insert_into_trades,
    insert_into_valuedata,
    output_query,
)


if __name__ == "__main__":
    connection = connect(
        dbname="postgres",
        user="postgres",
        password="password",
        port=5431,
        host="localhost",
    )

    with connection.cursor() as cursor:

        cursor.execute(create_trades_table)
        cursor.execute(create_valuedata_table)

        with open("data/trades.json") as trades_json_file:
            for trades_json in trades_json_file:
                trades_row = json.loads(trades_json)
                trades_insert_statement = insert_into_trades.format(
                    tradedate=f"'{trades_row['tradedate']}'",
                    event_timestamp=f"'{trades_row['event_timestamp']}'",
                    instrument_id=f"'{trades_row['instrument_id']}'",
                )
                cursor.execute(trades_insert_statement)

        with open("data/valuedata.json") as valuedata_json_file:
            for valuedata_json in valuedata_json_file:
                valuedata_row = json.loads(valuedata_json)
                valuedata_insert_statement = insert_into_valuedata.format(
                    tradedate=f"'{valuedata_row['tradedate']}'",
                    instrument_id=f"'{valuedata_row['instrument_id']}'",
                    when_timestamp=f"'{valuedata_row['when_timestamp']}'",
                    gamma=valuedata_row['gamma'],
                    vega=valuedata_row['vega'],
                    theta=valuedata_row['theta'],
                )
                cursor.execute(valuedata_insert_statement)

        connection.commit()

        cursor.execute(output_query)
        result = cursor.fetchall()
        print(result)
