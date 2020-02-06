Tabulator.prototype.getUpdateData = function (active) {

    if (active === true) {

        console.warn("passing a boolean to the getData function is deprecated, you should now pass the string 'active'");

        active = "active";
    }

    return (this.rowManager.getData(active) || []).filter(row => row._rowStatus == 'I' || row._rowStatus == 'U');
};
/**
 * check this cell just insert or not
 * @param cell
 * @returns {boolean}
 */
var isNewGridRow = function (cell) {
    var data = cell.getRow().getData();
    return data._rowStatus == 'I';
};