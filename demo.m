function pop = demo(p, popsize, maxgen,pm,pc,pc2,NetEmb)

    [pop, objvals] = init6(p, NetEmb, popsize);
    FrontV = NonDominateSort(objvals,0);
    CrowdD = CrowdDistances(objvals,FrontV);

    offspring = zeros(popsize,p.numVar);
    parents = zeros(3,p.numVar);
    for i = 1:maxgen
        MatingP = Mating(pop,FrontV,CrowdD);
        for indi = 1:3:size(MatingP,1)
            parents(1:3,:) = MatingP(indi:indi+2,:);
            offspring(indi:indi+2,:) = operators(p,parents,pm,pc,pc2);
        end
        pop = [pop;offspring];
        objvals = p.func(pop, 2*popsize);
        [FrontV, MaxFront] = NonDominateSort(objvals,1);
        CrowdD = CrowdDistances(objvals,FrontV);
        Next = zeros(1,popsize);
        NoN = numel(FrontV,FrontV<MaxFront);
        Next(1:NoN) = find(FrontV<MaxFront);
        Last = find(FrontV==MaxFront);
        [~,Rank] = sort(CrowdD(Last),'descend');
        Next(NoN+1:popsize) = Last(Rank(1:popsize-NoN));
        pop = pop(Next,:);
        FrontV = FrontV(Next);
        CrowdD = CrowdD(Next);
    end
end