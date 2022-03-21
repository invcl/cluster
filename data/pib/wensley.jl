function fnext1(x) 
    nx1 = x[1]; # Q does not change
    nx2 = x[2]; # P does not change 
    nx3 = x[3]; # a does not change 
    nx4 = x[4]; # y does not change 
    nx5 = 1/2 * x[5] # d is halved 
    return [nx1, nx2, nx3, nx4, nx5]
end

function fnext2(x) 
    nx1 = x[1]; # Q does not change
    nx2 = x[2]; # P does not change
    nx3 = x[3] + 1/2 * x[1] * x[5]; # a changes
    nx4 = x[4] + 1/2 * x[5]; # y changes 
    nx5 = 1/2 * x[5] # d is halved 
    return [nx1, nx2, nx3, nx4, nx5]
end

F_next = [fnext1, fnext2] 

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 5; XMIN = -2.0; XMAX = 2.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
ADIM = 2; AMIN = -5.0; AMAX = 5.0; ADEG = 4; ADIV = 10

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

# Cond: branching conditions
Cond = [-1; x[3] - x[1]]
# template: template <= 0 is the invariant template
template = x[1] * x[4] + a[1] * x[3] + a[2] 

# preconditions and postconditions
precond = [-x[3]; x[3]; -x[4]; x[4]; x[5]-1; 1-x[5]] 
postcond = x[1] * x[4] - x[2]; 

# loopcond: the condition for loop to continue
loopcond = [-x[5] + 0.01]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[-x[1]; -x[2]; - x[3]; -x[4]; -x[5]; x[3] - x[2]] 
# additional_invariants = Polynomial{true, Float64}[]
