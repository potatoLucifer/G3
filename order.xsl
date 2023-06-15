<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>點餐系統</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            background-image: url("pizz.png");
            background-repeat: no-repeat;
            background-size: cover;
            margin: 0;
            padding: 20px;
          }

          h1 {
            color: #333;
          }

          h2 {
            color: #333;
            margin-top: 20px;
          }

          p {
            color: #333;
          }

          .order-details {
            margin-top: 20px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
          }

          .order-details .detail-item {
            margin-bottom: 10px;
          }

          .order-details .detail-item span {
            font-weight: bold;
          }
        </style>
      </head>
      <body>
        <h1>點餐系統</h1>
        <form id="orderForm" action="AddOrder" method="get">
          <p>名字：</p>
          <label for="name">
            <xsl:value-of select="order/customer/name" />
          </label>
          <input type="text" id="name" required="required" /><br /><br />

          <p>電話號碼：</p>
          <label for="phone">
            <xsl:value-of select="order/customer/phone" />
          </label>
          <input type="text" id="phone" required="required" /><br /><br />

          <p>餐點：</p>
          <xsl:apply-templates select="order/meals/meal" />
          <br /><br />

          <input type="submit" value="提交" />
        </form>

        <div id="orderSummary" style="display: none;">
          <!-- 顯示使用者輸入的名字、電話號碼和已勾選的餐點 -->
        </div>

        <script>
          window.addEventListener("DOMContentLoaded", function() {
            var orderForm = document.getElementById("orderForm");
            orderForm.addEventListener("submit", function(event) {
              event.preventDefault();

              var name = document.getElementById("name").value;
              var phone = document.getElementById("phone").value;
              var meals = [];

              var checkboxes = document.querySelectorAll("input[type='checkbox']:checked");
              checkboxes.forEach(function(checkbox) {
                meals.push(checkbox.value);
              });

              var url = "order.html";
              url += "?name=" + encodeURIComponent(name);
              url += "&amp;phone=" + encodeURIComponent(phone);
              url += "&amp;meals=" + encodeURIComponent(meals.join(","));

              window.location.href = url;
            });
          });
        </script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="meal">
    <input type="checkbox" id="{@id}" value="{mname}" />
    <label for="{@id}">
      <xsl:value-of select="mname" />
    </label><br />
  </xsl:template>
</xsl:stylesheet>
