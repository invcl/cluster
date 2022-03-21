function fnext(x) 
    nx1 = x[1]; # a does not change
    nx2 = x[2] - 3 * x[3]^2 - 1/4; # x changes
    nx3 = x[3] + 1; # r changes 
    return [nx1, nx2, nx3]
end

F_next = [fnext] 

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 3; XMIN = -10.0; XMAX = 10.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
ADIM = 3; AMIN = -5.0; AMAX = 5.0; ADEG = 4; ADIV = 10

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

# Cond: branching conditions
Cond = [-1]
# template: template <= 0 is the invariant template
template = 4 * x[3]^3 - 6 * x[3]^2 + 3 * x[3] + a[1] * x[1] + a[2] * x[2] + a[3] 

# preconditions and postconditions
precond = [x[1] - x[2]; x[2] - x[1]; x[3] - 1; 1 - x[3]] 
postcond = 4 * x[3]^3 - 6 * x[3]^2 + 3 * x[3] - 1 - 4 * x[1]; 

# loopcond: the condition for loop to continue
loopcond = [3 * x[3]^2 - 1/4 - x[2]]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[-x[1]; -x[2]; -x[3]] 
# additional_invariants = Polynomial{true, Float64}[]

