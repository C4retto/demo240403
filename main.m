function main
    pname = 'email';
    embfile = sprintf('dataset/embeddings.emb');
    NetEmb = EmbRead(embfile);

    p = testnetwork(pname);
    popsize = 102;
    runTime = 20;
        result = zeros(4,runTime);
        for runtime = 1:runTime
            [pop,~] = init6(p, NetEmb, popsize);
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
