import requests
from random import randint
import time


class StationAPITests:

    def __init__(self, server_url, station_ids):
        self.server_url = server_url
        self.station_ids = station_ids
        self.test_results = []

    def test_station_get_version(self, station_id):
        response = requests.post(
            url=f'{self.server_url}/tests/{station_id}',
            json={'command': 'getVersion'}
        )
        try:
            assert response.status_code == 200
            assert isinstance(response.json()['result'], str)
            self.test_results.append(f'PASSED: Get version from station with ID {station_id}')
        except AssertionError:
            self.test_results.append(f'FAILED: Get version from station with ID {station_id}')

    def test_station_get_interval(self, station_id):
        response = requests.post(
            url=f'{self.server_url}/tests/{station_id}',
            json={'command': 'getInterval'}
        )
        try:
            assert response.status_code == 200
            assert isinstance(response.json()['result'], int)
            self.test_results.append(f'PASSED: Get interval from station with ID {station_id}')
        except AssertionError:
            self.test_results.append(f'FAILED: Get interval from station with ID {station_id}')

    def test_station_set_values(self, station_id, values):
        response = requests.post(
            url=f'{self.server_url}/tests/{station_id}',
            json={'command': 'setValues',
                  'payload': values}
        )
        try:
            assert response.status_code == 200
            assert isinstance(response.json()['result'], str)
            assert response.json()['result'] == 'OK' or response.json()['result'] == 'FAILED'
            self.test_results.append(f'PASSED: Set values for station with ID {station_id}')
        except AssertionError:
            self.test_results.append(f'FAILED: Set values for station with ID {station_id}')

    def test_station_update_interval(self, station_id):
        get_interval_response = requests.post(
            url=f'{self.server_url}/tests/{station_id}',
            json={'command': 'getInterval'}
        )
        try:
            assert get_interval_response.status_code == 200
            new_interval = get_interval_response.json()['result'] + randint(1, 10)
            set_interval_response = requests.post(
                url=f'{self.server_url}/tests/{station_id}',
                json={'command': 'setValues',
                      'payload': new_interval}
            )
            assert set_interval_response.status_code == 200
            assert set_interval_response.json()['result'] == 'OK'
            get_updated_interval_response = requests.post(
                url=f'{self.server_url}/tests/{station_id}',
                json={'command': 'getInterval'}
            )
            assert get_updated_interval_response.status_code == 200
            assert get_updated_interval_response.json()['result'] == new_interval
            self.test_results.append(f'PASSED: Update interval for station with ID {station_id}')
        except AssertionError:
            self.test_results.append(f'FAILED: Update interval for station with ID {station_id}')

    def test_station_bad_request(self, station_id):
        response = requests.post(
            url=f'{self.server_url}/tests/{station_id}',
            json={'command': 'setBadRequest'}
        )
        try:
            assert response.status_code == 400
            self.test_results.append(f'PASSED: Bad request for station with ID {station_id}')
        except AssertionError:
            self.test_results.append(f'FAILED: Bad request for station with ID {station_id}')

    def show_tests_results(self):
        timestamp = time.strftime("%Y%m%d%H%M%S")
        f = open(f'test_results_{timestamp}.txt', 'a')
        for line in self.test_results:
            print(line)
            f.write(line + '\n')
        f.close()

    def log_in_test_results(self, msg):
        self.test_results.append(msg)


if __name__ == '__main__':
    test = StationAPITests(server_url='https://api-energy-k8s.test.virtaglobal.com/v1', station_ids=[1, 2, 3, 4, 5])
    for i in test.station_ids:
        test.log_in_test_results(f'Start testing station with ID {i}')
        test.test_station_get_version(i)
        test.test_station_get_interval(i)
        test.test_station_set_values(i, randint(1, 100))
        test.test_station_update_interval(i)
        test.test_station_bad_request(i)
        test.log_in_test_results(f'End testing station with ID {i}')
        test.log_in_test_results('-----'*10)
    test.show_tests_results()
