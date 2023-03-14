package com.imbling.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.imbling.entity.CategoryEntity;

public interface CategoryRepository extends JpaRepository<CategoryEntity, Integer> {
	
	List<CategoryEntity> findAllByOrderByCategoryNo();
	
	CategoryEntity findByCategoryName(String categoryName);

	CategoryEntity findByCategoryNo(int categoryNo);
	
}
