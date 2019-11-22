function idx = trim_1Ddata(x, active_L)
% syntax:  idx = trim_1Ddata(x, active_L)
% x should be a vector; active_L should be a scalar


    L = x(end,1)-x(1,1) ;
    x0 = x(1,1);

    if active_L>L
        disp('please enter an active length < full length')  
        return
    end
  
    idx = (x(:,1)>=(-active_L)/2)&(x(:,1)<=(active_L)/2); %x is centred!!

    if active_L>x(find(idx,1,'last'),1)-x(find(idx,1,'first'),1) % this corrects for active length (please check if it's OK)
        disp('analysis length is shorter')
        x(find(idx,1,'last'),1)-x(find(idx,1,'first'),1)
    end



