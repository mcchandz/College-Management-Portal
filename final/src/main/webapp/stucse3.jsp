<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>GECH - Your result</title>
<style>
    td, th {
       text-align: center;
       padding: 10px 10px;
       font-size: 18px;
    }
    
    header {
    background-color: cadetblue;
    color: #fff;
    padding: 10px;
    text-align: center;
    }
    
    .btn-container {
            width: 400px;
            display: flex;
            justify-content: space-between;
            margin-top: 20px; 
            margin-left: 40%;
        }
        
        .button-container button {
            padding: 10px 20px;
        }
      
        .btn {
            padding: 10px 20px;
            color: #fff;
            background-color: cadetblue;
            font-size: 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>


</head>

<body>
<header>
    <h1>3rd sem Results</h1>
</header>

<div>
    <br>
    <br>
    <table border="1" align="center">
        <tr>
            <th>USN</th>
            <th>Semester</th>
            <th>Branch</th>
            <th>18MAT31</th>
            <th>18XX32</th>
            <th>18XX33</th>
            <th>18XX34</th>
            <th>18XX35</th>
            <th>18XX36</th>
            <th>18XXL37</th>
            <th>18XXL38</th>
            <th>18CPC39/KAN</th>
        </tr>

        <% 
        String usn = request.getParameter("usn");
        boolean hasData = false; 
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cmp", "root", "password");              

            String sql = "SELECT * FROM sem3 WHERE usn=? AND branch='CSE';";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, usn);
            
            
            ResultSet rs = pstmt.executeQuery();
            
            while(rs.next()) {
                hasData = true; 
                String ssem = rs.getString("sem");
                String sbranch = rs.getString("branch");
                String m1 = rs.getString("18MAT31");
                String m2 = rs.getString("18XX32");
                String m3 = rs.getString("18XX33");
                String m4 = rs.getString("18XX34");
                String m5 = rs.getString("18XX35");
                String m6 = rs.getString("18XX36");
                String m7 = rs.getString("18XXL37");
                String m8 = rs.getString("18XXL38");
                String m9 = rs.getString("18CPC39/KAN");
        %>
        <tr>
            <td><%= usn %></td>
            <td><%= ssem %></td>
            <td><%= sbranch %></td>
            <td><%= m1 %></td>
            <td><%= m2 %></td>
            <td><%= m3 %></td>
            <td><%= m4 %></td>
            <td><%= m5 %></td>
            <td><%= m6 %></td>
            <td><%= m7 %></td>
            <td><%= m8 %></td>
            <td><%= m9 %></td>
        </tr>
        <% 
            }
            rs.close();
            pstmt.close();
            con.close();
        } catch(Exception e) {
            out.println("Error occurred: " + e.getMessage());
        }
        %>
    </table>
    <% 
    
    if (!hasData) {
    %>
    <script>
        alert("No data found for the requested USN.");
        
        window.location.href = 'stupage.html';
    </script>
    <% 
    }
    %>
</div>

<div class="btn-container">
    <button class="btn" onclick="goBack()">Back</button>
   <button class="btn" onclick="download()">Download</button>
    
</div>

<script>
    function goBack() {
        window.location.href = 'stupage.html'; 
    }
    
    function download() {
        var wb = XLSX.utils.table_to_book(document.querySelector('table'), {sheet: "Sheet JS"});
        var fileName = document.querySelector('h1').innerText.replace(/\s+/g, '_').toLowerCase() + '.xlsx';
        return XLSX.writeFile(wb, fileName);
    }
</script>

</body>
</html>