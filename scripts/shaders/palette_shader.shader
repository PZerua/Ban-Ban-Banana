shader_type canvas_item;

uniform bool conversion_mode = false;
uniform bool override_colors = false;
uniform vec4 color_0 : hint_color = vec4(0.25, 0.25, 0.25, 1.0);
uniform vec4 color_1 : hint_color = vec4(0.5, 0.5, 0.5, 1.0);
uniform vec4 color_2 : hint_color = vec4(0.75, 0.75, 0.75, 1.0);
uniform vec4 color_3 : hint_color = vec4(1.0, 1.0, 1.0, 1.0);

bool is_lower_color(vec4 c1, vec4 c2) {
	return (c1.r < c2.r);
}

vec4 grayscale(vec4 c) {
	float sum = (c.r * 0.21) + (c.g * 0.72) + (c.b * 0.07);
	return vec4(vec3(sum), c.a);
}

vec4 convert_color(vec4 c) {
	vec4 c0 = vec4(0.251, 0.251, 0.251, 1.0);
	vec4 c1 = vec4(0.501, 0.501, 0.501, 1.0);
	vec4 c2 = vec4(0.751, 0.751, 0.751, 1.0);
	vec4 c3 = vec4(1.0, 1.0, 1.0, 1.0);
	
	if (conversion_mode) {
		c = grayscale(c);
	}
	
	if (override_colors) {
		if (is_lower_color(c, c0)) {
			return vec4(color_0.rgb, c.a);
		} else if (is_lower_color(c, c1)) {
			return vec4(color_1.rgb, c.a);
		} else if (is_lower_color(c, c2)) {
			return vec4(color_2.rgb, c.a);
		} else {
			return vec4(color_3.rgb, c.a);
		}
	} else {
		if (is_lower_color(c, c0)) {
			return vec4(c0.rgb, c.a);
		} else if (is_lower_color(c, c1)) {
			return vec4(c1.rgb, c.a);
		} else if (is_lower_color(c, c2)) {
			return vec4(c2.rgb, c.a);
		} else {
			return vec4(c3.rgb, c.a);
		}
	}
	
	return vec4(1.0, 0.0, 0.0, 1.0);
}

void fragment() {
	COLOR = convert_color(textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0)); 
}
