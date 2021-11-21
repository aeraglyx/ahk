app.beginUndoGroup("Cineon");

var comp = app.project.activeItem;
var layer = comp.selectedLayers[0];

function add_effect(layer, effect){
	var fx = layer.Effects.addProperty(effect);
	return fx;
}
function set_prop(effect, property, value){
	effect(property).setValue(value);
}
function set_expression(effect, property, value){
	var prop = effect(property);
	prop.expression = value
}

var white_point = 685;
var gamma = 2.0;

// var lin_to_log = add_adj_layer("Lin to Log");
var fx_lin2log = add_effect(layer, "ADBE Cineon Converter2");
set_prop(fx_lin2log, "Conversion Type", 1);
set_prop(fx_lin2log, "10 Bit Black Point", 0);
set_prop(fx_lin2log, "10 Bit White Point", white_point);
set_prop(fx_lin2log, "Gamma", gamma);
set_prop(fx_lin2log, "Highlight Rolloff", 0);

// var log_to_lin = add_adj_layer("Log to Lin");
var fx_log2lin = add_effect(layer, "ADBE Cineon Converter2");
set_prop(fx_log2lin, "Conversion Type", 2);
set_prop(fx_log2lin, "10 Bit Black Point", 0);
set_prop(fx_log2lin, "10 Bit White Point", white_point);
set_prop(fx_log2lin, "Gamma", gamma);
set_prop(fx_log2lin, "Highlight Rolloff", 0);

app.endUndoGroup();