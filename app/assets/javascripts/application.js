//= require jquery
//= require jquery-3.3.1.min
//= require scripts
//= require main
//= require main-quote
//= require jquery.themepunch.tools.min
//= require jquery.themepunch.revolution.min
//= require demo.revolution_slider
//= require owl.carousel
//= require owl.carousel.min
//= require Chart

//building_for_customer

$(function() {
    $("select#intervention_customer_id").on("change", function() {
        console.log("change select customer");
        $.ajax({
            url:  "/buildings_for_customer",
            type: "GET",
            data: { selected_customer: $("select#intervention_customer_id").val() },
            success: function(buildings, status) {
                console.log("success");
                console.log(buildings);
                $("#intervention_building_id").html("<option></option>");
                var options_string = ""
                for (i = 0; i < buildings.length; i++) { 
                    console.log(i);
                    console.log(buildings[i].id);
                    options_string = options_string + "<option>" + buildings[i].id + "</option>";
                    console.log(options_string);
                }
                console.log("ready to update dropdown");
                console.log(options_string);
                $("#intervention_building_id").html("<option>Select</option>" + options_string);
            }
        });
    });
});

// batteries_for_building

$(function() {
    $("select#intervention_building_id").on("change", function() {
        console.log("change select building");
        $.ajax({
            url:  "/batteries_for_building",
            type: "GET",
            data: { selected_building: $("select#intervention_building_id").val() },
            success: function(batteries, status) {
                console.log("success");
                console.log(batteries);
                $("#intervention_battery_id").html("<option></option>");
                var options_string = ""
                for (i = 0; i < batteries.length; i++) { 
                    console.log(i);
                    console.log(batteries[i].id);
                    options_string = options_string + "<option>" + batteries[i].id + "</option>";
                    console.log(options_string);
                }
                console.log("ready to update dropdown");
                console.log(options_string);
                $("#intervention_battery_id").html("<option>Select</option>" + options_string);
            }
        });
    });
});


// columns_for_battery

$(function() {
    $("select#intervention_battery_id").on("change", function() {
        console.log("change select battery");
        $.ajax({
            url:  "/columns_for_battery",
            type: "GET",
            data: { selected_battery: $("select#intervention_battery_id").val() },
            success: function(columns, status) {
                console.log("success");
                console.log(columns);
                $("#intervention_column_id").html("<option></option>");
                var options_string = ""
                for (i = 0; i < columns.length; i++) { 
                    console.log(i);
                    console.log(columns[i].id);
                    options_string = options_string + "<option>" + columns[i].id + "</option>";
                    console.log(options_string);
                }
                console.log("ready to update dropdown");
                console.log(options_string);
                $("#intervention_column_id").html("<option>Select</option>" + options_string);
            }
        });
    });
});

// elevators_for_column

$(function() {
    $("select#intervention_column_id").on("change", function() {
        console.log("change select column");
        $.ajax({
            url:  "/elevators_for_column",
            type: "GET",
            data: { selected_column: $("select#intervention_column_id").val() },
            success: function(elevators, status) {
                console.log("success");
                console.log(elevators);
                $("#intervention_elevator_id").html("<option></option>");
                var options_string = ""
                for (i = 0; i < elevators.length; i++) { 
                    console.log(i);
                    console.log(elevators[i].id);
                    options_string = options_string + "<option>" + elevators[i].id + "</option>";
                    console.log(options_string);
                }
                console.log("ready to update dropdown");
                console.log(options_string);
                $("#intervention_elevator_id").html("<option>Select</option>" + options_string);
            }
        });
    });
});