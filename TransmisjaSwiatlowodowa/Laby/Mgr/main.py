import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from scipy.stats import linregress



df = pd.read_csv("Measure/OTDR_LP.csv")
data = df["Data"]
time = df["Time"]


def get_ref_level(data: list) -> int:
    pick = False
    for i in range(1, len(data)):
        if pick is False:
            if data[i-1] - data[i] > 10:
                pick = True
        else:
            if data[i-1] - data[i] < 1:
                return i

def get_offset_end(data: list) -> int:
    for i in range(1, len(data)):
        if data[i] - data[i - 1] > 10:
            return i-1

# ref_index = 821
ref_index = get_ref_level(data)

# offset_last_index = 771
offset_last_index = get_offset_end(data)


print(f"Ref index: {ref_index}, level: {data[ref_index]}")
print(f"Offset last index: {offset_last_index}")

offset = np.average(data[0:offset_last_index])
data_off = data - offset
c = 299_792_458
n = 1.470
v = c / n


log_data = 5 * np.log10(data_off/data_off[ref_index])
distance = (time - time[offset_last_index-1]) * v / 2

start = ref_index# + 2_300
stop = start + 2_000
slope, intercept, _, _, std_err = linregress(distance[start:stop]/1_000, log_data[start: stop])
print(f"Slope: {slope}")
print(f"Offset: {intercept}")
print(f"Std err: {std_err}")


for i in range(len(log_data)):
    if log_data[i] < -35:
        log_data[i] = -35

plt.subplot(2, 1, 1)
plt.plot(time, data)
plt.scatter(time[ref_index], data[ref_index], color="red")
plt.scatter(time[offset_last_index], data[offset_last_index], color="red")
plt.grid()

plt.subplot(2, 1, 2)
plt.plot(distance[offset_last_index:] / 1_000, log_data[offset_last_index:])
plt.scatter(distance[start] / 1_000, log_data[start], color="red")
plt.scatter(distance[stop] / 1_000,  log_data[stop], color="red")
plt.grid()

plt.show()

step = 3
df = pd.DataFrame({
    "Time":     time[::step]* 1_000,
    "Power":    data[::step],
    "Distance": distance[::step]/ 1_000,
    "Gain":     log_data[::step]    
})

df.to_csv("Measure/measure.csv", index= False)

