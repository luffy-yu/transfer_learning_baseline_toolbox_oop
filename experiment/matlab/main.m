clear all;
close all;

% init
addpath('../../code/gramm/',... % draw 
'../../code/EasyTL/',... % EasyTL
'../../code/transferlearning/code/traditional/',... % SVM, TJM, SA
'../../code/transferlearning/code/traditional/TCA/',... %TCA
'../../code/transferlearning/code/traditional/GFK/',... % GFK
'../../code/transferlearning/code/traditional/JDA/',... % JDA
'../../code/transferlearning/code/traditional/CORAL/',... % CORAL
'../../code/transferlearning/code/traditional/BDA/matlab/',... % BDA
'../../code/transferlearning/code/traditional/MEDA/matlab/',... % MEDA
'../../code/libsvm-3.24/matlab'); % SVM backend

%% dataset

% Amazon review dataset
amazon_review_dataset_path = '../../dataset/amazon_review/amazon_review/';
addpath(amazon_review_dataset_path);
amazon_review = AmazonReview(amazon_review_dataset_path);

% COIL 20 dataset
coil20_dataset_path = '../../dataset/COL20/';
addpath(coil20_dataset_path);
coil20 = COIL20(coil20_dataset_path);

% cross dataset
cross_dataset_path = '../../dataset/cross-dataset/cross-dataset/';
addpath(cross_dataset_path);
cross_dataset = CrossDataset(cross_dataset_path);

% Image CLEF dataset
imageclef_dataset_path = '../../dataset/imageCLEF_resnet50/';
addpath(imageclef_dataset_path);
image_clef = ImageCLEF(imageclef_dataset_path);

% Mnist-USPS dataset
mnist_usps_dataset_path = '../../dataset/mnist+usps/';
addpath(mnist_usps_dataset_path);
mnist_usps_dataset = MnistUSPS(mnist_usps_dataset_path);

% Office 31 dataset
office31_dataset_path = '../../dataset/office31_resnet50/';
addpath(office31_dataset_path);
office31_dataset = Office31(office31_dataset_path);

% Office Caltech dataset
office_caltech_dataset_path = '../../dataset/surf/';
addpath(office_caltech_dataset_path);
office_caltech_dataset = OfficeCaltech(office_caltech_dataset_path);

% Office Caltech dataset (decaf feature)
office_caltech_decaf_dataset_path = '../../dataset/decaf6/';
addpath(office_caltech_decaf_dataset_path);
office_caltech_decaf_dataset = OfficeCaltechDecaf(office_caltech_decaf_dataset_path);

% Office Home dataset
office_home_dataset_path = '../../dataset/Office-Home_resnet50/';
addpath(office_home_dataset_path);
office_home_dataset = OfficeHome(office_home_dataset_path);


% PIE dataset
pie_dataset_path = '../../dataset/PIE/';
addpath(pie_dataset_path);
pie_dataset = PIE(pie_dataset_path);


% VisDA dataset
visda_dataset_path = '../../dataset/VisDA_resnet50/';
addpath(visda_dataset_path);
visda_dataset = VisDA(visda_dataset_path);

% VLSC dataset
vlsc_dataset_path = '../../dataset/VLSC/';
addpath(vlsc_dataset_path);
vlsc_dataset = VLSC(vlsc_dataset_path);

% DomainNet dataset
domainnet_dataset_path = '../../dataset/DomainNet/';
addpath(domainnet_dataset_path);
domainnet_dataset = DomainNet(domainnet_dataset_path);
%% show result

show_result = ShowResult();

%% method
svm_method = SVMMethod();
tca_method = TCAMethod();
gfk_method = GFKMethod();
jda_method = JDAMethod();
tjm_method = TJMMethod();
coral_method = CORALMethod();
sa_method = SAMethod();
bda_method = BDAMethod();
meda_method = MEDAMethod();
easytl_method = EasyTLMethod();

%% run
datasets = {amazon_review, coil20, cross_dataset, image_clef, mnist_usps_dataset, office31_dataset, office_caltech_dataset, office_home_dataset, pie_dataset, visda_dataset, vlsc_dataset, domainnet_dataset};
dataset_count = size(datasets, 2);

methods = {svm_method, tca_method, gfk_method, jda_method, tjm_method, coral_method, sa_method, bda_method, meda_method, easytl_method};
method_count = size(methods, 2);

for i = 1: dataset_count
    dataset = datasets{i};
    for j = 1 : method_count
        method = methods{j};
        dataset.transferMethod = method;
        res = dataset.run();
        res_new = []; % run_new = dataset.run_new();
        show_result.show(dataset, method, res, res_new);
    end
end