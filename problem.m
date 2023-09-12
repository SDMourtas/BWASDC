function [Xtr,Ytr,Xte,Yte,docYtr]=problem(x)
% Input and preparation of the training and testing data for the WASDC model
warning off

if x==1
filename1='ONETD.xlsx';     % ONET codes & occupations    
filename2='ISCO-ONET.xlsx'; % ISCO to ONET crosswalks
elseif x==2
filename1='ONETD.xlsx';     % ONET codes & occupations  
filename2='ONET-ISCO.xlsx'; % ONET to ISCO crosswalks
elseif x==3   
filename1='ISCOD.xlsx';     % ISCO codes & occupations 
filename2='ISCO-ONET.xlsx'; % ISCO to ONET crosswalks
elseif x==4
filename1='ISCOD.xlsx';     % ISCO codes & occupations 
filename2='ONET-ISCO.xlsx'; % ONET to ISCO crosswalks
end

% Sets
data1=readtable(filename1,'ReadVariableNames',true,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
docY0=data1.Code; lenY0=length(docY0); 
data2=readtable(filename2,'ReadVariableNames',true,'ReadRowNames' ,false,'TreatAsEmpty' ,'-');
docY1=data2.ISCO; docY2=data2.ONET;

% Train set
lenY=length(docY1); YY=zeros(lenY,1);
for i=1:lenY
    for j=1:lenY0
        if strcmp(docY2{i},docY0{j}) && (x==1 || x==2)
            YY(i)=j;
        elseif strcmp(docY1{i},docY0{j}) && (x==3 || x==4)
            YY(i)=j;
        end
    end
end

% remove codes that not exist
Ytimes=zeros(lenY0,1);
for i=1:lenY0
    Ytimes(i)=sum(YY==i);
end
data1(Ytimes==0,:)=[]; Ytimes(Ytimes==0)=[];

S2=string(data1.Description); S3=strings(sum(Ytimes),1); a=0;
for i=1:length(S2)
    s=split(S2(i),', ');
    lens=length(s);
    a=a(end)+(1:Ytimes(i));
    if lens<Ytimes(i)
        S3(a)=S2(i);
    else
        f=floor(lens/Ytimes(i));
        m=mod(lens,Ytimes(i));
        for j=1:Ytimes(i)
            ss=s((j-1)*f+1);
            for k=2:f                
                ss=strcat(ss,{', '},s((j-1)*f+k));
            end
            S3(a(j))=ss;
        end
        if m~=0
            for k=1:m                
                S3(a(j))=strcat(S3(a(j)),{', '},s(j*f+k));
            end
        end
    end
end

for i=1:length(S3)
    if x==1 || x==3
        S3(i)=strcat(docY1(i),{', '},S3(i));
    else
        S3(i)=strcat(docY2(i),{', '},S3(i));
    end
end

if x==1 || x==3
docYtr=docY2;
else
docYtr=docY1;
end
Ytr = (1:lenY)';
[Xtr,docXtr] = preprocessText(S3,Ytr);

% test set
Yte=[Ytr;Ytr]; n=lenY*2; docXte=cell(n,1);
for i=1:n/2
    s=split(S3(i),', ');
    docXte{i} = strcat(s(1),{', '},s(2));
    docXte{n/2+i} = strcat(s(1),{', '},s(end));
end
Xte = preprocessText(docXte,Yte,docXtr);

