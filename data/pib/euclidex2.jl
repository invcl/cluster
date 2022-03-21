function fnext1(x) 
    nx1 = x[1] - x[2]; # a changes 
    nx2 = x[2]; # b does not change 
    nx3 = x[3] - x[4]; # p changes 
    nx4 = x[4]; # q does not change
    nx5 = x[5] - x[6]; # r changes 
    nx6 = x[6]; # s does not change
    nx7 = x[7]; # x does not change
    nx8 = x[8]; # y does not change 
    return [nx1, nx2, nx3, nx4, nx5, nx6, nx7, nx8]
end

function fnext2(x) 
    nx1 = x[1]; # a does not change 
    nx2 = x[2] - x[1]; # b changes 
    nx3 = x[3]; # p does not change 
    nx4 = x[4] - x[3]; # q changes 
    nx5 = x[5]; # r does not change 
    nx6 = x[6] - x[5]; # s changes 
    nx7 = x[7]; # x does not change 
    nx8 = x[8]; # y does not change 
    return [nx1, nx2, nx3, nx4, nx5, nx6, nx7, nx8]
end
F_next = [fnext1, fnext2] 

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 8; XMIN = -10.0; XMAX = 10.0; XDEG = 2

# ADIM: the number of parameters, parameters are a[1], ..., a[ADIM]
# AMIN, AMAX: the range of a[i]
# ADEG: the max degree of p(a) (as a polynomial over a[i])
ADIM = 6; AMIN = -5.0; AMAX = 5.0; ADEG = 4; ADIV = 10

# rangeA[i], rangeX[i]: range of a[i] and x[i]
rangeA = fill((AMIN, AMAX), ADIM)
rangeX = fill((XMIN, XMAX), XDIM)

@polyvar x[1:XDIM]
@polyvar a[1:ADIM]

# Cond: branching conditions
Cond = [x[2] - x[1]; x[1] - x[2]]
# template: template <= 0 is the invariant template
template1 = x[1] + a[1] * x[8] * x[5] + a[2] * x[7] * x[3] + a[3];
template2 = x[2] + a[4] * x[7] * x[4] + a[5] * x[8] * x[6] + a[6];

# preconditions and postconditions
precond = [x[1] - x[7]; x[7] - x[1]; x[2] - x[8]; x[8] - x[2]; x[3] - 1; 1 - x[3]; 
          -x[4]; x[4]; -x[5]; x[5]; x[6] - 1; 1 - x[6]] 
postcond = a - x[8] * x[5] - x[7] * x[3]; 

# loopcond: the condition for loop to continue
loopcond = [-1]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[1-x[1]; 1-x[2]; 1-x[3]; -x[4]; 1-x[5]; -x[6]; 1-x[7]; 1-x[8]] 
# additional_invariants = Polynomial{true, Float64}[]

