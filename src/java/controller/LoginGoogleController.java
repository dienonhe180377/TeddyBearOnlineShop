package controller;

import dao.CartDAO;
import dao.UserDAO;
import entity.User;
import entity.UserRole;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;
import utility.OAuthConfig;
@WebServlet("/google-login")
public class LoginGoogleController extends HttpServlet {

    // Replace with your own values from Google Cloud Console
    String CLIENT_ID = OAuthConfig.CLIENT_ID;
    String CLIENT_SECRET = OAuthConfig.CLIENT_SECRET;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String redirectUri = request.getScheme() + "://"
                + request.getServerName() + ":"
                + request.getServerPort()
                + request.getContextPath() + "/google-login";

        if (code == null || code.isEmpty()) {
            String googleOAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth?"
                    + "client_id=" + CLIENT_ID
                    + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
                    + "&response_type=code"
                    + "&scope=" + URLEncoder.encode("openid email profile", "UTF-8")
                    + "&access_type=offline"
                    + "&prompt=consent";
            response.sendRedirect(googleOAuthUrl);
        } else {
            String tokenUrl = "https://oauth2.googleapis.com/token";
            String params = "code=" + code
                    + "&client_id=" + CLIENT_ID
                    + "&client_secret=" + CLIENT_SECRET
                    + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
                    + "&grant_type=authorization_code";

            URL url = new URL(tokenUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.getOutputStream().write(params.getBytes("UTF-8"));

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder tokenResponse = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                tokenResponse.append(inputLine);
            }
            in.close();

            // Parse the JSON response to retrieve the access token
            JSONObject jsonObj = new JSONObject(tokenResponse.toString());
            String accessToken = jsonObj.getString("access_token");

            // Step 3: Retrieve user information from Google
            String userInfoUrl = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=" + accessToken;
            URL urlUser = new URL(userInfoUrl);
            HttpURLConnection connUser = (HttpURLConnection) urlUser.openConnection();
            connUser.setRequestMethod("GET");

            BufferedReader inUser = new BufferedReader(new InputStreamReader(connUser.getInputStream()));
            StringBuilder userResponse = new StringBuilder();
            while ((inputLine = inUser.readLine()) != null) {
                userResponse.append(inputLine);
            }
            inUser.close();

            JSONObject userJson = new JSONObject(userResponse.toString());
            String email = userJson.getString("email");
            String name = userJson.getString("name");
            User currentUser;

            boolean isExisted = userDAO.isEmailExist(email);
            if (!isExisted) {
                // Generate a random Vietnamese phone number (e.g., 09XXXXXXXX)
                String randomPhone = generateRandomVNPhoneNumber();

                // Register the user with the generated phone number
                boolean registered = userDAO.registerUser(name, email, "Abc123@", randomPhone, "");
                if (!registered) {
                    Logger.getLogger(LoginGoogleController.class.getName())
                            .log(Level.SEVERE, "User registration failed for email: {0}", email);
                }
                currentUser = userDAO.getByEmail(email);
            } else {
                currentUser = userDAO.getByEmail(email);
            }
            HttpSession session = request.getSession();
            session.setAttribute("user", currentUser);
            if (currentUser.getRole().getUserRole().equalsIgnoreCase("Customer")) {
                CartDAO cartDAO = new CartDAO();
                int cartCount;
                try {
                    cartCount = cartDAO.getCartItemCount(currentUser.getId());
                    session.setAttribute("cartCount", cartCount);
                } catch (Exception ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            response.sendRedirect("MenuController?service=productInformation");
        }
    }

    private String generateRandomVNPhoneNumber() {
        Random random = new Random();
        StringBuilder phone = new StringBuilder("09");
        for (int i = 0; i < 8; i++) {
            phone.append(random.nextInt(10));
        }
        return phone.toString();
    }
}
