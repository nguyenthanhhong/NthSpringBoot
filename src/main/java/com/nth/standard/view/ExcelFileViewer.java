package com.nth.standard.view;

import com.nth.standard.common.model.Config;
import com.nth.standard.common.utility.Constants;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @class ExcelFileViewer
 * @author Hong Nguyen
 * @version 1.0
 */
@Component("ExcelReportView")
public class ExcelFileViewer extends AbstractXlsView {
    @Override
    protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<HashMap> data = (List<HashMap>) model.get(Constants.REPORT_PARAM_DATA);
        List<String> columns = (List<String>) model.get(Constants.REPORT_PARAM_COLUMN);
        String reportName = model.get(Constants.REPORT_PARAM_NAME).toString();

        Sheet sheet = workbook.createSheet("data");
        sheet.setFitToPage(true);
        int rowCount = 0;
        Row header = sheet.createRow(rowCount++);

        for (int i = 0; i < columns.size(); i++) {
            header.createCell(i).setCellValue(columns.get(i));
        }

        for (HashMap currRow : data) {
            Row currencyRow = sheet.createRow(rowCount++);
            for (int i = 0; i < columns.size(); i++) {
                currencyRow.createCell(i).setCellValue(currRow.get(columns.get(i)).toString());
            }
        }

        response.setHeader("Content-Disposition", "attachment; filename=" + reportName + ".xls");
    }
}
