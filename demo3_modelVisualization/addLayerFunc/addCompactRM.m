function net = addCompactRM(net, projDim, nc, learnW, dataset)
    wf = consts(dataset, 'projInitW', 'projDim', projDim, 'cfgId', 'compact_bilinear');
    if exist(wf, 'file') ==2
        fprintf('loading an old compact bilinear weight\n');
        load(wf);
    else
        factor=1.0/sqrt(projDim);
        fprintf('generating a new compact bilinear weight\n');
        init_w={{factor*(randi(2,nc, projDim)*2-3),...
                 factor*(randi(2,nc, projDim)*2-3)}};
        savefast(wf, 'init_w');
    end
    
    net.layers{end+1}=struct('type', 'custom',...
        'forward', @yang_compact_bilinear_RM_forward, ...
        'backward', @yang_compact_bilinear_RM_backward, ...
        'name', 'compact_RM', ...
        'weights', init_w,...
        'outDim', projDim, ...
        'learnW', learnW, ...
        'learningRate', [1 1]*learnW);
end