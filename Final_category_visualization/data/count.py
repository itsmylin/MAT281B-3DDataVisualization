# encoding utf-8
import csv
result = [0] * 10
dewey =  [0] * 10
index = 0 
with open('output.csv', newline='') as f: 
    reader = csv.reader(f, delimiter=',')              #以读方式打开文件
    for line in reader:  
                 #依次读取每行  
        if line[0].isnumeric():                          #去掉每行头尾空白
            year = int(line[0]) - 2007                                  #是的话，跳过不处理
            result[year] += 1  
        if line[2].isnumeric():
            dewey_number = int(line[2])//100
            if index != dewey_number:
                print(line)
                index = dewey_number
            index = (index+1) % 10
            dewey[dewey_number] += 1                           #保存
                             #排序结果
print(result)
print(dewey)



