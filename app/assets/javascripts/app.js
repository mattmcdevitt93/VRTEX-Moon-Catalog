'use strict'
var Module = Module || {};

$(document).ready(function() {
	console.log('Ready!')
	Module.bindings();
	// Module.getRegionsAll();
});

Module.bindings = function () {

}

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

