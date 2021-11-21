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
function set_expression(effect, property, value){
	var prop = effect(property);
	prop.expression = value
}

var glow = add_adj_layer("Glow");
glow.opacity.setValue(12.5);
// glow.blendingMode = BlendingMode.NORMAL;
var fx_glow = add_effect(glow, "PEDG");
set_prop(fx_glow, "Radius", 256);
set_prop(fx_glow, "Exposure", 0.7);
set_prop(fx_glow, "Threshold", 0);
set_prop(fx_glow, "Threshold Smooth", 0);
set_prop(fx_glow, "Blend Mode", 2);
set_prop(fx_glow, "Source Opacity", 0);
// set_expression(fx_glow, "Source Opacity", '(1 - thisProperty.propertyGroup()("Exposure")) * 100');

var chroma = add_adj_layer("Chromatic Aberration");
var chroma_QCA2 = add_effect(chroma, "PEQCAGL");
set_prop(chroma_QCA2, "Position", 0);
set_prop(chroma_QCA2, "Scale", 100.2);
set_prop(chroma_QCA2, "Blur", 2.0);
set_prop(chroma_QCA2, "Unmult", false);

var lin_to_log = add_adj_layer("Lin to Log");
var fx_lin_to_log = add_effect(lin_to_log, "ADBE Cineon Converter2");
set_prop(fx_lin_to_log, "Conversion Type", 1);
set_prop(fx_lin_to_log, "10 Bit Black Point", 0);
set_prop(fx_lin_to_log, "10 Bit White Point", 685);
set_prop(fx_lin_to_log, "Gamma", 2.0);
set_prop(fx_lin_to_log, "Highlight Rolloff", 0);
// var fx_curves = add_effect(lin_to_log, "ADBE CurvesCustom");
lin_to_log.applyPreset(File("C:/Program Files/Adobe/Adobe After Effects 2022/Support Files/Presets/ax_curve_003.ffx"));

var grain = add_adj_layer("Film Grain");
var fx_grain = add_effect(grain, "VISINF Grain Implant");
set_prop(fx_grain, "Viewing Mode", 3);
set_prop(fx_grain, "Intensity", 0.4);
set_prop(fx_grain, "Size", 0.6);

// alert(app.project.activeItem.layer(1).Effects(1).matchName)

app.endUndoGroup();