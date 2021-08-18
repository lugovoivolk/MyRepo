import names
import string
import random


class NameGenerator:
    def get_first_name(self):
        return names.get_first_name()

    def get_last_name(self):
        return names.get_last_name()

    def get_username(self, first_name, last_name):
        return first_name+last_name

    def get_password(self, size=6):
        chars = string.ascii_uppercase + string.digits
        return ''.join(random.choice(chars) for _ in range(size))

    def get_phone_number(self, size=10):
        chars = string.digits
        return ''.join(random.choice(chars) for _ in range(size))
