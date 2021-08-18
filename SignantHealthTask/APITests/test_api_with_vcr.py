import os
from robot import run
import requests
import vcr
from requests.auth import HTTPBasicAuth

dir_path = os.path.dirname(os.path.realpath(__file__))
ui_test_file_path = os.path.join(dir_path, '..', 'UITests\\TestSuite\\RegistrationTest.robot')
base_url = 'http://localhost:8080/api'
users_url = '/users'
auth_url = '/auth/token'
vcr_cassettes_path = os.path.join(dir_path, 'vcr_cassettes')


class Session:
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({'Content-Type': 'application/json'})


class User:
    def __init__(self):
        self.username = 'SergeyMoskalev'
        self.user_first_name = 'Sergey'
        self.user_last_name = 'Moskalev'
        self.password = 'password'
        self.phone = '0444545454'

    def add_user_from_ui(self):
        run(ui_test_file_path,
            variable=['username:' + self.username, 'user_first_name:' + self.user_first_name,
                      'user_last_name:' + self.user_last_name,
                      'user_password:' + self.password, 'user_phone_number:' + self.phone],
            test='Test Register New User',
            name='Register Predefined User With UI', )


new_session = Session()
new_user = User()


@vcr.use_cassette(vcr_cassettes_path + '/test_get_users_check_status_code_equals_200.yml')
def test_get_users_check_status_code_equals_200():
    url = base_url + users_url
    response = new_session.session.get(url)
    assert response.status_code == 200


@vcr.use_cassette(vcr_cassettes_path + '/test_get_users_check_message.yml')
def test_get_users_check_message():
    url = base_url + users_url
    response = new_session.session.get(url)
    assert response.json()['status'] == 'SUCCESS'


@vcr.use_cassette(vcr_cassettes_path + '/test_get_user_data_check_status_code_equals_401.yml')
def test_get_user_data_check_status_code_equals_401():
    url = base_url + users_url + '/anyuser'
    response = new_session.session.get(url)
    assert response.status_code == 401


@vcr.use_cassette(vcr_cassettes_path + '/test_auth_get_token_without_user_creds_status_code_equals_401.yml')
def test_auth_get_token_without_user_creds_status_code_equals_401():
    url = base_url + auth_url
    response = new_session.session.get(url)
    assert response.status_code == 401


@vcr.use_cassette(vcr_cassettes_path + '/test_auth_get_token_with_wrong_user_name_status_code_equals_401.yml')
def test_auth_get_token_with_wrong_user_name_status_code_equals_401():
    url = base_url + auth_url
    response = new_session.session.get(url, auth=HTTPBasicAuth('incorrect_username', new_user.password))
    assert response.status_code == 401


@vcr.use_cassette(vcr_cassettes_path + '/test_auth_get_token_with_wrong_password_status_code_equals_401.yml')
def test_auth_get_token_with_wrong_password_status_code_equals_401():
    url = base_url + auth_url
    response = new_session.session.get(url, auth=HTTPBasicAuth(new_user.username, 'anyPassword'))
    assert response.status_code == 401


@vcr.use_cassette(vcr_cassettes_path + '/test_get_toke_without_user_creds_check_message.yml')
def test_get_toke_without_user_creds_check_message():
    url = base_url + auth_url
    response = new_session.session.get(url)
    assert response.json()['status'] == 'FAILURE'
    assert response.json()['message'] == 'Invalid User'


@vcr.use_cassette(vcr_cassettes_path + '/test_get_toke_with_wrong_password_check_message.yml')
def test_get_toke_with_wrong_password_check_message():
    url = base_url + auth_url
    response = new_session.session.get(url, auth=HTTPBasicAuth(new_user.username, 'anyPassword'))
    assert response.json()['status'] == 'FAILURE'
    assert response.json()['message'] == 'Invalid Authentication'


@vcr.use_cassette(vcr_cassettes_path + '/test_get_token_with_wrong_username_check_message.yml')
def test_get_token_with_wrong_username_check_message():
    url = base_url + auth_url
    response = new_session.session.get(url, auth=HTTPBasicAuth('incorrect_username', new_user.password))
    assert response.json()['status'] == 'FAILURE'
    assert response.json()['message'] == 'Invalid User'


@vcr.use_cassette(vcr_cassettes_path + '/test_get_user_details_without_token_status_code_equals_401.yml')
def test_get_user_details_without_token_status_code_equals_401():
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.get(url)
    assert response.status_code == 401


@vcr.use_cassette(vcr_cassettes_path + '/test_get_user_details_without_token_check_message.yml')
def test_get_user_details_without_token_check_message():
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.get(url)
    assert response.json()['status'] == 'FAILURE'
    assert response.json()['message'] == 'Token authentication required'


@vcr.use_cassette(vcr_cassettes_path + '/test_get_user_details_with_token_status_code_equals_200.yml')
def test_get_user_details_with_token_status_code_equals_200():
    token_resp = new_session.session.get(base_url + auth_url, auth=HTTPBasicAuth(new_user.username, new_user.password))
    assert token_resp.status_code == 200
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.get(url, headers={'Token': token_resp.json()['token']})
    assert response.status_code == 200


@vcr.use_cassette(vcr_cassettes_path + '/test_get_user_details_with_token_check_message.yml')
def test_get_user_details_with_token_check_message():
    token_resp = new_session.session.get(base_url + auth_url, auth=HTTPBasicAuth(new_user.username, new_user.password))
    assert token_resp.status_code == 200
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.get(url, headers={'Token': token_resp.json()['token']})
    assert response.json()['message'] == 'retrieval succesful'
    assert response.json()['status'] == 'SUCCESS'


@vcr.use_cassette(vcr_cassettes_path + '/test_get_user_details_with_token_check_details.yml')
def test_get_user_details_with_token_check_details():
    token_resp = new_session.session.get(base_url + auth_url, auth=HTTPBasicAuth(new_user.username, new_user.password))
    assert token_resp.status_code == 200
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.get(url, headers={'Token': token_resp.json()['token']})
    assert response.json()['payload']['firstname'] == new_user.user_first_name
    assert response.json()['payload']['lastname'] == new_user.user_last_name
    assert response.json()['payload']['phone'] == new_user.phone


@vcr.use_cassette(vcr_cassettes_path + '/test_update_user_details_without_token_status_code_equals_200.yml')
def test_update_user_details_without_token_status_code_equals_200():
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.put(url)
    assert response.status_code == 401


@vcr.use_cassette(vcr_cassettes_path + '/test_update_user_details_without_token_check_message.yml')
def test_update_user_details_without_token_check_message():
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.put(url)
    assert response.json()['status'] == 'FAILURE'
    assert response.json()['message'] == 'Token authentication required'


@vcr.use_cassette(vcr_cassettes_path + '/test_update_user_details_without_payload_status_code_equals_400.yml')
def test_update_user_details_without_payload_status_code_equals_400():
    token_resp = new_session.session.get(base_url + auth_url, auth=HTTPBasicAuth(new_user.username, new_user.password))
    assert token_resp.status_code == 200
    url = base_url + users_url + '/' + new_user.username
    response = new_session.session.put(url, headers={'Token': token_resp.json()['token']})
    assert response.status_code == 400

