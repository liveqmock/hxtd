package com.baihui.hxtd.soa.base.utils.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ReportData
 *
 * @author xiayouxue
 * @date 2014/7/9
 */
public abstract class ReportData {

    protected String title;       //标题
    protected String xAxisTitle;  //x轴标题
    protected List xAxisTitles;   //x轴数值描述
    protected List xAxises;       //x轴数值
    protected Map<Object, Integer> xAxisIndexs;//x轴数值对应索引
    protected String yAxisTitle;   //y轴标题
    protected List yAxisTitles; //y轴数值描述
    protected List yAxises;         //y轴数值
    protected List zAxisTitles; //z轴标题
    protected List zAxises;         //z轴数值
    protected Map<Object, Integer> zAxisIndexs;//z轴数值对应索引
    protected List data;            //数据

    public ReportData() {
        xAxises = new ArrayList();
        xAxisIndexs = new HashMap<Object, Integer>();
        zAxises = new ArrayList();
        zAxisIndexs = new HashMap<Object, Integer>();
        data = new ArrayList();
    }

    /**
     * 构建x轴数值对应索引
     */
    public void buildXAxisIndexs() {
        for (int i = 0; i < xAxises.size(); i++) {
            xAxisIndexs.put(xAxises.get(i), i);
        }
    }

    /**
     * 构建z轴数值对应索引
     */
    public void buildZAxisIndexs() {
        for (int i = 0; i < zAxises.size(); i++) {
            zAxisIndexs.put(zAxises.get(i), i);
        }
    }

    /**
     * 创建空表格
     * 1.数据全部填充0
     */
    public abstract void fullEmptyData();

    /**
     * 填充数据
     * 1.生成数据索引
     * 2.填充数据
     */
    public abstract void fullValidData(List data);

    /**
     * 设置Y轴数值
     */
    public abstract void setYAxises(List data);

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getxAxisTitle() {
        return xAxisTitle;
    }

    public void setxAxisTitle(String xAxisTitle) {
        this.xAxisTitle = xAxisTitle;
    }

    public String getyAxisTitle() {
        return yAxisTitle;
    }

    public void setyAxisTitle(String yAxisTitle) {
        this.yAxisTitle = yAxisTitle;
    }

    public List getxAxisTitles() {
        return xAxisTitles;
    }

    public void setxAxisTitles(List xAxisTitles) {
        this.xAxisTitles = xAxisTitles;
    }

    public List getxAxises() {
        return xAxises;
    }

    public void setxAxises(List xAxises) {
        this.xAxises = xAxises;
    }

    public List getyAxisTitles() {
        return yAxisTitles;
    }

    public void setyAxisTitles(List yAxisTitles) {
        this.yAxisTitles = yAxisTitles;
    }

    public List getyAxises() {
        return yAxises;
    }

    public void setyAxises(List yAxises) {
        this.yAxises = yAxises;
    }

    public List getzAxisTitles() {
        return zAxisTitles;
    }

    public void setzAxisTitles(List zAxisTitles) {
        this.zAxisTitles = zAxisTitles;
    }

    public List getzAxises() {
        return zAxises;
    }

    public void setzAxises(List zAxises) {
        this.zAxises = zAxises;
    }

    public List getData() {
        return data;
    }

    public void setData(List data) {
        this.data = data;
    }
}
