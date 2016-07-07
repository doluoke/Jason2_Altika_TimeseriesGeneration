%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes the Interquantile Range (IQR) of a 
% column data
% Written by: Modurodoluwa Okeowo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ lower_Lim upper_Lim ] = iqrange( Data_4lim )
%IQRANGE Summary of this function goes here
%   Detailed explanation goes here
Q1=quantile(Data_4lim(:,5),0.25);
Q3=quantile(Data_4lim(:,5),0.75);
IQR=iqr(Data_4lim(:,5)); % Compute IQR
lower_Lim=Q1-(2*IQR); % Lower Limit
upper_Lim=Q3+(2*IQR); % Upper limit
end

