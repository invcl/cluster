function fnext(x) 
    nx1 = x[2]; # a changes 
    nx2 = x[3]; # b changes 
    nx3 = x[3]; # c does not change 
    nx4 = x[4]; # quot does not change 
    nx5 = x[6]; # p changes 
    nx6 = x[5] - x[6] * x[4]; # q changes 
    nx7 = x[8]; # r changes 
    nx8 = x[7] - x[8] * x[4]; # s changes 
    nx9 = x[9]; # x does not change
    nx10 = x[10]; # y does not change 
    return [nx1, nx2, nx3, nx4, nx5, nx6, nx7, nx8, nx9, nx10]
end

F_next = [fnext] 

# XDIM: the number of variables, varaibles are x[1], ..., x[XDIM]
# XMIN, XMAX: the range of x[i]
# XDEG: the max degree of the invariant (as a polynomial over x[i])
XDIM = 10; XMIN = -10.0; XMAX = 10.0; XDEG = 2

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
Cond = [-1]
# template: template <= 0 is the invariant template
template1 = x[1] + a[1] * x[10] * x[7] + a[2] * x[9] * x[5] + a[3];
template2 = x[2] + a[4] * x[9] * x[6] + a[5] * x[10] * x[8] + a[6];

# preconditions and postconditions
precond = [x[1] - x[9]; x[9] - x[1]; x[2] - x[10]; x[10] - x[2]; x[5] - 1; 1 - x[5]; 
          -x[6]; x[6]; -x[7]; x[7]; x[8] - 1; 1 - x[8]] 
postcond = a - x[10] * x[7] - x[9] * x[5]; 

# loopcond: the condition for loop to continue
loopcond = [1 - x[2]]

# additional_invariants: invariants which have been proven
additional_invariants = Polynomial{true, Float64}[x[1] - x[4] * x[2] + x[3]; -x[1] + x[4] * x[2] - x[3]; 
    1-x[1]; 1-x[2]; -x[3]; -x[4]; 1 - x[5]; -x[6]; 1 - x[7]; -x[8]; 1 - x[9]; 1 - x[10]] 
# additional_invariants = Polynomial{true, Float64}[]

