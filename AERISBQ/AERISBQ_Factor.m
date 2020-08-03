function AERISBQ_Factor(N)
    v1 = BQF;
	v2 = BQF;
    i = 1;
    
    v1.value = zeros(i,4);
    v2.value = zeros(i,4);
    
    BQF_v = {v1, v2};
    
    %%Initializing with values obtained Round 0.
    v1.value(1,1:4) = BQF.BQF_construction(2, 1, 1, N);
    r = 1;
    s = 1;
    
    total_forms = 0;
    round_number = 0;
    
    foundSolution = false;
    
    while ~foundSolution
        round_number = round_number + 1;
        a = 2.^(round_number + 1);
        i = v1.value(end + 1);
        v2.value = zeros(i,3);
        BQF_children_round_i = BQF.BQF_create_children(a, r, s, N);
        BQF_children_round_i = BQF.BQF_remove_permutations(BQF_children_round_i);
        v1.value(i:(i + size(BQF_children_run_i)), 1:4) = BQF_children_round_i;
        v1.value = BQF.remove_permutations(BQF_v(1));
         
        
        p = a + r;
        q = 0; 
        if mod(N, p) == 0
            q = N/p;
            foundSolution = true
        else
            q = a + s;
            if mod(N, q) == 0
                p = N/q;
                foundSolution = true
            end
        end
        if foundSolution
            if (p > q)
                swap(p, q);