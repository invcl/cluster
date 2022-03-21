function fnext(x)
    α = 5; β = 3;
    step = 1/64
    nx1 = x[1] + step * (-β * x[1] + x[1]^2 + x[2]^2 - α * x[1]^3)
    nx2 = x[2] + step * (-β * x[2] + 2 * x[1] * x[2] - α * x[2]^3)
    return [nx1, nx2]
end

F_next = [fnext]

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 2; XMIN = -100.0; XMAX = 100.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
ADIM = 3; AMIN = -5.0; AMAX = 5.0; ADEG = 3; ADIV = 1

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

# Cond: branching conditions
Cond = [-1]
# template: template <= 0 is the invariant template
template = x[1]^2 + a[1] * x[1] * x[2] + a[2] * x[2]^2 + a[3]

# preconditions and postconditions
precond = [x[1]^2 + x[2]^2 - 1]
postcond = -2 * x[1] + x[2]^2 - 5

# loopcond: the condition for loop to continue
loopcond = [-1]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[]

