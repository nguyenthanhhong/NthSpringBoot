package com.nth.standard.view;

import com.nth.standard.common.model.Config;
import com.nth.standard.common.utility.Constants;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @class PdfReportViewer
 * @author Hong Nguyen
 * @version 1.0
 */
@Component("pdfReportView")
public class PdfReportViewer extends AbstractView {
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<HashMap> data = (List<HashMap>) model.get(Constants.REPORT_PARAM_DATA);
        HashMap params = (HashMap)model.get(Constants.REPORT_PARAM_PARAMETERS);;
        String reportName = Config.getValue("report.pdfReportPath") + model.get(Constants.REPORT_PARAM_NAME).toString();

        JasperReport report = JasperCompileManager.compileReport(reportName);
        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(data);

        JasperPrint jasperPrint = JasperFillManager.fillReport(report, params, dataSource);

        response.setContentType("application/pdf");
        final OutputStream outStream = response.getOutputStream();
        JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);
        outStream.flush();
        outStream.close();
    }
}
