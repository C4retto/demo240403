function [pop,objvals] = init6(p, NetEmb, popsize)
	SimMatrix = Tosim_matrix(p.adj,1);
	cen = Centrality(p.adj, p.degree);
	EmbDist = squareform(pdist(NetEmb));
	[~,pnode1] = max(cen);
	
	classlabel = zeros(1, p.numVar);
	[~, farnode1] = max(EmbDist(pnode1, :));
	idx1 = kmeans(NetEmb, 2, 'Start', NetEmb([pnode1, farnode1], :));
	classlabel(idx1==idx1(pnode1)) = 1;
	classlabel(classlabel==0) = 2;
	
	condCenterFlag = false(1, p.numVar);
	condCenter = find(classlabel == 1);
	condCenterFlag(condCenter) = true;
	maxCenterNum = sum(condCenterFlag);
	
	pop = zeros(popsize, p.numVar);
	for i = 1:popsize
		chosenNum = randi([2,floor(sqrt(p.numVar))],1);
		randIndex = randperm(maxCenterNum, chosenNum);
		centerFlag = false(1, p.numVar);
		centerFlag(condCenter(randIndex)) = true;

		[~, loc] = max(SimMatrix(:, centerFlag), [], 2);
		centerNodes = find(centerFlag);
		label = centerNodes(loc);
		
		for ii = centerNodes
			tempFlag = (label(1,:)==ii);
            temp = find(tempFlag);
            [~,pred] = minspantree(graph(-SimMatrix(tempFlag,tempFlag)),'Root',sum(tempFlag(1,1:ii)));
			pred(pred==0) = sum(tempFlag(1,1:ii));
            pop(i,tempFlag) = temp(pred);

            idx = p.adj(ii,:) & tempFlag;
            if sum(idx)<=1
                idx = p.adj(ii,:);
            end
			pop(i,ii) = randsample(find(idx),1);
		end
	end
    objvals = p.func(pop, popsize);
end
