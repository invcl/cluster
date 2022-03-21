const A = 2
const ϵ = 0.01

function fnext1(x)
    nx1 = 2 * x[1] - 2 * x[2] - x[3]
    nx2 = x[2] + x[3]
    nx3 = x[3] / 2
    return [nx1, nx2, nx3]
end

function fnext2(x)
    nx1 = 2 * x[1]
    nx2 = x[2]
    nx3 = x[3] / 2
    return [nx1, nx2, nx3]
end

F_next = [fnext1, fnext2]

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 3; XMIN = -100.0; XMAX = 100.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
ADIM = 2; AMIN = -5.0; AMAX = 5.0; ADEG = 4

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

rangeA = [(-2.1, -1.9), (1.9, 2.1)]

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

#Cond: branching conditions
Cond = [x[3] - 2 * x[1] - 2 * x[2], 2 * x[1] + 2 * x[2] - x[3]]
# template: template <= 0 is the invariant template
template = -x[2]^2 + a[1] * x[1] * x[3] + a[2]

# preconditions and postconditions
precond = [x[1] - 1, x[2] - 1, x[3] - 1/2, 1 - x[1], 1 - x[2], 1/2 - x[3]]
postcond = -x[2]^2 + A - ϵ

# loopcond: the condition for loop to continue
# loopcond = [0.01 - 2 * x[1] * x[3]]
loopcond = [0.01 - 2 * x[1] * x[3], -x[1], -x[2], -x[3]]
