function main
    pname = 'email';
    embfile = sprintf('dataset/embeddings.emb');
    NetEmb = EmbRead(embfile);

    maxgen = 100;
    popsize = 102;
    pm = 0.15;
    pc = 0.5;
    pc2 = 0.5;

    p = testnetwork(pname);
    runTime = 20;
        result = zeros(4,runTime);
        for runtime = 1:runTime
            pop = demo(p,popsize,maxgen,pm,pc,pc2,NetEmb);
            modular = zeros(1,popsize);
            for ii = 1:popsize
                modular(1,ii) = modularity(p.adj, Decode(pop(ii,:)));
            end
            result(1,runtime) = min(modular);
            result(2,runtime) = min(modular);
            result(3,runtime) = std(modular);
            result(4,runtime) = mean(modular);
        end
        disp(result);
end
