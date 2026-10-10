package com.finance.test;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import java.util.List;
import java.util.Set;

public class FinanceAppTest {

    public static void main(String[] args) {
        
        // 1. Launch the Chrome Browser
        WebDriver driver = new ChromeDriver(); 

        try {
            // Target paths pointing to your local running Tomcat project
            String appUrl = "http://localhost:8085/Personal-Finance-Manager/register.html";
            String indexUrl = "http://localhost:8085/Personal-Finance-Manager/index.html";

            // 2. Open URL & Maximize Window
            driver.get(appUrl);
            driver.manage().window().maximize();
            System.out.println("Browser opened. Pausing for 2 seconds...");
            Thread.sleep(2000);

            // 3. Capture & Print Metadata (Basics requirement)
            String currentUrl = driver.getCurrentUrl();
            String pageTitle = driver.getTitle();
            String sourceSnippet = driver.getPageSource().substring(0, 100); 

            System.out.println("Captured URL: " + currentUrl);
            System.out.println("Captured Title: " + pageTitle);
            System.out.println("Page Source Snippet: " + sourceSnippet);

            // 4. Navigate between pages slowly (Basics requirement)
            System.out.println("Navigating to Home Dashboard...");
            driver.navigate().to(indexUrl);
            Thread.sleep(2000); 

            System.out.println("Refreshing Home Dashboard...");
            driver.navigate().refresh();
            Thread.sleep(1500); 

            System.out.println("Navigating back to Registration page...");
            driver.navigate().back(); 
            Thread.sleep(2000); 

            // 5. SwitchTo Window context handling baseline (Basics requirement)
            String originalWindow = driver.getWindowHandle();
            Set<String> allWindows = driver.getWindowHandles();
            for (String windowHandle : allWindows) {
                if (!originalWindow.contentEquals(windowHandle)) {
                    driver.switchTo().window(windowHandle);
                    break;
                }
            }
            driver.switchTo().window(originalWindow); 

            // =========================================================================
            // PART B & C: LOCATING ELEMENTS & FORM INTERACTIONS
            // =========================================================================
            
            // --- Locating Strategy 1: ID ---
            WebElement nameInput = driver.findElement(By.id("name"));

            // Web Elements State Verification: isDisplayed() & isEnabled()
            if (nameInput.isDisplayed() && nameInput.isEnabled()) {
                System.out.println("Name element state checked: Visible & Enabled.");
                
                // Interaction: sendKeys, getAttribute, and clear
                nameInput.sendKeys("Temp Name");
                Thread.sleep(1500); 
                
                String enteredText = nameInput.getAttribute("value");
                System.out.println("Extracted attribute value via getAttribute: " + enteredText);
                
                nameInput.clear(); 
                Thread.sleep(1000); 
                
                nameInput.sendKeys("John Doe"); 
                Thread.sleep(1500); 
            }

            // --- Locating Strategy 2: ID (Fixed for Email Input) ---
            System.out.println("Locating and typing Email address via ID locator...");
            WebElement emailInput = driver.findElement(By.id("email"));
            emailInput.sendKeys("johndoe@example.com");
            Thread.sleep(1500); 

            // --- Locating Strategy 3: ID (Fixed for Password Input) ---
            System.out.println("Locating and typing Password via ID locator...");
            WebElement passwordInput = driver.findElement(By.id("password")); 
            passwordInput.sendKeys("SecureP@ss1");
            Thread.sleep(1500); 

            // --- Locating Strategy 4: ID (Confirm Password Input) ---
            System.out.println("Locating and typing Confirm Password via ID locator...");
            WebElement confirmPasswordInput = driver.findElement(By.id("confirmPassword")); 
            confirmPasswordInput.sendKeys("SecureP@ss1");
            Thread.sleep(1500); 

            // --- Locating Strategy 5: TagName & getText ---
            WebElement pageHeader = driver.findElement(By.tagName("h2"));
            System.out.println("Header text extracted via getText: " + pageHeader.getText());

            // --- Locating Strategy 6: ID & click (Generate Reg Number Button) ---
            System.out.println("Clicking the 'Generate Registration Number' button...");
            WebElement generateButton = driver.findElement(By.id("generateBtn"));
            generateButton.click();
            Thread.sleep(2000); 

            // --- Locating Strategy 7: XPath & getText (Extracting the generated span text) ---
            WebElement regNumSpan = driver.findElement(By.xpath("//span[@id='regNumber']"));
            System.out.println("Generated Registration Number reads: " + regNumSpan.getText());

            // --- Locating Strategy 8: FindElements (Plural layout nodes check) ---
            List<WebElement> formLabels = driver.findElements(By.tagName("label"));
            System.out.println("Total form label elements counted on page: " + formLabels.size());

            // --- Locating Strategy 9: CSS Selector & click (Submit Form) ---
            System.out.println("Locating main Submit Button via CSS Selector...");
            WebElement registerButton = driver.findElement(By.cssSelector("button[type='submit']"));
            
            System.out.println("Clicking Register button to submit the finalized form data...");
            registerButton.click();
            
            System.out.println("Form successfully submitted! Pausing for 5 seconds to view results...");
            Thread.sleep(5000); 

            // =========================================================================
            // SCREENSHOT GENERATION
            // =========================================================================
            System.out.println("Taking an automated screenshot of the submission state...");
            java.io.File scrFile = ((org.openqa.selenium.TakesScreenshot) driver).getScreenshotAs(org.openqa.selenium.OutputType.FILE);
            org.openqa.selenium.io.FileHandler.copy(scrFile, new java.io.File("registration_success.png"));
            System.out.println("Screenshot captured and saved as 'registration_success.png'!");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Teardown browser environment context safely
            System.out.println("Closing the automated Chrome browser window now.");
            driver.quit();
        }
    }
}
