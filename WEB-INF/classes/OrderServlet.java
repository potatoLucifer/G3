import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

@WebServlet("/form")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String food = request.getParameter("food");
        String price = request.getParameter("price");

        if (action != null && food != null && price != null) {
            String xmlPath = getServletContext().getRealPath("/WEB-INF/order.xml");

            try {
                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                DocumentBuilder builder = factory.newDocumentBuilder();
                Document doc = builder.parse(xmlPath);

                NodeList mealList = doc.getElementsByTagName("meal");
                Element mealElement = (Element) mealList.item(0);

                switch (action) {
                    case "Add":
                        Element newMeal = doc.createElement("meal");
                        Element newMname = doc.createElement("mname");
                        Element newMprice = doc.createElement("mprice");
                        newMname.setTextContent(food);
                        newMprice.setTextContent(price);
                        newMeal.appendChild(newMname);
                        newMeal.appendChild(newMprice);
                        mealElement.getParentNode().appendChild(newMeal);
                        break;
                    case "Delete":
                        // 根据需要实现删除逻辑
                        break;
                    case "Change":
                        // 根据需要实现修改逻辑
                        break;
                    case "Find":
                        // 根据需要实现查询逻辑
                        break;
                }

                // 保存修改后的XML文件
                // ...

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body><h1>操作成功</h1></body></html>");
            } catch (Exception e) {
                e.printStackTrace();
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body><h1>操作失败</h1></body></html>");
            }
        }
    }
}
