try
    if tg.connected
        for i = 1:21
            l = size(tg.getparam(i),1);
            if l >= 5
                ii = i;
            end
        end
        tg.setparam(ii,[K;Ti;Td;mu;theta(:)]);
    end
catch ME
end