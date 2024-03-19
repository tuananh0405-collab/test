/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Blog {

    private int id;
    private String title;
    private String image;
    private String content;
    private Date lastUpdated;

    public Blog() {
    }

    public Blog(int id, String title, String image, String content, Date lastUpdated) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.content = content;
        this.lastUpdated = lastUpdated;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Blog{" + "id=" + id + ", title=" + title + ", content=" + content + ", lastUpdated=" + lastUpdated + '}';
    }

}
