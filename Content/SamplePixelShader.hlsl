Texture2D shaderTexture;
SamplerState SampleType;
struct PixelShaderInput
{
	min16float4 pos         : SV_POSITION;
	min16float2 texCoord    : TEXCOORD0;
};

Texture2D<float>  luminanceChannel   : t0;
Texture2D<float2> chrominanceChannel : t1;
SamplerState      defaultSampler     : s0;

// Derived from https://msdn.microsoft.com/en-us/library/windows/desktop/dd206750(v=vs.85).aspx
// Section: Converting 8-bit YUV to RGB888
static const float3x3 YUVtoRGBCoeffMatrix =
{
	1.164383f,  1.164383f, 1.164383f,
	0.000000f, -0.391762f, 2.017232f,
	1.596027f, -0.812968f, 0.000000f
};

float3 ConvertYUVtoRGB(float3 yuv)
{
	// Derived from https://msdn.microsoft.com/en-us/library/windows/desktop/dd206750(v=vs.85).aspx
	// Section: Converting 8-bit YUV to RGB888

	// These values are calculated from (16 / 255) and (128 / 255)
	yuv -= float3(0.062745f, 0.501960f, 0.501960f);
	yuv = mul(yuv, YUVtoRGBCoeffMatrix);

	return saturate(yuv);
}

// A pass-through function for the (interpolated) color data.
min16float4 main(PixelShaderInput input) : SV_TARGET
{
	/*float y = luminanceChannel.Sample(defaultSampler, input.texCoord);
	float2 uv = chrominanceChannel.Sample(defaultSampler, input.texCoord);
	/*float r = uv.r;
	uv.r = uv.g;
	uv.g = r;
	return min16float4(ConvertYUVtoRGB(float3(y, uv)), 1.f);*/
	return min16float4(1.f,0.f,0.f,1.f);
}
