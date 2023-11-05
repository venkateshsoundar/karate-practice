package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;


class ConduitTest {

	/*
	 * @Test void testParallel() { Results results =
	 * Runner.path("classpath:conduitApp") //.outputCucumberJson(true) .parallel(5);
	 * assertEquals(0, results.getFailCount(), results.getErrorMessages()); }
	 */
	/*
	 * @Karate.Test Karate testTags() { return Karate.run().relativeTo(getClass());
	 * }
	 */
    @Test
      void testParallel() {
    	
    	System.setProperty("karate.env", "dev");	
        Results results = Runner.path("classpath:conduitApp").tags("@CoderTest").outputCucumberJson(true).parallel(2);
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    
    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "ConduitApp");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
    
    
    
}
