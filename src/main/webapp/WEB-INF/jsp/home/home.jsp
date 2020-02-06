<style>
  .table td, .table th {
    padding: .375rem .75rem !important;
  }
  .fa-check {
    color: blue;
  }
  .fa-times {
    color: red;
  }
</style>
<div class="page-content container-fluid">
  <div class="row">
    <div class="col-lg-6">
      <!-- Example Panel With Heading -->
      <div class="panel">
        <div class="panel-heading pdt-8">
          <h5 class="panel-title">
            <i class="fa fa-chevron-circle-right"></i>Back-end
          </h5>
        </div>
        <div class="panel-body">
          <table class="table table-bordered">
            <tr>
              <th>Function</th>
              <th>Applied</th>
              <th>Checked</th>
            </tr>
            <tr>
              <td><div>
                Spring Security (login, PasswordEncode, Access permission)
                <br>- Login by id and password
                <br>- Encode pass in database
                <br>- Filter permission on access every page url, every button on page
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Connect multi data database
                <br>- MySQL
                <br>- PostgreSQL
              </div></td>
              <td>
                <br><i class="fa fa-check"></i>
                <br><i class="fa fa-check"></i>
              </td>
              <td>
                <br><i class="fa fa-check"></i>
                <br><i class="fa fa-times"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Provide api to access data of database
                <br>- ../sqlObject : get 1 json object
                <br>- ../sqlList : get list of object
                <br>- ../sqlInsert : insert data
                <br>- ../sqlUpdate : update data
                <br>- ../sqlDelete : delete data
                <br>- ../sqlCall : call procedure
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Use MyBatis to mapping between SQL databases and objects in Java
                <br>- Easy to call by formula : namespace.id
                <br>- Store sql file in resource folder (/resources/sql) and can separate in sub folders
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Multi languages
                <br>- Load languages from database (message, label, common code)
                <br>- Support reload resource by use simple api
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td>
                Change languages
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-times"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Use TagSupport to create custom component
                <br>- Select combobox with element get from common code
                <br>- Checkbox and combobox group with values get from common code
                <br>- Common Code list that can parse to json object
                <br>- Select combobox with element get from custom query
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td>
                Use jasper report to view pdf report
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Use Apache Tiles 3 to reuse page pieces across the application, keeping consistent look and feel
                <br>- I create 3 layout for homepage, function page, error page
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <!-- End Example Panel With Heading -->
    </div>

    <div class="col-lg-6">
      <!-- Example Panel With Footer -->
      <div class="panel">
        <div class="panel-heading pdt-8">
          <h5 class="panel-title">
            <i class="fa fa-chevron-circle-right"></i>Front-end
          </h5>
        </div>
        <div class="panel-body">
          <table class="table table-bordered">
            <tr>
              <th>Function</th>
              <th>Checked</th>
            </tr>
            <tr>
              <td><div>
                Custom function to call ajax post request
                <br>var input = {
                <br>  /*SQL_SINGLE/SQL_INSERT/SQL_UPDATE/SQL_DELETE/SQL_PROC*/
                <br>&nbsp  type : "SQL_MULTI",
                <br>&nbsp  params : {
                <br>&nbsp&nbsp    function:"CommonCodeService.getGroupCodeList",
                <br>&nbsp&nbsp    data: jsonObject
                <br>&nbsp  },
                <br>&nbsp  callBack : callBackFunction
                <br>  };
                <br>transaction(input);
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Message and Confirm dialog
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Custom function to get form data, parse json object to form, check valid data
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td><div>
                Custom function to apply automatic input format (date time format, number, multi combobox)
              </div></td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
            <tr>
              <td>
                Apply some plugin:
                <div class="row">
                  <div class="col-6">
                    - Bootstrap 4.1.3
                    <br>- Fontawesome 4.7.0
                    <br>- Jquery 3.0.0
                  </div>
                  <div class="col-6">
                    - Jquery-ui 1.12.1
                    <br>- Fancytree 2.33.0
                    <br>- Tabulator 4.5.2
                  </div>
                  <div class="col-6">
                    - Bootstrap-multiselect 0.9.15
                    <br>- Bootstrap-datepicker 1.9.0
                    <br>- Chart.js 2.9.3
                  </div>
                  <div class="col-6">
                    - Inputmask 5.0.3
                    <br>- Moment 2.24.0
                  </div>
                </div>
              </td>
              <td>
                <i class="fa fa-check"></i>
              </td>
            </tr>
          </table>
        </div>
        <div class="panel-footer">
          <h5 class="panel-title">
            <i class="fa fa-chevron-circle-right"></i>Business Function
          </h5>
        </div>
        <div class="panel-body">
          <table class="table table-bordered">
            <tr>
              <th>Function</th>
            </tr>
            <tr>
              <td><div><b>Menu and program</b>
                <br>- Create menu tree of system
                <br>- Program url is feature url
                <br>- Local url is location of jsp file
                <br>- Can choose database is mysql or postgree. Every function in 1 page is get from only 1 database connection
              </div></td>
            </tr>
            <tr>
              <td><div><b>Authority of program</b>
                <br>- Manager role of system
                <br>- Set role to access page follow program url
                <br>- Set role to access button on each page (include pages are showed menu and popup page)
                <br>- Set user role, if role A can access menu X, user 001 have role A - mean user 001 can access menu X
              </div></td>
            </tr>
            <tr>
              <td><div><b>Common resource</b>
                <br>- Common code list and languages
                <br>- Message resource and languages
                <br>- Label resource and languages
                <br>- Local setting of system (date time format type, number format type, round method, currency format type)
              </div></td>
            </tr>
          </table>
        </div>
      </div>
      <!-- End Example Panel With Footer -->
    </div>
  </div>
</div>
<script>
  function documentReady() {

  }
</script>