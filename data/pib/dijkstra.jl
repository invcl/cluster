function fnext1(x) 
    nx1 = x[1]; # n does not change 
    nx2 = 1/2 * x[2]; # p changes 
    nx3 = 1/4 * x[3]; # q changes 
    nx4 = x[4]; # r does not change
    return [nx1, nx2, nx3, nx4]
end

function fnext2(x) 
    nx1 = x[1]; # n does not change
    nx2 = 1/2 * x[2] + 1/4 * x[3]; # p changes 
    nx3 = 1/4 * x[3]; # q changes 
    nx4 = x[4] - x[2] - 1/4 * x[3]; # r changes
    return [nx1, nx2, nx3, nx4]
end

F_next = [fnext1, fnext2] 

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 4; XMIN = -10.0; XMAX = 10.0; XDEG = 2

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
Cond = [-1; -1]
# template: template <= 0 is the invariant template
template = x[1] * x[3] + a[1] * x[2]^2 + a[2] * x[3] * x[4] + a[3] 

# preconditions and postconditions
precond = [-x[2]; x[2]; x[1]-x[4]; x[4]-x[1];1-x[3]] 
postcond = x[1] - (x[2] + 1)^2 + 0.01 

# loopcond: the condition for loop to continue
loopcond = [2 - x[3]]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[-x[1]; -x[2]; 1-x[3]; -2*x[2]-x[3]+x[1]+1] 
# additional_invariants = Polynomial{true, Float64}[]

