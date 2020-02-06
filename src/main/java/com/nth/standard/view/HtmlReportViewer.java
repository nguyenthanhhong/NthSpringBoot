package com.nth.standard.view;

import com.nth.standard.common.model.Config;
import com.nth.standard.common.utility.Constants;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @class HtmlReportViewer
 * @author Hong Nguyen
 * @version 1.0
 */
@Component("HtmlReportView")
public class HtmlReportViewer extends AbstractView {
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<HashMap> data = (List<HashMap>) model.get(Constants.REPORT_PARAM_DATA);
        HashMap params = (HashMap)model.get(Constants.REPORT_PARAM_PARAMETERS);;
        String reportName = Config.getValue("report.pdfReportPath") + model.get(Constants.REPORT_PARAM_NAME).toString();

        //compile jrxml template and get report
        JasperReport report = JasperCompileManager.compileReport(reportName);
        //data source
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(data);
        //fill the report with data source objects
        JasperPrint jasperPrint = JasperFillManager.fillReport(report, params, dataSource);
        //export to html
        response.setContentType("text/html");
        HtmlExporter exporter = new HtmlExporter(DefaultJasperReportsContext.getInstance());
        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleHtmlExporterOutput(response.getWriter()));
        exporter.exportReport();
    }
}
