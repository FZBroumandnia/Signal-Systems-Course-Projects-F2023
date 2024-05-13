%%%%%%%%%%%%%%% part 4-3
table = readtable('diabetes-training.csv');
label=table.label;
table = removevars(table, 'label');
predictedLabel=trainedModel.predictFcn(table);


diff = sum(abs(predictedLabel-label));
percentage1= (1 - diff/length(label))*100

%%%%%%%%%%%%%%% part 4-4
table = readtable('diabetes-validation.csv');
label=table.label;
table = removevars(table, 'label');
predictedLabel=trainedModel.predictFcn(table);


diff = sum(abs(predictedLabel-label));
percentage2= (1 - diff/length(label))*100