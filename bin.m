%   display in train.m
switch draw
        case 0
        case 1 %    function shape
            xt = (-300:300)';
            tout = influFunc(xt, influenceFunc, 1);
            yt = tout * c;
            plot(xt,yt);
            title(['Function shape in the ',num2str(i),'th iteration'])
            %ylim([-2 2])
            pause(0.1)
        case 2 %    loss
            plot(1:i, e);
            title(['Cost in the ',num2str(i),'th iteration'])
            pause(0.1)
        case 3 %    SNR
            plot(1:i, SNR);
            title(['SNR in the ',num2str(i),'th iteration'])
            pause(0.1)
end
    
%   wrong code in nLinearNet

dXdw = (dXdwPre...
    - (gamma/(delta^2)) * dXdwPre' * H' * diag(gradDx2(:,:,iLayer) * weights)* H...%
    - (gamma/delta) * gradDx(:,:,iLayer)' * H)';
dXdw  = dXdw' * diag(softThreshold(z(:,iLayer), lambda * gamma, 1));
dXdwPre = dXdw';