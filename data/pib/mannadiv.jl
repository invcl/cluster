function fnext1(x) 
    nx1 = x[1]; # x1 does not change
    nx2 = x[2]; # x2 does not change 
    nx3 = x[3] + 1; # y1 changes 
    nx4 = 0; # y2 changes 
    nx5 = x[5] - 1; # y3 changes 
    return [nx1, nx2, nx3, nx4, nx5]
end

function fnext2(x)
    nx1 = x[1]; # x1 does not change
    nx2 = x[2]; # x2 does not change 
    nx3 = x[3]; # y1 does not change
    nx4 = x[4] + 1; # y2 changes 
    nx5 = x[5] - 1; # y3 changes 
    return [nx1, nx2, nx3, nx4, nx5]
end

F_next = [fnext1, fnext2] 

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 5; XMIN = -10.0; XMAX = 10.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
ADIM = 4; AMIN = -5.0; AMAX = 5.0; ADEG = 4; ADIV = 2 

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

# Cond: branching conditions
Cond = [x[4] + 1 - x[2]; x[2] - x[4] - 1]
# template: template <= 0 is the invariant template
template = x[2] * x[3] + a[1] * x[4] + a[2] * x[5] + a[3] * x[5] + a[4]

# preconditions and postconditions
precond = [-x[3]; x[3]; -x[4]; x[4]; x[1] - x[5]; x[5] - x[1]]
postcond = x[2] * x[3] + x[4] + x[5] - x[1]; 

# loopcond: the condition for loop to continue
loopcond = [1 - x[5]]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[-x[1]; 1 - x[2]; -x[3]; -x[4]; -x[5]]
# additional_invariants = Polynomial{true, Float64}[]

