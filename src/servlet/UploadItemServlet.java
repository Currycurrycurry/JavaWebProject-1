package servlet;

import bean.Item;
import bean.UserEntry;
import dao.ItemDaoImpl;
import factory.DaoFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: YXH
 * @date: 2019/7/23
 * @time: 15:17
 */
@WebServlet(name = "UploadItemServlet",value = "/upload")
public class UploadItemServlet extends HttpServlet {
    private static final String IMAGE_PATH = "images/upload/";
    private static final String VIDEO_PATH = "videos/upload/";


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        try{
            UserEntry user = (UserEntry) request.getSession().getAttribute("user");
            if(!user.isAdmin()){
                response.sendRedirect("index.jsp");
                return;
            }
            Item item = new Item();
            Map<String,String> map = new HashMap<>();

            FileItemFactory fileItemFactory = new DiskFileItemFactory();
            ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
            try {
                List<FileItem> fileItems = servletFileUpload.parseRequest(request);
                for(FileItem fileItem : fileItems){
                    if(fileItem.isFormField()){
                        String fieldName = fileItem.getFieldName();
                        String value = new String(fileItem.getString().getBytes("ISO8859_1"), StandardCharsets.UTF_8);
                        map.put(fieldName,value);
                    }else {
                        String fieldName = fileItem.getFieldName();
                        String fileName = fileItem.getName();
                        String contentType = fileItem.getContentType();
                        long timeTag = System.currentTimeMillis();

                        String outPath = request.getSession().getServletContext().getRealPath("");
                        String webPath = outPath.substring(0,outPath.indexOf("out"))+"web/";
                        if(contentType.contains("image")){
                            map.put(fieldName,IMAGE_PATH+timeTag+"_"+fileName);
                            outPath += IMAGE_PATH;
                            webPath += IMAGE_PATH;
                        }else if(contentType.contains("")){
                            map.put(fieldName,VIDEO_PATH+timeTag+"_"+fileName);
                            outPath += VIDEO_PATH;
                            webPath += VIDEO_PATH;
                        }else {
                            continue;
                        }
                        InputStream inputStream = fileItem.getInputStream();
                        byte[] buf = new byte[1024];
                        int len;
                        OutputStream outOut = new FileOutputStream(outPath+timeTag+"_"+fileName);
                        OutputStream webOut = new FileOutputStream(webPath+timeTag+"_"+fileName);
                         while ((len = inputStream.read(buf)) != -1){
                             outOut.write(buf,0,len);
                             webOut.write(buf,0,len);
                         }
                        webOut.flush();
                        outOut.flush();
                        webOut.close();
                        outOut.close();
                        inputStream.close();
                    }
                }
                item.setName(map.get("uploadName"));
                item.setAddress(map.get("address"));
                item.setYear(map.get("year"));
                item.setDescription(map.get("description"));
                item.setImagePath(map.get("itemImageFile"));
                item.setVideoPath(map.get("itemVideoFile"));
                System.out.println(item.getImagePath()+"\n"+item.getVideoPath());
                ItemDaoImpl itemDao = DaoFactory.getItemDaoInstance();

                int itemId = itemDao.insertItem(item);
                itemDao.close();
                response.sendRedirect("/detail.jsp?id="+itemId);
                System.out.println(itemId);

            }catch (FileUploadException e){
                e.printStackTrace();
            }


        }catch (Exception e){
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
