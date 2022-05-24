import sqlite3
from os.path import join, isfile

DATA_PATH = 'animal.db'
SQL_PATH = 'sql'
INIT_MIGRATION_PATH = 'query_tables.sql'
DATA_MIGRATION_PATH = 'migration.sql'


def get_sql_from_path(path_name):
    """
    Get sql data
    :param path_name: Full path
    :return: query stroke
    """
    content = ''
    if isfile(path_name):
        with open(path_name) as file:
            content = file.read()
    return content


def main():
    """
    Main function for data migration
    """
    connection = sqlite3.connect(DATA_PATH)
    cursor = connection.cursor()

    # Database architecture
    init_sql = get_sql_from_path(join(SQL_PATH, INIT_MIGRATION_PATH))
    cursor.executescript(init_sql)

    # Data insertion
    data_sql = get_sql_from_path(join(SQL_PATH, DATA_MIGRATION_PATH))
    cursor.executescript(data_sql)

    cursor.close()
    connection.close()

