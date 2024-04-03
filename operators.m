function offspring = operators(p,parents,pm,pc,pc2)

offspring = parents;
numVar = p.numVar;

leaf1 = ~ismember(1:numVar, parents(1,:));
leaf2 = ~ismember(1:numVar, parents(2,:));
leaf3 = ~ismember(1:numVar, parents(3,:));

midx = (rand(1,numVar) <= pm);
for i = 1:numVar
	if midx(i)
		offspring(1,i) = randsample(find(p.adj(i,:)==1),1);
	end
end

% -------------------------------------------

ridx = (rand(1,p.numVar) <= pc);
idx2 = ridx & leaf2 & ~leaf3;
idx3 = ridx & ~leaf2 & leaf3;
idx = ridx & (leaf2|leaf3);
% -------------------------------------------
for i = 1:numVar
	if idx3(i) || idx3(parents(2,i)) || (~idx(i) && (rand(1,1) <= pc2))
		offspring(2,i) = parents(3,i);
	end
	if idx2(i) || idx2(parents(3,i)) || (~idx(i) && (rand(1,1) <= pc2))
		offspring(3,i) = parents(2,i);
	end
end
end