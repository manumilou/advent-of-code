import time

class MagicStones:
    def __init__(self, initial_state):
        self.stones = initial_state

    def blink(self, n=1):
        arrangement = self.stones
        for i in range(n):
            start_time = time.time()
            arrangement = self.arrange(arrangement)
            elapsed_time = time.time() - start_time
            print(f"Processed blink={i}/75 (size={len(arrangement)}) in {elapsed_time} seconds")

        return arrangement

    def arrange(self, arrangement):
        new_stones = []
        for stone in arrangement:
            if stone == 0:
                new_stones.append(1)
            elif len(str(stone)) % 2 == 0:
                left, right = self.split_integer(stone)
                new_stones.extend([left, right])
            else:
                new_stones.append(stone * 2024)

        return new_stones

    def split_integer(self, num):
        num_str = str(num)
        mid = len(num_str) // 2
        left_part = int(num_str[:mid])
        right_part = int(num_str[mid:])
        return left_part, right_part

if __name__ == "__main__":
    initial_state = [125, 17]
    magic_stones = MagicStones(initial_state)
    final_arrangement = magic_stones.blink(n=75)
    print("Final arrangement of stones:", len(final_arrangement))
