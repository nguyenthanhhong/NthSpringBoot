<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page contentType="text/html; charset=UTF-8" %>

    <!--<spring:message code="user.cd" />-->
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-lg-6">
            <!-- Example Panel With Heading -->
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Panel Heading
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm"><i class="icon fa fa-arrows" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm"><i class="icon fa fa-arrows-alt" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="" placeholder="Search...">
                    </div>
                    <div class="col-md-4">
                    <button type="button" class="btn btn-icon btn-danger btn-outline btn-round"><i class="icon fa fa-arrow-circle-right" aria-hidden="true"></i></button>
                    </div>

                </div>
            </div>
            <!-- End Example Panel With Heading -->
        </div>

        <div class="col-lg-6">
          <!-- Example Panel With Footer -->
          <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Panel Heading
                    </h5>
                    <div class="panel-actions">
                        <input type="text" class="form-control" name="" placeholder="Search...">
                    </div>
                </div>
            <div class="panel-body">
              <h4>Body Heading</h4>
              <p>Wrap buttons or secondary text in <code>.panel-footer</code>. Note
                that panel footers do not inherit colors and borders when using
                contextual variations as they are not meant to be in the foreground.</p>
            </div>
            <div class="panel-footer">Panel Footer</div>
          </div>
          <!-- End Example Panel With Footer -->
        </div>
    </div>

</div>