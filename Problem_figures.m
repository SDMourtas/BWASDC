function Problem_figures(Y1_pr,Y1,Y2_pr,Y2,E,Em,A,N,R,x)

figure
plot(1:length(E),E,'Color',[0.9290 0.6940 0.1250],...
    'DisplayName','Training Error')
hold on
plot(find(E==Em),E(E==Em),'.','Color',[0.4940 0.1840 0.5560],...
    'MarkerSize',20,'DisplayName','Minimum Point')
if sum(E==Em)>1
plot(R,E(R),'h','Color',[0.4660 0.6740 0.1880],...
    'MarkerSize',12,'DisplayName','Minimum Point with \newlineminimum neurons number')
end
xlabel('Iteration'); ylabel('MAE'); xlim([1 21]);
legend
hold off

figure
plot(1:length(N),N,'Color',[0.9290 0.6940 0.1250],...
    'DisplayName','Training neurons number')
hold on
txt = ['Optimal neurons number \newlinewith powers [',num2str(A'),']'];
plot(R,N(R),'.','Color',[0.4940 0.1840 0.5560],...
    'MarkerSize',20,'DisplayName',txt)
xlabel('Iteration'); ylabel('Hidden Layer Neurons'); xlim([1 21]);
legend
hold off

figure
n=size(Y1_pr,2); cor=zeros(n,1); incor=cor;
for i=1:n
test_results=Y1_pr(:,i)==Y1; 
len=length(test_results); cor(i)=sum(test_results); incor(i)=len-cor(i);
end

b=[cor,incor];
Bar=bar(1:n,b);
ctr=zeros(2,n);ydt=ctr;
for i = 1:2
    ctr(i,:)=bsxfun(@plus, Bar(i).XData, Bar(i).XOffset'); 
    ydt(i,:)=Bar(i).YData;                                  
end
for i=1:n
    text(ctr(:,i),ydt(:,i),sprintfc('%d',ydt(:,i)),...
        'horiz','center', 'vert','bottom')
end
set(Bar(1),'FaceColor',[0.4940 0.1840 0.5560]) ;
set(Bar(2),'FaceColor',[0.9290 0.6940 0.1250]) ;
box on
ylabel('Training Set Samples')
if x==1 || x==3
xlabel('O*NET Classification Results')
else
xlabel('ISCO Classification Results')
end
xticklabels({'BWASDC','FTR','NNN','EBT','FKN'})
legend('Correct','Incorrect')

figure
n=size(Y1_pr,2); cor=zeros(n,1); incor=cor;
for i=1:n
test_results=Y2_pr(:,i)==Y2; 
len=length(test_results); cor(i)=sum(test_results); incor(i)=len-cor(i);
end

b=[cor,incor];
Bar=bar(1:n,b);
ctr=zeros(2,n);ydt=ctr;
for i = 1:2
    ctr(i,:)=bsxfun(@plus, Bar(i).XData, Bar(i).XOffset'); 
    ydt(i,:)=Bar(i).YData;                                  
end
for i=1:n
    text(ctr(:,i),ydt(:,i),sprintfc('%d',ydt(:,i)),...
        'horiz','center', 'vert','bottom')
end
set(Bar(1),'FaceColor',[0.4940 0.1840 0.5560]) ;
set(Bar(2),'FaceColor',[0.9290 0.6940 0.1250]) ;
box on
ylabel('Testing Set Samples')
if x==1 || x==3
xlabel('O*NET Classification Results')
else
xlabel('ISCO Classification Results')
end
xticklabels({'BWASDC','FTR','NNN','EBT','FKN'})
legend('Correct','Incorrect')
