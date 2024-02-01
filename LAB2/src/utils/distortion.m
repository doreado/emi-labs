function [eucl,perc] = distortion(original,mod)
    original = rgb2lab(original);
    mod = rgb2lab(mod);
    eucl = 0;
    dimensions = size(image);
    for i = 1:dimensions(1)
        for j = 1:dimensions(2)
            eucl = eucl + sqrt( (original(i,j,1)-mod(i,j,1))^2 + (original(i,j,2)-mod(i,j,2))^2 + (original(i,j,3)-mod(i,j,3))^2 );
        end
    end

    perc = ( eucl / (size(original)*size(mod)*sqrt(100^2 + 255^2 + 255^2)) )*100;

end