#!/usr/bin/python
import os
import fnmatch
import sys
import shutil
import  xdrlib
import subprocess
import xlrd
import xlwt
from xlutils.copy import copy

def write_sheet_header(sheet,val):
    sheet.col(0).width=3000
    sheet.write(0,0,'name')

    sheet.col(1).width=3000
    sheet.write(0,1,'szie')

    sheet.col(2).width=7000
    sheet.write(0,2,'event')

    for i in range(val):
        sheet.col(3+i).width=3500
        sheet.write(0,3+i,str(i+1))

    sheet.col(3+val).width=4000
    sheet.write(0,3+val,'average')

if __name__=="__main__":

    src_name1 = sys.argv[1]
    src_name2 = sys.argv[2]
    dst_name = sys.argv[3]


    src_xlrd1=xlrd.open_workbook(src_name1)
    src_xlrd2=xlrd.open_workbook(src_name2)
    dst_xlrd=xlwt.Workbook()
    sheet_count = len(src_xlrd1.sheet_names())
    for i in range(sheet_count):
        src2_sheet=src_xlrd2.sheet_by_index(i)
        src1_sheet=src_xlrd1.sheet_by_index(i)
        #creat des sheet
        sheet_name=src2_sheet.name
        dst_sheet=dst_xlrd.add_sheet(sheet_name)

        sheet_row=src1_sheet.nrows
        src2_col=len(src2_sheet.row_values(0))
        src1_col=len(src1_sheet.row_values(0))
        data_count = src2_col-4+src1_col-4

        write_sheet_header(dst_sheet,data_count)
        for j in range(1,sheet_row):
            for k  in range(3):
                dst_sheet.write(j,k,src1_sheet.cell_value(j,k))

            data_list=[]
            sum_data=0

            for k in range(3,src1_col-1):
                val1=int(src1_sheet.cell_value(j,k))
                data_list.append(val1)
                sum_data=sum_data+val1

            for k in range(3,src2_col-1):
                val1=int(src2_sheet.cell_value(j,k))
                data_list.append(val1)
                sum_data=sum_data+val1
            sum_data=round(float(float(sum_data)/(float(data_count))),2)

            data_list.append(sum_data)

            for k in range(3,3+data_count+1):
                dst_sheet.write(j,k,data_list[k-3])
    dst_xlrd.save(dst_name)
