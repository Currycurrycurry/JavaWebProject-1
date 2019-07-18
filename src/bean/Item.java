package bean;

import java.sql.Timestamp;

public class Item {
    private int itemId;
    private String name;
    private String imagePath;
    private String description;
    private String address;
    private int view;
    private Timestamp timeReleased;
    private String year;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public Item(){}

    public void setItemId(int itemId){ this.itemId = itemId; }

    public int getItemId(){ return itemId; }

    public void view(){ view++; }

    public void setView(int view){ this.view=view; }

    public int getView(){ return view; }

    public void setName(String name){ this.name=name; }

    public String getName(){ return name; }

    public void setImagePath(String path){this.imagePath = path;}

    public String getImagePath(){return imagePath;}

    public void setDescription(String description){this.description=description;}

    public String getDescription(){return description;}

    public void setAddress(String address){this.address=address;}

    public String getAddress(){return address;}

    public void setTimeReleased(Timestamp timeReleased){this.timeReleased = timeReleased;}

    public Timestamp getTimeReleased(){return timeReleased;}
}
