package com.baihui.hxtd.soa.base.utils;

import com.baihui.hxtd.soa.base.orm.ExtendItemSelectHql;
import com.baihui.hxtd.soa.base.propertyeditors.MultiPatternDateEditor;
import com.google.common.collect.Maps;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.propertyeditors.*;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.ResourceArrayPropertyEditor;
import org.springside.modules.persistence.SearchFilter;
import org.xml.sax.InputSource;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URI;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.*;
import java.util.regex.Pattern;

/**
 * 常用的查询条件
 * 通过spring注入到需要的类中使用
 *
 * @author xiayouxue
 * @date 2014-5-8
 */
public class Search {

    /**
     * 清除请求参数集合中指定参数名的参数项
     */
    public static void clearKeys(Map<String, Object> params, String... keys) {
        for (String key : keys) {
            if (params.containsKey(key)) {
                params.remove(key);
            }
        }
    }

    /**
     * 清除请求参数集合中参数值为空格的参数项
     */
    public static void clearBlankValue(Map<String, Object> params) {
        Set<String> keys = new HashSet<String>();
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            if (entry.getValue() instanceof String) {
                if (StringUtils.isBlank((String) entry.getValue())) {
                    keys.add(entry.getKey());
                }
            } else if (entry.getValue() instanceof String[]) {
                String[] values = (String[]) entry.getValue();
                if (!isValid(values)) {
                    keys.add(entry.getKey());
                }
            }
        }

        for (String key : keys) {
            params.remove(key);
        }
    }

    /**
     * 去掉请求参数集合中参数值左右两边的空格
     */
    public static void trimValue(Map<String, Object> params) {
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            if (entry.getValue() instanceof String) {
                entry.setValue(StringUtils.trim((String) entry.getValue()));
            } else if (entry.getValue() instanceof String[]) {
                String[] values = (String[]) entry.getValue();
                for (String value : values) {
                    entry.setValue(StringUtils.trim(value));
                }
            }
        }
    }

    /**
     * 清除请求参数集合中参数值为空格的参数项
     * 去掉请求参数集合中参数值左右两边的空格
     */
    public static void clearBlankValueTrimValue(Map<String, Object> params) {
        Search.clearBlankValueTrimValue(params);
        Search.trimValue(params);
    }

    /**
     * 解码请求参数值
     */
    public static void decodeValue(Map<String, Object> params, String decode) throws UnsupportedEncodingException {
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            if (entry.getValue() instanceof String) {
                entry.setValue(URLDecoder.decode((String) entry.getValue(), decode));
            } else if (entry.getValue() instanceof String[]) {
                String[] values = (String[]) entry.getValue();
                for (int i = 0; i < values.length; i++) {
                    values[i] = URLDecoder.decode(values[i], decode);
                }
            }
        }
    }

    /**
     * 解码请求参数值
     */
    public static void decodeValue(Map<String, Object> params) {
        try {
            decodeValue(params, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("不可能的异常", e);
        }
    }

    /**
     * 是否有效数组值
     * 1.数组中一个值有效，则该数组有效
     */
    private static boolean isValid(String[] values) {
        for (String value : values) {
            if (StringUtils.isNotBlank(value)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 转换为区间表述的参数名
     */
    public static String[] toRangeKeys(String key) {
        return new String[]{SearchFilter.Operator.GTE + "_" + key, SearchFilter.Operator.LTE + "_" + key};
    }

    /**
     * 添加区间参数项
     */
    public static void addRange(Map<String, Object> params, String name, Object min, Object max) {
        params.put(SearchFilter.Operator.GTE + "_" + name, min);
        params.put(SearchFilter.Operator.LTE + "_" + name, max);
    }

    private static String[] dateMinUnits = {" 00", ":00", ":00"};
    private static String[] dateMaxUnits = {" 23", ":59", ":59"};
    private static int[] dateUnitsIndexs = new int[19];

    static {
        dateUnitsIndexs[10] = 0;
        dateUnitsIndexs[13] = 1;
        dateUnitsIndexs[16] = 2;
    }

    /**
     * 转换为最小的日期
     */
    public static String toMinDate(String date) {
        return changeDatePattern(date, dateMinUnits);
    }

    /**
     * 转换为最大的日期
     */
    public static String toMaxDate(String date) {
        return changeDatePattern(date, dateMaxUnits);
    }

    /**
     * 转换日期格式
     */
    private static String changeDatePattern(String date, String[] units) {
        StringBuffer append = new StringBuffer();
        int index = dateUnitsIndexs[date.length()];
        for (int i = index; i < units.length; i++) {
            append.append(units[i]);
        }
        return date + append.toString();
    }

    /**
     * 转换为最小的日期
     */
    public static void toMinDate(Map<String, Object> params, String key) {
        if (params.containsKey(key)) {
            params.put(key, toMinDate((String) params.get(key)));
        }
    }

    /**
     * 转换为最大的日期
     */
    public static void toMaxDate(Map<String, Object> params, String key) {
        if (params.containsKey(key)) {
            params.put(key, toMaxDate((String) params.get(key)));
        }
    }

    /**
     * 转换为区间的日期
     * 1.使用日期起始时间和结束时间
     */
    public static void toRangeDate(Map<String, Object> params, String min, String max) {
        toMinDate(params, min);
        toMaxDate(params, max);
    }

    /**
     * 转换为区间的日期
     * 1.使用日期起始时间和结束时间
     * 2.根据日期字段名称，转换为带条件的区间表示
     */
    public static void toRangeDate(Map<String, Object> params, String... names) {
        for (int i = 0; i < names.length; i++) {
            String[] keys = toRangeKeys(names[i]);
            toRangeDate(params, keys[0], keys[1]);
        }
    }

    /**
     * 转换为区间的日期
     * 1.使用单一时间，例如：EQ_createdTime=2014-05-14转换为GTE_createdTime=2014-05-14 00:00:00和LTE_createdTime=2014-05-14 23:59:59
     */
    public static void dateEqToRange(Map<String, Object> params, String key) {
        if (params.containsKey(key)) {
            String[] parts = key.split("_");
            if (parts.length != 2) {
                throw new IllegalArgumentException(key + " is not a valid search filter key");
            }
            String value = (String) params.get(key);
            params.remove(key);
            addRange(params, parts[1], toMinDate(value), toMaxDate(value));
        }
    }


    /**
     * 转换为SearchFilter
     * <p/>
     * 1.searchParams中key的格式为OPERATOR_FIELDNAME
     * 2.与SearchFilter#parse中entry.value判断条件不同
     *
     * @see SearchFilter
     * @see SearchFilter#parse(java.util.Map)
     */
    public static Map<String, SearchFilter> parse(Map<String, Object> searchParams) {
        Map<String, SearchFilter> filters = Maps.newHashMap();

        for (Map.Entry<String, Object> entry : searchParams.entrySet()) {
            // 过滤掉空值
            String key = entry.getKey();
            Object value = entry.getValue();
            if (value == null) {
                continue;
            }

            // 拆分operator与filedAttribute
            String[] names = StringUtils.split(key, "_");
            if (names.length != 2) {
                throw new IllegalArgumentException(key + " is not a valid search filter key");
            }
            String filedName = names[1];
            SearchFilter.Operator operator = SearchFilter.Operator.valueOf(names[0]);

            // 创建searchFilter
            SearchFilter filter = new SearchFilter(filedName, operator, value);
            filters.put(key, filter);
        }

        return filters;
    }

    private static Map<Class, PropertyEditor> defaultEditors;

    static {
        defaultEditors = new HashMap<Class, PropertyEditor>(64);

        defaultEditors.put(Charset.class, new CharsetEditor());
        defaultEditors.put(Class.class, new ClassEditor());
        defaultEditors.put(Class[].class, new ClassArrayEditor());
        defaultEditors.put(Currency.class, new CurrencyEditor());
        defaultEditors.put(File.class, new FileEditor());
        defaultEditors.put(InputStream.class, new InputStreamEditor());
        defaultEditors.put(InputSource.class, new InputSourceEditor());
        defaultEditors.put(Locale.class, new LocaleEditor());
        defaultEditors.put(Pattern.class, new PatternEditor());
        defaultEditors.put(Properties.class, new PropertiesEditor());
        defaultEditors.put(Resource[].class, new ResourceArrayPropertyEditor());
        defaultEditors.put(TimeZone.class, new TimeZoneEditor());
        defaultEditors.put(URI.class, new URIEditor());
        defaultEditors.put(URL.class, new URLEditor());
        defaultEditors.put(UUID.class, new UUIDEditor());

        defaultEditors.put(Collection.class, new CustomCollectionEditor(Collection.class));
        defaultEditors.put(Set.class, new CustomCollectionEditor(Set.class));
        defaultEditors.put(SortedSet.class, new CustomCollectionEditor(SortedSet.class));
        defaultEditors.put(List.class, new CustomCollectionEditor(List.class));
        defaultEditors.put(SortedMap.class, new CustomMapEditor(SortedMap.class));

        defaultEditors.put(byte[].class, new ByteArrayPropertyEditor());
        defaultEditors.put(char[].class, new CharArrayPropertyEditor());

        defaultEditors.put(char.class, new CharacterEditor(false));
        defaultEditors.put(Character.class, new CharacterEditor(true));

        defaultEditors.put(boolean.class, new CustomBooleanEditor(false));
        defaultEditors.put(Boolean.class, new CustomBooleanEditor(true));

        defaultEditors.put(byte.class, new CustomNumberEditor(Byte.class, false));
        defaultEditors.put(Byte.class, new CustomNumberEditor(Byte.class, true));
        defaultEditors.put(short.class, new CustomNumberEditor(Short.class, false));
        defaultEditors.put(Short.class, new CustomNumberEditor(Short.class, true));
        defaultEditors.put(int.class, new CustomNumberEditor(Integer.class, false));
        defaultEditors.put(Integer.class, new CustomNumberEditor(Integer.class, true));
        defaultEditors.put(long.class, new CustomNumberEditor(Long.class, false));
        defaultEditors.put(Long.class, new CustomNumberEditor(Long.class, true));
        defaultEditors.put(float.class, new CustomNumberEditor(Float.class, false));
        defaultEditors.put(Float.class, new CustomNumberEditor(Float.class, true));
        defaultEditors.put(double.class, new CustomNumberEditor(Double.class, false));
        defaultEditors.put(Double.class, new CustomNumberEditor(Double.class, true));
        defaultEditors.put(BigDecimal.class, new CustomNumberEditor(BigDecimal.class, true));
        defaultEditors.put(BigInteger.class, new CustomNumberEditor(BigInteger.class, true));

        defaultEditors.put(Date.class, new MultiPatternDateEditor("yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd"));
    }

    /** 转换为字符串集合 */
    public static List<String> convert(List list, Class clazz) {
        List<String> listString = new ArrayList<String>();
        PropertyEditor propertyEditor = defaultEditors.get(clazz);
        for (int i = 0; i < list.size(); i++) {
            propertyEditor.setValue(list.get(i));
            listString.add(propertyEditor.getAsText());
        }
        return listString;
    }


    /**
     * 构建离线查询条件
     * 1.支持当前类字段的自动数据类型转换
     * 2.支持当前类关联对象字段的自动数据类型转换
     * 3.字段名完全匹配类中的字段名称
     * 4.支持自动创建别名
     * 5.存在别名重复的bug
     */
    public static DetachedCriteria buildCriteria(Map<String, SearchFilter> filters, DetachedCriteria criteria, Class clazz) throws NoSuchFieldException {
        Set<String> aliasNames = new HashSet<String>();
        for (SearchFilter filter : filters.values()) {
            Class fieldBelongClass = clazz;
            String fieldBelongClassAliasName = criteria.getAlias();
            String fieldName = filter.fieldName;
            String fieldAliasName = fieldBelongClassAliasName + "." + fieldName;
            if (fieldName.contains(".")) {
                String[] fieldNames = fieldName.split("\\.");
                for (int i = 0; i < fieldNames.length - 1; i++) {
                    fieldBelongClass = fieldBelongClass.getDeclaredField(fieldNames[i]).getType();
                    String classAliasName = StringUtils.uncapitalize(fieldNames[i]);
                    if (!aliasNames.contains(classAliasName)) {
                        criteria.createAlias(fieldBelongClassAliasName + "." + fieldNames[i], classAliasName);
                        aliasNames.add(classAliasName);
                    }
                    fieldBelongClassAliasName = classAliasName;
                    fieldName = fieldNames[i + 1];
                }
                fieldAliasName = fieldBelongClassAliasName + "." + fieldName;
            }

            Field field = fieldBelongClass.getDeclaredField(fieldName);
            Object value = filter.value;
            if (value instanceof String && !field.getType().equals(String.class)) {
                PropertyEditor propertyEditor = defaultEditors.get(field.getType());
                propertyEditor.setAsText((String) filter.value);
                value = propertyEditor.getValue();
            }

            switch (filter.operator) {
                case EQ:
                    criteria.add(Restrictions.eq(fieldAliasName, value));
                    break;
                case LIKE:
                    criteria.add(Restrictions.like(fieldAliasName, String.valueOf(value), MatchMode.ANYWHERE));
                    break;
                case GT:
                    criteria.add(Restrictions.gt(fieldAliasName, value));
                    break;
                case LT:
                    criteria.add(Restrictions.lt(fieldAliasName, value));
                    break;
                case GTE:
                    criteria.add(Restrictions.ge(fieldAliasName, value));
                    break;
                case LTE:
                    criteria.add(Restrictions.le(fieldAliasName, value));
                    break;
            }
        }
        return criteria;
    }

    private final static Map<SearchFilter.Operator, String> OPERATORS = new HashMap<SearchFilter.Operator, String>();

    static {
        OPERATORS.put(SearchFilter.Operator.EQ, "=");
        OPERATORS.put(SearchFilter.Operator.GT, ">");
        OPERATORS.put(SearchFilter.Operator.GTE, ">=");
        OPERATORS.put(SearchFilter.Operator.LT, "<");
        OPERATORS.put(SearchFilter.Operator.LTE, "<=");
        OPERATORS.put(SearchFilter.Operator.LIKE, "like");
    }

    /**
     * 构建where hql
     * fieldName是字段的层级形式
     * <p/>
     * 1.转换值类型
     * 2.创建关联
     * 3.拼接查询项
     */
    public static void buildWhereHql(Map<String, SearchFilter> filters, ExtendItemSelectHql hql, Class clazz) throws NoSuchFieldException {
        Set<String> aliasNames = new HashSet<String>();
        for (SearchFilter filter : filters.values()) {

            Class fieldBelongClass = clazz;
            String fieldBelongClassAliasName = StringUtils.uncapitalize(clazz.getSimpleName());
            String fieldName = filter.fieldName;
            String fieldAliasName = fieldBelongClassAliasName + "." + fieldName;
            if (fieldName.contains(".")) {
                String[] fieldNames = fieldName.split("\\.");
                for (int i = 0; i < fieldNames.length - 1; i++) {
                    fieldBelongClass = fieldBelongClass.getDeclaredField(fieldNames[i]).getType();
                    String classAliasName = StringUtils.uncapitalize(fieldNames[i]);
                    if (!aliasNames.contains(classAliasName)) {
                        aliasNames.add(classAliasName);
                    }
                    fieldBelongClassAliasName = classAliasName;
                    fieldName = fieldNames[i + 1];
                }
                fieldAliasName = fieldBelongClassAliasName + "." + fieldName;
            }

            Field field = fieldBelongClass.getDeclaredField(fieldName);
            Object value = filter.value;
            if (value instanceof String && !field.getType().equals(String.class)) {
                PropertyEditor propertyEditor = defaultEditors.get(field.getType());
                propertyEditor.setAsText((String) filter.value);
                value = propertyEditor.getValue();
            }

            String alias = placeHodler(filter);
            hql.getWhereItems().add(String.format("%s %s :%s", fieldAliasName, OPERATORS.get(filter.operator), alias));
            hql.getConditionValues().put(alias, value);
        }
    }

    /**
     * 生成位置参数
     */
    public static String placeHodler(SearchFilter filter) {
        return placeHodler(filter.fieldName, filter.operator);
    }

    public static String placeHodler(String fieldName, SearchFilter.Operator operator) {
        if (fieldName.contains(".")) {
            String[] parts = fieldName.split("\\.");
            for (int i = 1; i < parts.length; i++) {
                parts[i] = StringUtils.capitalize(parts[i]);
            }
            return StringUtils.join(parts, "") + operator;
        }

        return fieldName + operator;
    }


    /**
     * 获取类的字段
     * 1.多级之间使用“.”分割
     * 2.每级字段名完全类中的字段名
     */
    private static Field getField(Class clazz, String fieldName) throws NoSuchFieldException {
        Class fieldBelongClass = clazz;
        String[] fieldNames = fieldName.split("\\.");
        for (int i = 0; i < fieldNames.length - 1; i++) {
            fieldBelongClass = fieldBelongClass.getDeclaredField(fieldNames[i]).getType();
            fieldName = fieldNames[i + 1];
        }
        return fieldBelongClass.getDeclaredField(fieldName);
    }

}
