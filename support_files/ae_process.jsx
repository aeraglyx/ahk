app.beginUndoGroup("AE Process");

app.project.bitsPerChannel = 32;
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

var glow = add_adj_layer("Glow");
glow.blendingMode = BlendingMode.ADD;
var fx_glow = add_effect(glow, "PEDG");
set_prop(fx_glow, "Radius", 256);
set_prop(fx_glow, "Exposure", 0.125);
set_prop(fx_glow, "Threshold", 0);
set_prop(fx_glow, "Threshold Smooth", 0);

var chroma = add_adj_layer("Chromatic Aberration");
var chroma_QCA2 = add_effect(chroma, "PEQCAGL");
set_prop(chroma_QCA2, "Position", 0);
set_prop(chroma_QCA2, "Scale", 100.2);
set_prop(chroma_QCA2, "Blur", 2.0);

var lin_to_log = add_adj_layer("Lin to Log");
var fx_lin_to_log = add_effect(lin_to_log, "ADBE Cineon Converter2");
set_prop(fx_lin_to_log, "Conversion Type", 1);
set_prop(fx_lin_to_log, "10 Bit Black Point", 0);
set_prop(fx_lin_to_log, "10 Bit White Point", 685);
set_prop(fx_lin_to_log, "Gamma", 2.0);
set_prop(fx_lin_to_log, "Highlight Rolloff", 0);

var grain = add_adj_layer("Film Grain");
var fx_grain = add_effect(grain, "VISINF Grain Implant");
set_prop(fx_grain, "Viewing Mode", 3);
set_prop(fx_grain, "Intensity", 0.4);
set_prop(fx_grain, "Size", 0.6);

// alert(app.project.activeItem.layer(1).Effects(1).matchName)

app.endUndoGroup();