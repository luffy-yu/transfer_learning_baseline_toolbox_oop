import json
import math
import os
from collections import OrderedDict

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


class Visualize(object):
    def __init__(self):
        self.method = 'Method'
        self.direction = 'Direction'
        self.accurate = 'Accurate'
        self.filename_template = 'compare_of_method_{method}_dataset_{dataset}.csv'
        self.methods_color_map = OrderedDict({
            'TCA': 'xkcd:purple',
            'JDA': 'xkcd:blue',
            'BDA': 'xkcd:light blue',
            'GFK': 'xkcd:green',
            'SA': 'xkcd:pink',
            'TJM': 'xkcd:brown',
            'CORAL': 'xkcd:red',
            'MEDA': 'xkcd:teal',
            'EasyTL': 'xkcd:orange',
        })
        self.datasets = ['Amazon_Review', 'COIL_20', 'Cross_Dataset', 'Image_CLEF', 'Mnist-USPS',
                         'Office_31', 'Office_Caltech', 'Office_home', 'PIE', 'VisDA', 'VLSC', 'DomainNet']
        self.dataset_name = ''
        self.xticks_rotation = 0
        self.legend_loc = 'upper left'
        self.title = ''
        self.stat_file = 'stat_file.json'

    def read_csv(self, filename):
        df = pd.read_csv(filename, engine='python')
        # formalize
        if any(df[self.accurate] > 1):
            df[self.accurate] = df[self.accurate] / 100.0
        return df

    def _filter_by_method(self, df, method):
        return df[df[self.method] == method]

    def old(self, df):
        df = self._filter_by_method(df, 'Old')
        return df[[self.direction, self.accurate]]

    def new(self, df):
        df = self._filter_by_method(df, 'New')
        return df[[self.direction, self.accurate]]

    def show_csv(self, filename):
        df = self.read_csv(filename)
        # old
        old = self.old(df)
        new = self.new(df)
        # rename direction
        old = self._rename_direction(old)
        new = self._rename_direction(new)

        fig = plt.figure(figsize=(10, 6))
        ax = fig.add_subplot(1, 1, 1)
        ax.plot(old[self.direction], old[self.accurate], label='Old', linestyle="--")  # 虚线
        ax.plot(new[self.direction], new[self.accurate], label='New', linestyle="-")  # 实线
        ax.legend(loc=self.legend_loc)
        plt.xticks(rotation=self.xticks_rotation)
        plt.tight_layout()
        plt.show()

    def cal_stat(self):
        stat = {
            'total': '',
            'win_count': '',
            'win_rate': '',
            'min_increase': '',
            'max_increase': '',
            'avg_increase': ''
        }
        df = None
        for idx, method in enumerate(self.methods_color_map.keys()):
            filename = self.filename_template.format(method=method, dataset=self.dataset_name)
            data = self.read_csv(filename)
            old, new = self.old(data), self.new(data)
            diff = pd.merge(old, new, on=self.direction)
            diff['diff'] = diff['Accurate_y'] - diff['Accurate_x']
            diff = diff[[self.direction, 'diff']]
            if idx == 0:
                df = diff
            else:
                df = pd.merge(df, diff, on=self.direction)
        df = df.set_axis(df[self.direction])
        df = df.iloc[:, 1:]
        try:  # Fix when there is only old data or new data.
            stat['total'] = str(df.shape[0] * df.shape[1])
            stat['win_count'] = str(np.sum(np.where(df > 0, 1, 0)))
            stat['win_rate'] = '%.2f' % (int(stat['win_count']) / int(stat['total']) * 100)
            stat['min_increase'] = '%.2f' % (np.min(np.min(df)) * 100)
            stat['max_increase'] = '%.2f' % (np.max(np.max(df)) * 100)
            stat['avg_increase'] = '%.2f' % (np.sum(np.where(df > 0, df, 0)) / int(stat['win_count']) * 100)
        except:
            stat = {}
        # save to json file
        data = {}
        if os.path.exists(self.stat_file):
            with open(self.stat_file, 'r') as f:
                data = json.loads(f.read())
                if self.title in data:
                    pass
                else:
                    data[self.title] = stat
        else:
            data[self.title] = stat
        # write to json
        open(self.stat_file, 'w').write(json.dumps(data, indent=2))

    def _remap(self, x):
        d = {}
        return d.get(x, x)

    def _rename_direction(self, df):
        if df.empty:
            return df

        df[self.direction] = df.apply(lambda x: self._remap(x[self.direction]), axis=1)
        return df

    def to_excel(self):
        def merge_old_new(old, new):
            df = pd.merge(old, new, on='Direction')
            df['Accurate_x'] = df['Accurate_x'] * 100.0
            df['Accurate_y'] = df['Accurate_y'] * 100.0
            df['Accurate_x'] = df.apply(
                lambda x: ('*%.2f' if x['Accurate_x'] > x['Accurate_y'] else '%.2f') % (x['Accurate_x']), axis=1)
            df['Accurate_y'] = df.apply(
                lambda x: ('*%.2f' if x['Accurate_x'][0] != '*' and float(x['Accurate_x']) < x[
                    'Accurate_y'] else '%.2f') % (x['Accurate_y']), axis=1)
            df = df[['Direction', 'Accurate_x', 'Accurate_y']]
            return df

        excel_name = '{dataset}_all_in_one.xlsx'.format(dataset=self.dataset_name)
        df = None
        columns = []
        for idx, method in enumerate(self.methods_color_map.keys()):
            filename = self.filename_template.format(method=method, dataset=self.dataset_name)
            data = self.read_csv(filename)
            old, new = self.old(data), self.new(data)
            if idx == 0:
                df = pd.DataFrame(data=old[self.direction])
                columns.append(self.direction)
            # upper is old, lower is new, add marker '*' to bigger one
            df = pd.merge(df, merge_old_new(old, new), on='Direction')
            columns.extend([method, '+' + method])
        # rename direction
        df = self._rename_direction(df)
        # replace Direction with Task
        columns[0] = 'Task'
        df.columns = columns
        # transpose
        # df = df.transpose()
        # df.to_excel(excel_name, index=True, header=None)
        df.to_excel(excel_name, index=None)

    def show_csvs(self, return_all_in_one=False):
        dataset_name = self.dataset_name
        if not dataset_name:
            return
        self.to_excel()
        fig = plt.figure(figsize=(10, 6))
        ax = fig.add_subplot(1, 1, 1)
        for method in self.methods_color_map.keys():
            filename = self.filename_template.format(method=method, dataset=dataset_name)
            df = self.read_csv(filename)
            color = self.methods_color_map.get(method)
            old, new = self.old(df), self.new(df)
            # rename direction
            old, new = self._rename_direction(old), self._rename_direction(new)
            ax.plot(old[self.direction], old[self.accurate], color=color, linestyle="--")  # 虚线
            ax.plot(new[self.direction], new[self.accurate], label=method, color=color, linestyle="-")  # 实线
        ax.legend(loc=self.legend_loc)
        if return_all_in_one:
            return ax
        plt.xticks(rotation=self.xticks_rotation)
        if self.title:
            plt.title(self.title)
        plt.tight_layout()
        # save
        plt.savefig('{dataset}_all_in_one.svg'.format(dataset=self.dataset_name), format='svg')
        plt.show()
        # 3 x 3
        fig = plt.figure(figsize=(10, 6))
        # if self.title:
        #     fig.suptitle(self.title)
        methods = list(self.methods_color_map.keys())
        for i in range(3):
            for j in range(3):
                idx = i * 3 + j
                ax = fig.add_subplot(3, 3, idx + 1)
                method = methods[idx]
                color = self.methods_color_map.get(method)
                filename = self.filename_template.format(method=method, dataset=dataset_name)
                df = self.read_csv(filename)
                old, new = self.old(df), self.new(df)
                ax.plot(old[self.direction], old[self.accurate], color=color, linestyle="--")  # 虚线
                ax.plot(new[self.direction], new[self.accurate], label=method, color=color, linestyle="-")  # 实线
                ax.legend(loc=self.legend_loc)
                ax.set_xticks([])
        plt.tight_layout()
        # save
        plt.savefig('{dataset}_3x3.svg'.format(dataset=self.dataset_name), format='svg')
        plt.show()

    def __call__(self, *args, **kwargs):
        self.cal_stat()
        self.to_excel()
        self.show_csvs()

    @staticmethod
    def merge(clses, outname='output.svg'):
        fig = plt.figure(figsize=(16, 12))
        col = 2
        row = int(math.ceil(len(clses) / col))
        for i in range(row):
            for j in range(col):
                if i * col + j >= len(clses):
                    continue
                ax = fig.add_subplot(row, col, i * col + j + 1)
                ins = clses[i * col + j]()
                for method in ins.methods_color_map.keys():
                    filename = ins.filename_template.format(method=method, dataset=ins.dataset_name)
                    df = ins.read_csv(filename)
                    color = ins.methods_color_map.get(method)
                    old, new = ins.old(df), ins.new(df)
                    # rename direction
                    old, new = ins._rename_direction(old), ins._rename_direction(new)
                    ax.plot(old[ins.direction], old[ins.accurate], color=color, linestyle="--")  # 虚线
                    ax.plot(new[ins.direction], new[ins.accurate], label=method, color=color, linestyle="-")  # 实线
                ax.legend(loc=ins.legend_loc)
                ax.set_title(ins.title)
                ax.tick_params(axis='x', labelrotation=ins.xticks_rotation)
        plt.tight_layout()
        # save
        plt.savefig(outname, format='svg')
        plt.show()


class AmazonReview(Visualize):
    def __init__(self):
        super(AmazonReview, self).__init__()
        self.xticks_rotation = 0
        self.dataset_name = self.datasets[0]
        self.title = 'Amazon Review Dataset'

    def _remap(self, x):
        return x.replace('books', 'b').replace('elec', 'e').replace('dvd', 'd').replace('kitchen', 'k')


class COIL20(Visualize):
    def __init__(self):
        super(COIL20, self).__init__()
        self.dataset_name = self.datasets[1]
        self.title = 'COIL 20 Dataset'


class CrossDataset(Visualize):
    def __init__(self):
        super(CrossDataset, self).__init__()
        self.dataset_name = self.datasets[2]
        self.title = 'Cross Dataset Testbed'


class ImageCLEF(Visualize):
    def __init__(self):
        super(ImageCLEF, self).__init__()
        self.dataset_name = self.datasets[3]
        self.title = 'ImageCLEF Dataset'


class MnistUSPS(Visualize):
    def __init__(self):
        super(MnistUSPS, self).__init__()
        self.dataset_name = self.datasets[4]
        self.title = 'MNIST-USPS Dataset'


class Office31(Visualize):
    def __init__(self):
        super(Office31, self).__init__()
        self.dataset_name = self.datasets[5]
        self.title = 'Office-31 Dataset'


class OfficeCaltech(Visualize):
    def __init__(self):
        super(OfficeCaltech, self).__init__()
        self.dataset_name = self.datasets[6]
        self.title = 'Office Caltech Dataset'
        self.xticks_rotation = 0

    def _remap(self, x):
        return x.replace('Caltech10', 'c').replace('amazon', 'a').replace('dslr', 'd').replace('webcam', 'w')


class OfficeHome(Visualize):
    def __init__(self):
        super(OfficeHome, self).__init__()
        self.dataset_name = self.datasets[7]
        self.title = 'Office Home Dataset'
        self.xticks_rotation = 60


class PIE(Visualize):
    def __init__(self):
        super(PIE, self).__init__()
        self.dataset_name = self.datasets[8]
        self.title = 'PIE Dataset'
        self.xticks_rotation = 60

    def _remap(self, x):
        return x.replace('05', '1').replace('07', '2').replace('09', '3').replace('27', '4').replace('29', '5')


class VisDA(Visualize):
    def __init__(self):
        super(VisDA, self).__init__()
        self.dataset_name = self.datasets[9]
        self.title = 'VisDA Dataset'


class VLSC(Visualize):
    def __init__(self):
        super(VLSC, self).__init__()
        self.dataset_name = self.datasets[10]
        self.title = 'VLSC Dataset'
        self.xticks_rotation = 60


class DomainNet(Visualize):
    def __init__(self):
        super(DomainNet, self).__init__()
        self.dataset_name = self.datasets[11]
        self.title = 'DomainNet Dataset'
        self.xticks_rotation = 60


class Stat(Visualize):
    def cal_stat(self):

        if not os.path.exists(self.stat_file):
            return

        stat = {
            'total': '',
            'win_count': '',
            'win_rate': '',
            'min_increase': '',
            'max_increase': '',
            'avg_increase': ''
        }
        data = {}
        with open(self.stat_file, 'r') as f:
            data = json.loads(f.read())

        try:  # Fix when there is only old data or new data.
            for k in stat.keys():
                s = []
                for kk in data.keys():
                    s.append(float(data[kk][k]))
                stat[k] = s
            # update
            stat['total'] = str(int(np.sum(stat['total'])))
            stat['min_increase'] = '%.2f' % (np.min(stat['min_increase']))
            stat['max_increase'] = '%.2f' % (np.max(stat['max_increase']))
            stat['avg_increase'] = '%.2f' % (
                    np.sum(np.array(stat['avg_increase']) * np.array(stat['win_count'])) / np.sum(stat['win_count']))
            stat['win_count'] = str(int(np.sum(stat['win_count'])))
            stat['win_rate'] = '%.2f' % (int(stat['win_count']) / int(stat['total']) * 100)
        except:
            stat = {}
        # write to json
        if 'Summary' not in data:
            data['Summary'] = stat
            open(self.stat_file, 'w').write(json.dumps(data, indent=2))

    def __call__(self, *args, **kwargs):
        self.cal_stat()
        self.add_description()

    def add_description(self):

        data = {}
        with open(self.stat_file, 'r') as f:
            data = json.loads(f.read())

        if not data:
            return
        template = '在本数据集的{total}个实验中，共有{win_count}个实验的结果得到提升，占比{win_rate}%。最小提升为{min_increase}%，' \
                   '最大提升为{max_increase}%，平均提升为{avg_increase}%。'
        for k in data.keys():
            if data[k]:
                if k == 'Summary':
                    data[k]['desc'] = template.replace('在本数据集', '在本章节').format(**data[k])
                else:
                    data[k]['desc'] = template.format(**data[k])
        with open(self.stat_file, 'w') as f:
            f.write(json.dumps(data, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    # chdir
    cur_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(os.path.join(cur_dir, '../../sample'))
    vis = Visualize()
    vis.show_csv('compare_of_method_BDA_dataset_Amazon_Review.csv')
    AmazonReview()()
    # COIL20()()
    # CrossDataset()()
    # ImageCLEF()()
    # MnistUSPS()()
    # Office31()()
    # OfficeCaltech()()
    # OfficeHome()()
    # PIE()()
    # VisDA()()
    # VLSC()()
    # DomainNet()()
    Stat()()
    # Visualize().merge([MnistUSPS, PIE, OfficeCaltech, ImageCLEF], outname='mnist-usps_pie_officecaltech_imageclef.svg')
