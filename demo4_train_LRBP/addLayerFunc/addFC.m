function net=addFC(net, name, initFCparam, initMethod)
    if strcmp(initMethod, 'random')
        initFCparam={{init_weight('xavierimproved', 1, 1, initFCparam(1), initFCparam(2), 'single'),...
                      zeros(initFCparam(2), 1, 'single')}};
    elseif strcmp(initMethod, 'specified')
        % nothing should be done
    else
        error('In addFC, unknown parameter initialization method.');
    end
    
    net.layers{end+1} = struct('type', 'conv', 'name', name, ...
       'weights', initFCparam, ...
       'stride', 1, ...
       'pad', 0, ...
       'learningRate', [1 2],...
       'weightDecay', [0 0], ...
       'precious', 1);
end