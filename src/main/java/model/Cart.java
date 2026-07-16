package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private String userId;
    private List<Course> items;
    
    public Cart(String userId) {
        this.userId = userId;
        this.items = new ArrayList<>();
    }
    
    public String getUserId() {
        return userId;
    }
    
    public List<Course> getItems() {
        return items;
    }
    
    public void addItem(Course course) {
        items.add(course);
    }
    
    public void removeItem(Course course) {
        items.remove(course);
    }
    
    public double getTotal() {
        return items.stream().mapToDouble(Course::getPrice).sum();
    }
} 