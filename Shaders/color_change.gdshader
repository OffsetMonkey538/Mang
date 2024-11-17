shader_type canvas_item;

uniform float hue_shift: hint_range(0.0, 1.0) = 0;

vec3 hueToRgb(float h) {
	vec3 result = vec3(0, 0, 0);
	result.r = abs(h * 6.0 - 3.0) - 1.0;
	result.g = 2.0 - abs(h * 6.0 - 2.0);
	result.b = 2.0 - abs(h * 6.0 - 4.0);
	return clamp(result, 0.0, 1.0);
}

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, hueToRgb(hue_shift), 0.5);
}