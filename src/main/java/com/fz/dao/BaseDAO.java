package com.fz.dao;

import com.fz.comment.PageQuery;
import com.fz.comment.StatusQuery;

import java.util.List;
import java.util.Map;

/**
 *
 * @param <T>
 */
public interface BaseDAO<T> {

    public T queryById(long id);

    public void update(T t);

    public void add(T t);

    public void delete(long id);

    public List<T> pagelist(PageQuery pageQuery);

    public void updateStatus(StatusQuery statusQuery);

    public int count(PageQuery pageQuery);

    public List<T> listAll();

}
