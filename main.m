function main
    pname = 'email';
    embfile = sprintf('dataset/embeddings.emb');
    NetEmb = EmbRead(embfile);

    maxgen = 100;
    popsize = 102;
    pm = 0.15;
    pc = 0.1:0.2:0.9;
    pc2 = 0.1:0.2:0.9;

    p = testnetwork(pname);
    runTime = 10;
    for cc = pc
    for cc2 = pc2
        disp([cc,cc2]);
        %result = zeros(4,runTime);
        result = zeros(1,runTime);
        for runtime = 1:runTime
            pop = demo(p,popsize,maxgen,pm,cc,cc2,NetEmb);
            modular = zeros(1,popsize);
            for ii = 1:popsize
                modular(1,ii) = modularity(p.adj, Decode(pop(ii,:)));
            end
            result(1,runtime) = min(modular);
            %result(2,runtime) = max(modular);
            %result(3,runtime) = std(modular);
            %result(4,runtime) = mean(modular);
        end
        disp(result);
    end
    end
end
