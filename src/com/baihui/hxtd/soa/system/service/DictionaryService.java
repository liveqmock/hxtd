package com.baihui.hxtd.soa.system.service;

import com.baihui.hxtd.soa.base.orm.hibernate.HibernatePage;
import com.baihui.hxtd.soa.base.utils.Search;
import com.baihui.hxtd.soa.system.dao.DictionaryDao;
import com.baihui.hxtd.soa.system.entity.Dictionary;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.persistence.SearchFilter;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * 字典服务类
 *
 * @author xiayouxue
 * @date 2014/5/8
 */
@Service
@Transactional
public class DictionaryService {

    //private Logger logger = LoggerFactory.getLogger(ComponentService.class);
    @Resource
    private DictionaryDao dictionaryDao;

    /**
     * getDicEntity(获取单个字典实体)
     *
     * @param id 主键ID
     * @return Dictionary 字典实体
     * @Description: 根据主键获取字典实体
     */
    public Dictionary getDicEntity(Long id) {
        return dictionaryDao.get(id);
    }

    /**
     * findPage(分页查询字典数据)
     *
     * @param searchParams 过滤条件
     * @param page         分页
     * @return HibernatePage<Dictionary> 返回分页结果集
     * @throws NoSuchFieldException
     * @throws
     * @Description: 获取字典数据分页列表
     */
    @Transactional(readOnly = true)
    public HibernatePage<Dictionary> findPage(Map<String, Object> searchParams,
                                              HibernatePage<Dictionary> page) throws NoSuchFieldException {
        DetachedCriteria criteria = DetachedCriteria.forClass(Dictionary.class);
        criteria.add(Restrictions.eq("isDeleted", false));// 过滤已删除

        Map<String, SearchFilter> filters = Search.parse(searchParams);
        Search.buildCriteria(filters, criteria, Dictionary.class);

        return dictionaryDao.findPage(page, criteria);
    }

    /**
     * save(保存：修改/新建)
     *
     * @param entity 参数类型
     * @return void 返回类型
     */
    public void save(Dictionary entity) {
        dictionaryDao.save(entity);
    }

    /**
     * get(根据ID查询字典信息)
     *
     * @param id 主键id
     * @return Dictionary返回类型
     */
    public Dictionary get(Long id) {
        return dictionaryDao.findUnique("select dictionary from Dictionary dictionary where dictionary.id = ?", id);
    }

    public String getDictJsonData() {
        List<Dictionary> dicLst = dictionaryDao.find("select dictionary from Dictionary dictionary where dictionary.type is not null");
        StringBuffer jsonData = new StringBuffer("[");
        int index = 0;
        for (Dictionary item : dicLst) {
            jsonData.append(
                    String.format("{id:%s,pId:%s,name:'%s',typename:'%s'}%s",
                            new Object[]{item.getId(),
                                    (null == item.getParent() ? "0" : item.getParent().getId()),
                                    item.getKey(),
                                    item.getType(),
                                    (++index < dicLst.size() ? "," : "")
                            }
                    )
            );
        }
        jsonData.append("]");
        return jsonData.toString();
    }

    /**
     * delete(删除字典记录)
     *
     * @param id 字典主键IDS
     * @Description: 根据字典主键ID删除，支持批量删除
     */
    public void delete(Long... id) {
        dictionaryDao.delete(id);
    }

    /**
     * get(获取所有的字典类型)
     *
     * @return List<Dictionary>返回类型
     */
    public List<Object> getDicTypes() {
        String hql = "select distinct dictionary.key from Dictionary dictionary where dictionary.type is null";
        List<Object> lst = dictionaryDao.find(hql);

        return lst;
    }

    /**
     * 获取字典通过字典值
     */
    @Transactional(readOnly = true)
    public Dictionary getByValue(String value) {
        return dictionaryDao.getByValue(value);
    }

    /**
     * 获取字典列表通过父节点字典值
     */
    @Transactional(readOnly = true)
    public List<Dictionary> findChildren(String parentValue) {
        return dictionaryDao.findChildren(parentValue);
    }

    /**
     * findChildren(获取字典集合)
     *
     * @param dicType 字典常量值DictionaryConstant
     * @param bool    是否深度查找  (默认全部)
     * @return List<Dictionary> 字典集合
     * @Description: 根据大分类获取小分类集合
     */
    public List<Dictionary> findChildren(String dicType, Boolean bool) {
        String hql = "from Dictionary dic where dic.type = ? and dic.level = 1";
        if (bool) {
            hql = "from Dictionary dic where dic.type = ?";
        }
        return dictionaryDao.find(hql, dicType);
    }
}
