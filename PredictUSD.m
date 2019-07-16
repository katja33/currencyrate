clear; close all;

url = 'http://spreadsheets.google.com/feeds/list/0Av2v4lMxiJ1AdE9laEZJdzhmMzdmcW90VWNfUTYtM2c/4/public/basic?alt=json';
outtype = 'JSON';
options = weboptions;
options.Timeout = Inf;

num = 1000;

DataTable = table('Size', [num 2], 'VariableTypes',["datetime","double"]);

figure;
for ii = 1:num
    data = webread(url, 'outtype', outtype, options);
    
    t_data = data.feed.entry(2).updated;
    t_data = struct2table(t_data);
    t_data = table2array(t_data);
    t_data_f = t_data(1:10);
    t_data_l = t_data(12:end-1);
    clear t_data;
    t_data = [t_data_f, ' ', t_data_l];
    t_data = datetime(t_data,'InputFormat',"yyyy-MM-dd HH:mm:ss.SSS");
    y_data = data.feed.entry(2).content.x_t;
    y_data = y_data(9:end);
    y_data = str2double(y_data);
    
    DataTable.Var1(ii) = t_data;
    DataTable.Var2(ii) = y_data;
    
    plot(DataTable.Var1, DataTable.Var2);
    drawnow;
end
