package shaders;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;

class PixRetShader extends FlxShader{ 
    @:glFragmentSource("
#pragma header

#define round(a) floor(a + 0.5)
#define texture flixel_texture2D
#define iResolution openfl_TextureSize
uniform float iTime;
#define iChannel0 bitmap
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
uniform float pixelZoom;

vec3 scanline(vec2 coord, vec3 screen)
{
	screen.rgb -= sin((coord.y + (iTime * 29.0))) * 0.02;
	return screen;
}

vec2 crt(vec2 coord, float bend)
{
	coord = (coord - 0.5) * 2.0;

	coord *= 1.1;	
	coord.x *= 1.0 + pow((abs(coord.y) / bend), 2.0);
	coord.y *= 1.0 + pow((abs(coord.x) / bend), 2.0);
	coord  = (coord / 2.0) + 0.5;

	return coord;
}

vec3 sampleSplit(sampler2D tex, vec2 coord)
{
	vec3 frag;
	frag.r = texture(tex, vec2(coord.x - 0.01 * sin(iTime), coord.y)).r;
	frag.g = texture(tex, vec2(coord.x                          , coord.y)).g;
	frag.b = texture(tex, vec2(coord.x + 0.01 * sin(iTime), coord.y)).b;
	return frag;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
	uv.y = 1.0 - uv.y;
	vec2 crtCoords = crt(uv, 3.2);
	if (crtCoords.x < 0.0 || crtCoords.x > 1.0 || crtCoords.y < 0.0 || crtCoords.y > 1.0)
		discard;
	fragColor.rgb = sampleSplit(iChannel0, crtCoords);
	vec2 screenSpace = crtCoords * iResolution.xy;
	fragColor.rgb = scanline(screenSpace, fragColor.rgb);
}


void main() {
    vec2 camPos = getCamPos(openfl_TextureCoordv);
	camPos = vec2(0.5, 0.5) + ((camPos - vec2(0.5, 0.5)) * pixelZoom);
    gl_FragColor = textureCam(bitmap, camPos);
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}
    ")
    	public function new()
	{
		super();
	}
}