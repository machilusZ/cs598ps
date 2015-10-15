function [ output_args ] = l10_40( input_args )

    % using kuhn tucker theorem convert problem to
    % maximize L(alpha) = 
    %           sum(1,n)(alpha_i) -
    %           1/2*alpha'Halpha
    % constrained to alpha_i >= 0 and sum(1,n)(alpha_i*z_i) = 0

    x = [ 1 6; 1 10; 4 11; 5 2; 7 6; 10 4 ];
    z = [ 1; 1; 1; -1; -1; -1; ];
    
    H = (x * x') .* (z * z');
    
    % matlab expects quadratic programming to be stated in canonical
    % (standard) form which is 
    % minimize P(x) = 0.5x'Hx + f'x
    % constrained to Ax <= a and Bx = b
    % where A, B, H are n by n matrices and f, a, b are vectors
    
    % convert optimization problem to canonical form by multiplying by -1
    
    f = -1 * ones(6,1);
    
    % then we have the following optimization problem
    % minimize L(alpha) = f'alpha + 1/2alpha'Halpha
    
    % first constraint is alpha_i >= 0
    A = -1 * eye(6);
    a = zeros(6,1);
    
    % second constraint is sum(1,n)(alpha_i*z_i) = 0
    B = [ z'; zeros(5,6) ];
    b = zeros(6,1);
    
    alpha = quadprog(H+eye(6)*0.001,f,A,a,B,b);
    
    % find w  using w = sum(1,n)(alpha_i*z_i*x_i = (alpha.*z)'*x
    w = (alpha .* z)' * x;
    
    w_0 = 1 - w * x(1,:)';
    
    Xax = 0:20; 
    Yax=-(w_0+Xax*w(1))/w(2);
    plot(Xax,Yax);
end
