/**
Item type multi select box
base_element: id
catType:   PURC - purchase item
        SALE - sale item
**/
function initItemKindCombo(base_element, catType, rnpTyp){
    let params = {
        CAT_FG_CD : typeof catType != 'undefined' ? catType : 'PURC',
        RNP_TYP_CD : typeof rnpTyp != 'undefined' ? rnpTyp : ''
    };
    apiRequest({
        method: 'POST',
        url: "/main/purchase/pi/PIItemTypeMgt/getItemKindList",
        data: JSON.stringify(params),
        contentType: "application/json",
        success: function (data) {
            base_element.empty();
            $.each(data.data, function(i, d){
                base_element.append('<option value="' + d.CD + '">' + d.NM + '</option>');
            });
            if (base_element.attr("multiple") == "multiple") {
                base_element.multiselect({
                    buttonWidth: '200px',
                    enableFiltering: true,
                    includeSelectAllOption: true
                });
            } else {
                base_element.prepend('<option value="" selected>Select</option>');
            }
        },
        error: function (error) {
            console.log(error);
        }
    });
}

/**
Item type multi select group box
catType:   PURC - purchase item
        SALE - sale item
**/
function initCatTree3Depth(base_element, catType) {
    let params = {
        CAT_FG_CD : typeof catType != 'undefined' ? catType : ''
    };
    apiRequest({
        method: "POST",
        url: "/main/purchase/pi/PIPurcCategoryMgt/listCat",
        data: JSON.stringify(params),
        contentType: "application/json",
        success: function (data) {
            createCategoryComboGroup(base_element, data.data);
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function createCategoryComboGroup(base_element, catData) {
    var $selectGroup = base_element;
    var $selectL = $selectGroup.find('select:eq(0)').empty().append('<option value="">' + lblLv1 + '</option>');
    var $selectM = $selectGroup.find('select:eq(1)').empty().append('<option value="">' + lblLv2 + '</option>');
    var $selectS = $selectGroup.find('select:eq(2)').empty().append('<option value="">' + lblLv3 + '</option>');

    $.each(catData, function(i, d){
		if(d.LV === '01') {
			$selectL.append('<option value="' + d.CD + '">' + d.NM + '</option>');
		}
	});

	$selectL.off('change changeval').on('change changeval', function(e) {
		$selectM.empty().append('<option value="">' + lblLv2 + '</option>');
		$selectS.empty().append('<option value="">' + lblLv3 + '</option>');
		$.each(catData, function(i, d){
			if(d.PCD == $selectL.val() && d.LV == '02') {
				$selectM.append('<option value="' + d.CD + '">' + d.NM + '</option>');
			}
		});
	});

	$selectM.off('change changeval').on('change changeval', function(e) {
		$selectS.empty().append('<option value="">' + lblLv3 + '</option>');
		$.each(catData, function(i, d){
			if(d.PCD == $selectM.val() && d.LV == '03') {
				$selectS.append('<option value="' + d.CD + '">' + d.NM + '</option>');
			}
		});
	});
}