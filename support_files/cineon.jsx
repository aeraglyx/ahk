app.beginUndoGroup("Cineon");

var comp = app.project.activeItem;

function add_adj_layer(name){
	var layer = comp.layers.addSolid([0.0, 0.0, 0.0], name, comp.width, comp.height, 1.0, comp.duration);
	layer.adjustmentLayer = true;
	return layer;
}
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

var log_to_lin = add_adj_layer("Log to Lin");
var fx_log_to_lin = add_effect(log_to_lin, "ADBE Cineon Converter2");
set_prop(fx_log_to_lin, "Conversion Type", 2);
set_prop(fx_log_to_lin, "10 Bit Black Point", 0);
set_prop(fx_log_to_lin, "10 Bit White Point", white_point);
set_prop(fx_log_to_lin, "Gamma", gamma);
set_prop(fx_log_to_lin, "Highlight Rolloff", 0);

var lin_to_log = add_adj_layer("Lin to Log");
var fx_lin_to_log = add_effect(lin_to_log, "ADBE Cineon Converter2");
set_prop(fx_lin_to_log, "Conversion Type", 1);
set_prop(fx_lin_to_log, "10 Bit Black Point", 0);
set_prop(fx_lin_to_log, "10 Bit White Point", white_point);
set_prop(fx_lin_to_log, "Gamma", gamma);
set_prop(fx_lin_to_log, "Highlight Rolloff", 0);

app.endUndoGroup();