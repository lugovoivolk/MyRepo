import sys


def read_input_file(file_path):
    list_of_numbers = []
    f = open(file_path, 'r')
    try:
        for i in f:
            multiplier_group = {}
            one_row = i.split()
            multiplier_group['first_multiplier'] = one_row[0]
            multiplier_group['second_multiplier'] = one_row[1]
            multiplier_group['total_number'] = one_row[2]
            list_of_numbers.append(multiplier_group)
    except IndexError:
        raise IndexError('Make sure you have 3 numbers each row in the input file')
    f.close()
    return list_of_numbers


def find_natural_numbers(nums):
    final_list_to_return = [nums['total_number']]
    for i in range(1, int(nums['total_number'])):
        if (i % int(nums['first_multiplier'])) == 0:
            if str(i) not in final_list_to_return:
                final_list_to_return.append(str(i))
        if (i % int(nums['second_multiplier'])) == 0:
            if str(i) not in final_list_to_return:
                final_list_to_return.append(str(i))
    return final_list_to_return


def convert_numbers_to_string(nums):
    total_number_string = str(nums[0])
    nums.pop(0)
    string = total_number_string + ':' + ' '.join([str(item) for item in nums])
    return string


def sort_list_of_numbers(list_of_nums):
    for lst in list_of_nums:
        for i in range(0, len(list_of_nums) - 1):
            if len(list_of_nums[i]) > len(list_of_nums[i + 1]):
                list_of_nums[i], list_of_nums[i + 1] = list_of_nums[i + 1], list_of_nums[i]


def write_output_file_and_print(file_path, list_of_numbers):
    sort_list_of_numbers(list_of_numbers)
    f = open(file_path, 'w')
    for i in list_of_numbers:
        string_to_write = convert_numbers_to_string(i)
        print(string_to_write)
        f.write(string_to_write + '\n')
    f.close()


def main(argv):
    numbers_list = read_input_file(argv[0])
    multipliers_list = []
    for numbers in numbers_list:
        try:
            natural_numbers = find_natural_numbers(numbers)
            multipliers_list.append(natural_numbers)
        except ValueError:
            raise ValueError('Please provide correct input numbers')
    write_output_file_and_print(argv[1], multipliers_list)


if __name__ == "__main__":
    main(sys.argv[1:])
