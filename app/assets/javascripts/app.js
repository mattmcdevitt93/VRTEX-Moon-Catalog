'use strict'
var Module = Module || {};

$(document).ready(function() {
	console.log('Ready!')
	Module.bindings();
	Module.update_price_table(150)
});

Module.bindings = function () {

	$( "#material_rock_hov" ).hover(
		function() {
			console.log('Hover On!')
			$(".material_rock_exp").css("display", "inline")
		}, function() {
			console.log('Hover Off!')
			$(".material_rock_exp").css("display", "none")
		}
	);
	$( "#material_R4_hov" ).hover(
		function() {
			console.log('Hover On!')
			$(".material_R4_exp").css("display", "inline")
		}, function() {
			console.log('Hover Off!')
			$(".material_R4_exp").css("display", "none")
		}
	);
	$( "#material_R8_hov" ).hover(
		function() {
			console.log('Hover On!')
			$(".material_R8_exp").css("display", "inline")
		}, function() {
			console.log('Hover Off!')
			$(".material_R8_exp").css("display", "none")
		}
	);
	$( "#material_R16_hov" ).hover(
		function() {
			console.log('Hover On!')
			$(".material_R16_exp").css("display", "inline")
		}, function() {
			console.log('Hover Off!')
			$(".material_R16_exp").css("display", "none")
		}
	);
	$( "#material_R32_hov" ).hover(
		function() {
			console.log('Hover On!')
			$(".material_R32_exp").css("display", "inline")
		}, function() {
			console.log('Hover Off!')
			$(".material_R32_exp").css("display", "none")
		}
	);
	$( "#material_R64_hov" ).hover(
		function() {
			console.log('Hover On!')
			$(".material_R64_exp").css("display", "inline")
		}, function() {
			console.log('Hover Off!')
			$(".material_R64_exp").css("display", "none")
		}
	);

	var handle = $( "#custom-handle" );
    $( "#slider" ).slider({
      create: function() {
        handle.text( $( this ).slider( "value" ) );
      },
      slide: function( event, ui ) {
        handle.text( ui.value );


		Module.update_price_table(ui.value)
      },
      min: 150,
      // max: 155
      max: 1400
    });

}

Module.update_price_table = function(hours) {
	var total_value = 0;
    var count = ($('#data_table tr').length)-2;
    var total_unit_value = $('#total_unit_value').attr("price_data")
	for (var i = 0; i <= count-1; i++) {
		var price = $('#product_price_'+i).attr("price_data");
		// console.log('update prices! ' + i + ' - ' + (price * hours));
		$('#total_price_'+i).html(((price * 200) * hours).toLocaleString()  + " ISK")
		total_value = total_value + ((price * 200) * hours)

		var price = $('#product_price_'+i).attr("price_data");
		$('#total_percent_'+i).html( ((price / total_unit_value).toFixed(2) * 100).toFixed(0) + " ")
	}
	$('#total_value').html(total_value.toLocaleString() + " ISK")

}



// Module.chart_load = function (name, data) {
// google.charts.load('current', {'packages':['corechart']});
// google.charts.setOnLoadCallback(drawChart);
// 	var s = data.split("~");
// 	var chart_data = []
// 	chart_data.push(['Moon', 'Percent of Materials']);
// 	// console.log(s);
// 	for (var i = s.length - 1; i >= 0; i--) {
// 		var ss = s[i].split(",")
// 		ss[1] = parseInt(ss[1])
// 		if (ss[0] != [""]) {
// 			chart_data.push(ss);
// 		}
// 		// console.log(ss);
// 	}
// 	// console.log(chart_data);

// // Draw the chart and set the chart values
// 	function drawChart(data) {
// 	// console.log(chart_data); 
// 	  var data = google.visualization.arrayToDataTable(chart_data);

// 	  // Optional; add a title and set the width and height of the chart
// 	  var options = {'title':name, 'width':400, 'height':250, pieHole: 0.75, pieSliceText: 'none'};
// 	  // Display the chart inside the <div> element with id="piechart"
// 	  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
// 	  chart.draw(data, options);
// 	}

// }

// Module.sliderBindings = function (slider_id, handle) {
// 		slider_id.slider( {
// 		create: function() {
// 			handle.text( $( this ).slider( "value" ) );
// 		},
// 		slide: function( event, ui ) {
// 			handle.text( ui.value );
// 			console.log( ui.value, event.target.id )
// 			Module.contentUpdate(ui.value, event.target.id);
// 		}
// 	} );
// }

// Module.contentUpdate = function (value, slot) {
// 	if ($('#content_output').val() == "") {
// 		console.log('Resetting Output');
// 		$('#content_output').val('test')
// 	}
// 	$('#content_output').val()
// 	var contents = $('.moon_content')
// 	for (var i = 0; i < contents.length ; i++) {
// 		var percent = $( "#" + i )
// 		if (slot == i) {
// 			console.log("Conetents:" + i + "[" + contents[i].value + ", " + value + "] " + slot)
// 		}
// 	}
// }

// Module.hideSelectFields = function () {
// 	console.log("Update Hidden Select Fields")
// 	var field = [$("#moon_Constellation_id"), $("#moon_System_id"), $("#moon_Planet_id"), $("#moon_Moon_id")]
// 	for (var i = 0; i < field.length; i++) {
// 		field[i].each(function() {
// 			if ($(this).val() == "") {
// 				field[i].addClass( "hidden" );
// 			}
// 		});
// 	}
// 	if (($("#moon_Constellation_id").val() != "" && $("#moon_System_id").val() != "" && $("#moon_Planet_id").val() != "" && $("#moon_Moon_id").val() != "" && $("#moon_Region_id").val() != "") == true) {
// 		$("#form_content").removeClass("hidden")
// 		$("#form_submit").removeClass("hidden")
// 	} else {
// 		$("#form_content").addClass("hidden")
// 		$("#form_submit").addClass("hidden")
// 	}
// }

// Module.getRegionsByID = function (id) {
// 	$.ajax({
// 		url: "https://esi.tech.ccp.is/latest/universe/regions/" + id + "/?datasource=tranquility&language=en-us",
// 		cache: false,
// 		success: function(html){
// 			// console.log("Success");
// 			// console.log(html);
// 			// Module.regionList.push("['" + html.name + "', " + html.region_id + "]");
// 			// document.getElementById("output").innerHTML = Module.regionList.toString();
// 			return html
// 		}
// 	});
// }

// Module.getConsetllationsByID = function (id) {

// 	$.getJSON('https://esi.tech.ccp.is/latest/universe/regions/' + id + '/?datasource=tranquility&language=en-us',function(data){
// 		// console.log(data);
// 		console.log(data.name, data.constellations);
// 		$("#moon_Constellation_id").empty().append("<option value=''></option>");
// 		for (var i = 0; i < data.constellations.length; i++) {
// 			// console.log(data.constellations[i]);
// 			$.getJSON('https://esi.tech.ccp.is/latest/universe/constellations/' + data.constellations[i] + '/?datasource=tranquility&language=en-us',function(data){
// 				// console.log(data);
// 				$("#moon_Constellation_id").append("<option value=" + data.constellation_id + ">" + data.name + "</option>").removeClass( "hidden" );
// 			})
// 		}
// 	})
// }

// Module.getSystemByID = function (id) {
// 	$.getJSON('https://esi.tech.ccp.is/latest/universe/constellations/' + id + '/?datasource=tranquility&language=en-us',function(data){
// 		console.log(data.name, data.systems);
// 		$("#moon_System_id").empty().append("<option value=''></option>");

// 		for (var i = 0; i < data.systems.length; i++) {
// 			// console.log(data.constellations[i]);
// 			$.getJSON('https://esi.tech.ccp.is/latest/universe/systems/' + data.systems[i] + '/?datasource=tranquility&language=en-us',function(data){
// 				// console.log(data);
// 				$("#moon_System_id").append("<option value=" + data.system_id + ">" + data.name + "</option>").removeClass( "hidden" );
// 			})
// 		}
// 	})
// }

// Module.getPlanetByID = function (id) {
// 	$.getJSON('https://esi.tech.ccp.is/latest/universe/systems/' + id + '/?datasource=tranquility&language=en-us',function(data){
// 		console.log(data.name, data.planets);
// 		$("#moon_Planet_id").empty().append("<option value=''></option>");

// 		for (var i = 0; i < data.planets.length; i++) {
// 			$("#moon_Planet_id").append("<option value=" + data.planets[i].planet_id + " name=" + i + ">Planet " + (i + 1) + "</option>").removeClass( "hidden" );
// 		}
// 	})
// }

// Module.getMoonbyID = function (id, n) {
// 	console.log(id, n);
// 	$.getJSON('https://esi.tech.ccp.is/latest/universe/systems/' + id + '/?datasource=tranquility&language=en-us',function(data){
// 		console.log(data);
// 		$("#moon_Moon_id").empty().append("<option value=''></option>");
// 		if (data.planets[n].moons != null) {
// 			for (var i = 0; i < data.planets[n].moons.length; i++) {
// 				console.log(data.planets[n].moons[i])
// 				$("#moon_Moon_id").append("<option value=" + data.planets[n].moons[i] + ">Moon " + (i + 1)  + "</option>").removeClass( "hidden" );
// 			}
// 		}
// 	})
// }

// Module.getRegionsAll = function () {
// 	Module.regionList = []

// 	console.log("Get All Regions")
// 	$.ajax({
// 		url: "https://esi.tech.ccp.is/latest/universe/regions/?datasource=tranquility",
// 		cache: false,
// 		success: function(html){
// 			// console.log("Success");
// 			console.log(html);
// 			for (var i = 0; i < html.length; i++) {
// 				Module.getRegionsByID(html[i]);
// 			}
// 		}
// 	});
	// ["Derelik", "The Forge", "Vale of the Silent", "Wicked Creek", "Cache", "Detorid", "Scalding Pass", "Insmother", "UUA-F4", "Great Wildlands", "Tribute", "The Spire", "Malpais", "Lonetrek", "Venal", "Catch", "Curse", "Domain", "Immensea", "The Bleak Lands", "Geminate", "Paragon Soul", "Tenal", "Solitude", "Stain", "Tenerifis", "Outer Passage", "Feythabolis", "Tash-Murkon", "Delve", "C-R00011", "Sinq Laison", "Pure Blind", "Kador", "Cobalt Edge", "Providence", "Aridia", "A821-A", "Cloud Ring", "Perrigen Falls", "C-R00013", "Fountain", "The Kalevala Expanse", "Molden Heath", "C-R00012", "Placid", "D-R00020", "Metropolis", "B-R00006", "B-R00007", "E-R00026", "The Citadel", "C-R00015", "D-R00018", "Khanid", "C-R00010", "D-R00022", "C-R00009", "H-R00032", "Deklein", "Verge Vendor", "Period Basis", "D-R00021", "E-R00029", "Etherium Reach", "D-R00023", "A-R00002", "B-R00004", "F-R00030", "Syndicate", "Esoteria", "B-R00005", "Kor-Azor", "K-R00033", "C-R00014", "Branch", "Heimatar", "Querious", "Essence", "Oasa", "A-R00003", "Genesis", "Fade", "E-R00024", "Impass", "D-R00016", "E-R00025", "A-R00001", "Outer Ring", "Omist", "E-R00027", "D-R00017", "B-R00008", "Devoid", "Black Rise", "G-R00031", "D-R00019", "Everyshore", "J7HZ-F", "E-R00028"]
// };

