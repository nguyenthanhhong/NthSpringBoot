/* set data to tree
    data: list of node, root node value must be null or empty
    titlename: column name of view node
    nodeName: column name of node
    parentName: column name of parent node
*/
function fn_create_tree_model(data, titleName, nodeName, parentName) {
    if(data.length == 0) {return;}
    var temp1 = [],
        record = data;
    $.each(record, function (index, row) {
        $.extend(row, {
            title: row[titleName]
        })
        temp1.push(row);
    });

    // make tree data
    var temp = {},
        results = [];
    for (var i = 0; i < temp1.length; i++) {
        var e = temp1[i];
        temp[e[nodeName]] = e;
        if (temp[e[parentName]] !== undefined) {
            if (!temp[e[parentName]].hasOwnProperty("children")) {
                temp[e[parentName]].children = [];
                temp[e[parentName]].folder = true;
                temp[e[parentName]].expanded = false;
            }
            temp[e[parentName]].children.push(e);
        } else {
            results.push(e);
        }
    }

    return results;
};

$.fn.createFancyTree = function(data, titleName, nodeName, parentName, selectedNode) {
    const $tree = this;
    $tree.fancytree("getRootNode").removeChildren();
    $tree.fancytree("getRootNode").addChildren(fn_create_tree_model(data, titleName, nodeName, parentName));

    //selected node
    if (selectedNode) {
        $tree.fancytree("getTree").visit(function (node) {
            if (selectedNode.data[nodeName] == "") {
                if (node.title === selectedNode.title) {
                    node.setActive(true);
                    selectedNode = null;
                    return false;
                }
            } else {
                if (node.data[nodeName] == selectedNode.data[nodeName]) {
                    node.setActive(true);
                    selectedNode = null;
                    return false;
                }
            }
        });
    }
};

$.fn.setExpanded = function(isExpand){
    const $tree = this;
    $tree.fancytree("getRootNode").visit(function (node) {
        node.setExpanded(isExpand);
    });
};
/**
 * get data of tree
 * @param isAllData: true: get all data, false: get new/update date
 */
$.fn.getFancyTreeData = function(isAllData){
    const $tree = this;
    let treeData = [];
    $tree.fancytree("getTree").visit(function (node) {
        if(isAllData){
            treeData.push(node.data);
        } else if(node.data._rowStatus == 'U' || node.data._rowStatus == 'I'){
            treeData.push(node.data);
        }
    });
    return treeData;
};