def F(x):
    return (x - 5)**2 + 50


# Derivative of F(x)
def Fd(x):
    return 2 * (x - 5)


def newton(x, iters=10**5, error=10**-4, debug=False):
    # Initialize x_old to a random variable such that
    # [abs(x - x_old) <= error] turns out to be false
    x_old = x - error - 10

    for i in range(iters):
        if debug:
            print(x, F(x), Fd(x))
        if abs(x - x_old) <= error:
            break
        x_old = x
        x -= F(x) / Fd(x)

    return x

x = newton(100, debug=True)
print(x)
