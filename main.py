from flask import Flask, jsonify
import sqlite3


def main():
    app = Flask(__name__)
    app.config['JSON_AS_ASCII'] = False
    app.config['DEBUG'] = True

    def db_connect(query):
        connection = sqlite3.connect('animal.db')
        cursor = connection.cursor()
        cursor.execute(query)
        result = cursor.fetchall()
        connection.close()
        return result

    @app.route('/animals/<int:idx>')
    def search_by_animal(idx):
        query = f"""
            SELECT
                id
                , age_upon_outcome
                , animal_id
                , animal_type
                , date_of_birth
                , "name"
                , breed
                , outcome_id
                , animal_color
            FROM animals_final
            WHERE id == {idx}
        """
        response = db_connect(query)
        response_json = []
        for animal in response:
            response_json.append({
                'age_upon_outcome': animal[1],
                'animal_id': animal[2],
                'animal_type': animal[3],
                'date_of_birth': animal[4],
                'name': animal[5],
                'breed': animal[6],
                'outcome_id': animal[7],
                'animal_color': animal[8]
            })
        return jsonify(response_json)

    app.run(port=7070)


if __name__ == '__main__':
    main()
