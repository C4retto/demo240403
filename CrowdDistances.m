function CrowdDistances = CrowdDistance(FunctionValue,FrontValue)
    [N,M] = size(FunctionValue);
    CrowdDistances = zeros(1,N);
    Fronts = setdiff(unique(FrontValue),inf);
    for f = 1 : length(Fronts)
        Front = find(FrontValue==Fronts(f));
        Fmax = max(FunctionValue(Front,:),[],1);
        Fmin = min(FunctionValue(Front,:),[],1);
        for i = 1 : M
            [~,Rank] = sortrows(FunctionValue(Front,i));
            CrowdDistances(Front(Rank(1))) = inf;
            CrowdDistances(Front(Rank(end))) = inf;
            for j = 2 : length(Front)-1
                CrowdDistances(Front(Rank(j))) = CrowdDistances(Front(Rank(j)))+(FunctionValue(Front(Rank(j+1)),i)-FunctionValue(Front(Rank(j-1)),i))/(Fmax(i)-Fmin(i));
            end
        end
    end
end

