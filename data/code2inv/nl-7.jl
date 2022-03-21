function fnext(x)
    nx1 = x[1]
    nx2 = x[2]
    nx3 = x[3] + x[1]
    nx4 = x[4] + 1
    return [nx1, nx2, nx3, nx4]
end

F_next = [fnext]

# XDIM: the number of variables, variables are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 4; XMIN = -100.0; XMAX = 100.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
# ADIV: how many pieces are search space divided per dimension
ADIM = 2; AMIN = -5.0; AMAX = 5.0; ADEG = 2; ADIV = 10;

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

# Cond: branching conditions
Cond = [-1]
# template: template <= 0 is the invariant template
template = x[1] * x[4] + a[1] * x[3] + a[2]

# preconditions and postconditions
precond = [x[3]; -x[3]; x[4]; -x[4]]
postcond = x[1] * x[2] - x[3]

# loopcond: the condition for loop to continue
loopcond = [x[4] - x[2]]

# additional_invariants: invariants that have been proven
additional_invariants = [-x[1]; x[1] - x[2]; -x[3]; -x[4]]

