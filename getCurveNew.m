

currencies = ["AED", "AUD", "BHD", "CAD", "CHF", "CNY", "CZK", "DKK", ...
              "EUR", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "ISK", ...
              "JPY", "KES", "KRW", "KWD", "MXN", "MYR", "NOK", "NZD", ...
              "PHP", "PKR", "PLN", "QAR", "RON", "RUB", "SAR", "SEK", ...
              "SGD", "THB", "TRY", "TWD", "UGX", "USD", "ZAR"]';
deviationPunishment = ...
             0.1*[100,    100,    100,    100,    100,    100,    100,    100, ...
              100,    100,    100,    100,    100,    100,    100,    100, ...
              100,    100,    100,    100,    100,    100,    100,    100, ...
              100,    100,    100,    100,    100,    100,    100,    100, ...
              100,    100,    100,    100,    100,    100,    100];


days = 3650;
n_f = days;
dt = 1/365;
%C = getC(days);

for i = 4:4
    df = matfile('\\ad.liu.se\home\adaen534\Desktop\profit_decomposition-main\InterestRateCurves\3MonthDiscountFactors\' + currencies(i) + 'dF.mat');
    discountFactors = df.discountFactors;
    t = matfile('\\ad.liu.se\home\adaen534\Desktop\profit_decomposition-main\InterestRateCurves\3MonthT\' + currencies(i) + 'T.mat');
    T = t.T;
    d = matfile('\\ad.liu.se\home\adaen534\Desktop\profit_decomposition-main\InterestRateCurves\3MonthDates\' + currencies(i) + 'Dates.mat');
    dates = d.dates; 
    %for day = 1:numel(dates)
    f = zeros(n_f, numel(dates));
    for day = 1:numel(dates)
        [Tday, n_r, discountFactorsDay] = getDayData(T, discountFactors(:, day));  
        logDiscountFactors = -log(discountFactorsDay)';
        [A_s, B_s, C_s] = matrixGeneration(deviationPunishment(i), Tday , n_f, n_r, dt);
        f(:,day) = A_s*logDiscountFactors;
    end
    save('\\ad.liu.se\home\adaen534\Desktop\profit_decomposition-main\InterestRateCurves\Curves\' + currencies(i) + '.mat', 'f');
end
    



