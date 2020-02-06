# NthSpringBoot
 Spring boot project
 
## Back-end

Spring Security (login, PasswordEncode, Access permission)
- Login by id and password
- Encode pass in database
- Filter permission on access every page url, every button on page

Connect multi data database
- MySQL
- PostgreSQL

Provide api to access data of database
- ../sqlObject : get 1 json object
- ../sqlList : get list of object
- ../sqlInsert : insert data
- ../sqlUpdate : update data
- ../sqlDelete : delete data
- ../sqlCall : call procedure

Use MyBatis to mapping between SQL databases and objects in Java
- Easy to call by formula : namespace.id
- Store sql file in resource folder (/resources/sql) and can separate in sub folders

Multi languages
- Load languages from database (message, label, common code)
- Support reload resource by use simple api

Change languages		

Use TagSupport to create custom component
- Select combobox with element get from common code
- Checkbox and radio group with values get from common code
- Common Code list that can parse to json object
- Select combobox with element get from custom query

Use jasper report to view pdf report		

Use Apache Tiles 3 to reuse page pieces across the application, keeping consistent look and feel
- I create 3 layout for homepage, function page, error page

## Front-end

Custom function to call ajax post request
```
var input = {
/*SQL_SINGLE/SQL_INSERT/SQL_UPDATE/SQL_DELETE/SQL_PROC*/
  type : "SQL_MULTI",
  params : {
   function:"CommonCodeService.getGroupCodeList",
   data: jsonObject
  },
  callBack : callBackFunction
};
transaction(input);
```

Message and Confirm dialog

Custom function to get form data, parse json object to form, check valid data

Custom function to apply automatic input format (date time format, number, multi combobox)

Apply some plugin:
- Bootstrap 4.1.3
- Fontawesome 4.7.0
- Jquery 3.0.0
- Jquery-ui 1.12.1
- Fancytree 2.33.0
- Tabulator 4.5.2
- Bootstrap-multiselect 0.9.15
- Bootstrap-datepicker 1.9.0
- Chart.js 2.9.3
- Inputmask 5.0.3
- Moment 2.24.0

## Business Function

Menu and program
- Create menu tree of system
- Program url is feature url
- Local url is location of jsp file
- Can choose database is mysql or postgree. Every function in 1 page is get from only 1 database connection

Authority of program
- Manager role of system
- Set role to access page follow program url
- Set role to access button on each page (include pages are showed menu and popup page)
- Set user role, if role A can access menu X, user 001 have role A - mean user 001 can access menu X

Common resource
- Common code list and languages
- Message resource and languages
- Label resource and languages
- Local setting of system (date time format type, number format type, round method, currency format type)
