function [testlabel, testdata] = readtest(nclass,nexample)
% read test data from the given examples in class
% Input:
%    - nclass: 2 or 3, to read for the 2-class or 3-class examples
%    - nexample: 1 or 2, to read for the first or second example in each case
% following the order presented in the lecture note
% output:
%    - testdata: matrix, each column is one test data and the number
%    of columns is the number of data in the set

if nclass ==2
    if nexample == 1
        fid = fopen('data/txtdata/testdata2C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 20]);
        fclose(fid);
        fid = fopen('data/txtdata/testlabel2C.txt','r');
        testlabel = fscanf(fid,'%d \n',[1, 20]);
        fclose(fid);
    elseif nexample == 2
        fid = fopen('data/txtdata/testdata_ESL_2C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 20]);
        fclose(fid);
        fid = fopen('data/txtdata/testlabel_ESL_2C.txt','r');
        testlabel = fscanf(fid,'%d \n',[1, 20]);
        fclose(fid);
    end
elseif nclass == 3
    if nexample == 2
        fid = fopen('data/txtdata/testdata3C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 30]);
        fclose(fid);
        fid = fopen('data/txtdata/testlabel3C.txt','r');
        testlabel = fscanf(fid,'%d \n',[1, 30]);
        fclose(fid);
    elseif nexample == 1
        fid = fopen('data/txtdata/testdata_ESL_3C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 30]);
        fclose(fid);
        fid = fopen('data/txtdata/testlabel_ESL_3C.txt','r');
        testlabel = fscanf(fid,'%d \n',[1, 30]);
        fclose(fid);
    end
elseif nclass == 10
   [img, lbl] = read_hw;
   testdata = img(:,16001:20000);
   testlabel = lbl(16001:20000)+1;
end
end
    
