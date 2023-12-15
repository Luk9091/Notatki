import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

def fit_func(x, a, b):
    return a*np.exp(x*b)


dataFrame = pd.read_csv("data.csv")
# print(dataFrame)

I = [[], [], [], []]
V = [[], [], [], []]
P = [[], [], [], []]

for i in range(4):
    current = f"prad_{i+1}"
    voltage = f"napiecie_{i+1}"
    power   = f"moc_{i+1}"
    I[i] = dataFrame[current].values
    V[i] = dataFrame[voltage].values
    P[i] = dataFrame[power].values

    
fig = plt.figure("Moc optyczna w funkcji prądu")
ax = plt.axes()
line = []
x = []
y = []
for i in range(4):
    line.append(ax.plot(I[i], P[i], label=f"{10+15*i}C"))

    for j in range(1, len(P[i])):
        if (P[i][j] >= 2.5*1e-6):
            x.append(I[i][j])
            y.append(P[i][j])
            print(f"x: {I[i][j]}, y: {P[i][j]}")
            break

ax.scatter(x, y)
popt, pcov = curve_fit(fit_func, x, y)
print(popt)
ax.plot(I[0], fit_func(I[0], *popt))
            


plt.legend(labels=["10C", "25C", "40C", "55C"])
# fig.legend(handles=line, )
plt.grid()
plt.show()