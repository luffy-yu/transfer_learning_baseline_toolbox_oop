# transfer_learning_baseline_toolbox_oop

Transfer Learning Baseline Toolbox Based on Object Oriented Programming

## Tables of content ##

- [About](#about)

- [Features](#features)

- [Usage](#usage)

- [Acknowledgements](#acknowledgements)

- [References](#references)

## About ##

These are some parts of experiment in my graduation thesis. In my opinion, it will be helpful if I open source these fundamental modules, especially for those who research on transfer learning.

## Features ##

- Design in `OOP`

- Abstract datasets and methods in `Matlab` language

- Support **10** transfer learning methods

    - `SVM`

    - `TCA` [1]

    - `GFK` [2]

    - `JDA` [3]

    - `SA` [4]

    - `TJM` [5]

    - `CORAL` [6]

    - `BDA` [7]

    - `MEDA` [8]

    - `EasyTL` [9]

**Note: Official code locates in [EasyTL](/code/transferlearning/code/traditional/EasyTL), while code in [code/EasyTL](/code/EasyTL) is introduced into other datasets by myself.**

- Support **12** transfer learning datasets

    - `Amazon Review` [10]

    - `COIL20` [11]

    - `Cross Dataset` [12]

    - `Image CLEF` [13]

    - `Mnist USPS` [14]

    - `Office31` [15]

    - `Office Caltech` [16]

    - `Office Home` [17]

    - `PIE` [18]

    - `VisDA` [19]

    - `VLSC` [20]

    - `DomainNet` [21]

- Dataset download available

<https://pan.baidu.com/s/1RkevNoLAJ5pRkeDi0qMr_A>KEY: kamt

> Dataset visualization, see <https://github.com/luffy-yu/vis_datasets>

- Implement in `Matlab` and `Python` languages

- Visualize result in `svg` images

- Output result in `csv` files

- Supply sample data

- Easy to use

- Simple analysis

## Usage ##

### Run baseline

- Setup Matlab environment

- Put dataset input `dataset/` directory

- Run main.m in Matlab

```matlab
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
```

- Show result and make two files

A csv file named after `compare_of_method_<Method>_dataset_<Dataset>.csv` and a png file named `compare_of_method_<Method>_dataset_<Dataset>.csv` will generated in the same folder where main.m locates.

> `<Method>` refers to transfer learning method, e.g. SVM defined by `obj.methodName = 'SVM';` in <a href='/experiment/matlab/SVMMethod.m'>SVMMethod.m</a>.

> `<Dataset>` refers to transfer learning dataset, e.g. Amazon_Review defined by `obj.datasetName = 'Amazon Review';` in <a href='/experiment/matlab/AmazonReview.m'>AmazonReview.m</a>.

- files example

1. when `res_new = [];`

<a href='/experiment/matlab/compare_of_method_EasyTL_dataset_Amazon_Review.csv'>compare_of_method_EasyTL_dataset_Amazon_Review.csv</a>

```csv
Method,Direction,Accurate
Old,books-dvd,0.797898949474737
Old,books-elec,0.796796796796797
Old,books-kitchen,0.809404702351176
Old,dvd-books,0.799
Old,dvd-elec,0.808308308308308
Old,dvd-kitchen,0.819909954977489
Old,elec-books,0.75
Old,elec-dvd,0.753376688344172
Old,elec-kitchen,0.848924462231116
Old,kitchen-books,0.765
Old,kitchen-dvd,0.763381690845423
Old,kitchen-elec,0.825325325325325
```

<a href='/experiment/matlab/compare_of_method_EasyTL_dataset_Amazon_Review.png'>compare_of_method_EasyTL_dataset_Amazon_Review.png</a>

[compare_of_method_EasyTL_dataset_Amazon_Review.png](/experiment/matlab/compare_of_method_EasyTL_dataset_Amazon_Review.png)


2. when `run_new = dataset.run_new();`

<a href='/experiment/matlab/compare_of_method_EasyTL_dataset_Amazon_Review_2.csv'>compare_of_method_EasyTL_dataset_Amazon_Review_2.csv</a>

```csv
Method,Direction,Accurate
Old,books-dvd,0.797898949474737
Old,books-elec,0.796796796796797
Old,books-kitchen,0.809404702351176
Old,dvd-books,0.799
Old,dvd-elec,0.808308308308308
Old,dvd-kitchen,0.819909954977489
Old,elec-books,0.75
Old,elec-dvd,0.753376688344172
Old,elec-kitchen,0.848924462231116
Old,kitchen-books,0.765
Old,kitchen-dvd,0.763381690845423
Old,kitchen-elec,0.825325325325325
New,books-dvd,0.803901950975488
New,books-elec,0.807307307307307
New,books-kitchen,0.824912456228114
New,dvd-books,0.8085
New,dvd-elec,0.813313313313313
New,dvd-kitchen,0.83191595797899
New,elec-books,0.771
New,elec-dvd,0.753376688344172
New,elec-kitchen,0.849924962481241
New,kitchen-books,0.7785
New,kitchen-dvd,0.769884942471236
New,kitchen-elec,0.833333333333333
```

<a href='/experiment/matlab/compare_of_method_EasyTL_dataset_Amazon_Review_2.png'>compare_of_method_EasyTL_dataset_Amazon_Review_2.png</a>

[compare_of_method_EasyTL_dataset_Amazon_Review_2.png](/experiment/matlab/compare_of_method_EasyTL_dataset_Amazon_Review_2.png)

### Customize Dataset

- Inherit `Dataset` in [Dataset.m](/experiment/matlab/Dataset.m)

**Note: Currently, old method refers to load original dataset, while new one refers to load new, in other words, processed dataset.**

- Implement Construct Method

```matlab
obj@Dataset();
obj.datasetName = 'NAME';
obj.datasetPath = datasetpath;
obj.sourceDomains = {...};
obj.targetDomains = {...};
obj.new_sourceDomains = {...};
obj.new_targetDomains = {...};
```

- Implement `load_source_domain(obj, name, tar_name)` method

- Implement `load_target_domain(obj, name, tar_name)` method

- (Optional) Implement `run(obj)` method

- (Optional) Implement `run_new(obj)` method

### Customize Method

- Inherit `TransferMethod` in [TransferMethod.m](/experiment/matlab/TransferMethod.m)

- Define properties(including parameters of some Transfer Learning methods) in Construct Method

```matlab
obj.methodName = '';
```

- Implement `transfer(obj, Xs,Ys,Xt,Yt)` method

**Note: Use `obj.properties` to get parameters defined in Construct Method.**

### Run Customized Dataset and/or Method

- clear

- add dependencies path

- initialize `ShowResult` instance, see class definition in [ShowResult.m](/experiment/matlab/ShowResult.m)

- initialize `Dataset` instance

- initialize `Method` instance

- run

- demo code, partly taking from [main.m](/experiment/matlab/main.m)

```matlab
clear all;
close all;

% init
addpath('../../code/gramm/',... % draw 
'../../code/EasyTL/',... % EasyTL
'../../code/libsvm-3.24/matlab'); % SVM backend

% Amazon review dataset
amazon_review_dataset_path = '../../dataset/amazon_review/amazon_review/';
addpath(amazon_review_dataset_path);
amazon_review = AmazonReview(amazon_review_dataset_path);

%% method
easytl_method = EasyTLMethod();

%% run
amazon_review.transferMethod = easytl_method;
res = amazon_review.run();
run_new = amazon_review.run_new();
show_result.show(amazon_review, easytl_method, res, res_new);
```

### Visualize Result in Python Language ###

- initialize python environment

The full experiment environment is [experiment.yml](experiment.yml). Therefore, some dependencies are unnecessary.

- change work dir where csv files locate

```python
cur_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(os.path.join(cur_dir, '../../sample'))
```

- Visualize one csv file only

```python
vis = Visualize()
vis.show_csv('compare_of_method_BDA_dataset_Amazon_Review.csv')
```

[screenshot.jpg](/sample/screenshot.jpg)

- Visualize and analyze one dataset

```python
AmazonReview()()
```

4 files will be generated in work dir.

> (1) Amazon_Review_3x3.svg

Plot figures in 9 subplots, each subplot contains one method.

[Amazon_Review_3x3.svg](/sample/Amazon_Review_3x3.svg)

> (2) Amazon_Review_all_in_one.svg

Plot figures in ONE plot. 

[Amazon_Review_all_in_one.svg](/sample/Amazon_Review_all_in_one.svg)

> (3) Amazon_Review_all_in_one.xlsx

Summary metrics of all csv files.

[Amazon_Review_all_in_one.xlsx](/sample/Amazon_Review_all_in_one.xlsx)

[Screenshot](/sample/screenshot_xlsx.jpg)

**Note: `*` indicates the larger. **

> (4) stat_file.json

Make a brief statictics statistics.

[stat_file.json](/sample/stat_file.json)

```json
{
  "Amazon Review Dataset": {  # dataset name
    "total": "108",  # experiments count
    "win_count": "105",  # count of 'new > old'
    "win_rate": "97.22",  # win_count / total
    "min_increase": "-1.65",  # min increase, in percentile unit
    "max_increase": "6.11",  # max increase, in percentile unit
    "avg_increase": "1.78"  # average increase, in percentile unit
  }
}
```

- Make a simple report

```python
Stat()()
```

This operation will update stat_file.json.

A simple file is as follows.

```json
{
  "Amazon Review Dataset": {
    "total": "108",
    "win_count": "105",
    "win_rate": "97.22",
    "min_increase": "-1.65",
    "max_increase": "6.11",
    "avg_increase": "1.78",
    "desc": "在本数据集的108个实验中，共有105个实验的结果得到提升，占比97.22%。最小提升为-1.65%，最大提升为6.11%，平均提升为1.78%。"
  },
  "Summary": {
    "total": "108",
    "win_count": "105",
    "win_rate": "97.22",
    "min_increase": "-1.65",
    "max_increase": "6.11",
    "avg_increase": "1.78",
    "desc": "在本章节的108个实验中，共有105个实验的结果得到提升，占比97.22%。最小提升为-1.65%，最大提升为6.11%，平均提升为1.78%。"
  }
}
```

You can define your own description template in `Line 398`, File [visualize_result.py](/experiment/python/visualize_result.py).

```python
template = '在本数据集的{total}个实验中，共有{win_count}个实验的结果得到提升，占比{win_rate}%。最小提升为{min_increase}%，' \
           '最大提升为{max_increase}%，平均提升为{avg_increase}%。'
```

- Merge figures of different datasets

```python
Visualize().merge([MnistUSPS, PIE, OfficeCaltech, ImageCLEF], outname='mnist-usps_pie_officecaltech_imageclef.svg')
```

[mnist-usps_pie_officecaltech_imageclef.svg](/sample/mnist-usps_pie_officecaltech_imageclef.svg)

## Acknowledgements ##

This was inspired and/or used code from:

- [transferleaning](https://github.com/jindongwang/transferlearning)

- [gramm](https://github.com/piermorel/gramm)

## References ##

- [1] Pan S J, Tsang I W, Kwok J T, et al. Domain adaptation via transfer component analysis[J]. IEEE Transactions on Neural Networks, 2011, 22(2): 199-210.

- [2] Gong B, Shi Y, Sha F, et al. Geodesic flow kernel for unsupervised domain adaptation[C]. 2012 IEEE Conference on Computer Vision and Pattern Recognition, 2012: 2066-2073.

- [3] Long M, Wang J, Ding G, et al. Transfer feature learning with joint distribution adaptation[C]. Proceedings of the IEEE international conference on computer vision, 2013: 2200-2207.

- [4] Fernando B, Habrard A, Sebban M, et al. Unsupervised visual domain adaptation using subspace alignment[C]. Proceedings of the IEEE international conference on computer vision, 2013: 2960-2967.

- [5] Long M, Wang J, Ding G, et al. Transfer joint matching for unsupervised domain adaptation[C]. Proceedings of the IEEE conference on computer vision and pattern recognition, 2014: 1410-1417.

- [6] Sun B, Feng J, Saenko K. Return of frustratingly easy domain adaptation[C]. Thirtieth AAAI Conference on Artificial Intelligence, 2016.

- [7] Wang J, Chen Y, Hao S, et al. Balanced distribution adaptation for transfer learning[C]. 2017 IEEE International Conference on Data Mining (ICDM), 2017: 1129-1134.

- [8] Wang J, Feng W, Chen Y, et al. Visual domain adaptation with manifold embedded distribution alignment[C]. Proceedings of the 26th ACM international conference on Multimedia, 2018: 402-410.

- [9] Wang J, Chen Y, Yu H, et al. Easy transfer learning by exploiting intra-domain structures[C]. 2019 IEEE International Conference on Multimedia and Expo (ICME), 2019: 1210-1215.

- [10] Chen M, Xu Z, Weinberger K, et al. Marginalized denoising autoencoders for domain adaptation[J]. arXiv preprint arXiv:1206.4683, 2012.

- [11] Long M, Wang J, Ding G, et al. Transfer feature learning with joint distribution adaptation[C]. Proceedings of the IEEE international conference on computer vision, 2013: 2200-2207.

- [12] A Testbed for Cross-Dataset Analysis[EB/OL]. https://sites.google.com/site/crossdataset/home/files

- [13] ImageCLEF[EB/OL]. https://www.imageclef.org/2014/adaptation

- [14] Long M, Wang J, Ding G, et al. Transfer feature learning with joint distribution adaptation[C]. Proceedings of the IEEE international conference on computer vision, 2013: 2200-2207.

- [15] Saenko K, Kulis B, Fritz M, et al. Adapting visual category models to new domains[C]. European conference on computer vision, 2010: 213-226.

- [16] Gong B, Shi Y, Sha F, et al. Geodesic flow kernel for unsupervised domain adaptation[C]. 2012 IEEE Conference on Computer Vision and Pattern Recognition, 2012: 2066-2073.

- [17] Venkateswara H, Eusebio J, Chakraborty S, et al. Deep hashing network for unsupervised domain adaptation[C]. Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition, 2017: 5018-5027.

- [18] Sim T, Baker S, Bsat M. The CMU pose, illumination, and expression (PIE) database of human faces[M]. Citeseer, 2001.

- [19] Peng X, Usman B, Kaushik N, et al. Visda: The visual domain adaptation challenge[J]. arXiv preprint arXiv:1710.06924, 2017.

- [20] Fang C, Xu Y, Rockmore D N. Unbiased metric learning: On the utilization of multiple datasets and web images for softening bias[C]. Proceedings of the IEEE International Conference on Computer Vision, 2013: 1657-1664.

- [21] Peng X, Bai Q, Xia X, et al. Moment matching for multi-source domain adaptation[C]. Proceedings of the IEEE International Conference on Computer Vision, 2019: 1406-1415.