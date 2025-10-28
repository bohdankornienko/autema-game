    shader_type canvas_item;

    uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 0.4); // Red outline by default
    uniform float outline_width : hint_range(0.0, 5.0, 0.1) = 1.0; // Outline thickness

    void fragment() {
        vec4 base_color = texture(TEXTURE, UV);
        vec4 final_color = base_color;

        if (base_color.a == 0.0) { // Only process transparent pixels for outline
            float max_alpha = 0.0;
            vec2 pixel_size = TEXTURE_PIXEL_SIZE;

            // Sample surrounding pixels to find the nearest solid pixel
            for (float x = -outline_width; x <= outline_width; x += 1.0) {
                for (float y = -outline_width; y <= outline_width; y += 1.0) {
                    vec2 offset_uv = UV + vec2(x, y) * pixel_size;
                    max_alpha = max(max_alpha, texture(TEXTURE, offset_uv).a);
                }
            }

            // If a solid pixel is nearby, draw the outline
            if (max_alpha > 0.0) {
                final_color = outline_color;
            }
        }

        COLOR = final_color;
    }