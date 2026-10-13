$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path
$utf8 = [Text.UTF8Encoding]::new($false)
$targetPath = Join-Path $root '光的衍射.md'
$target = [IO.File]::ReadAllText($targetPath, $utf8)
$newline = if ($target.Contains("`r`n")) { "`r`n" } else { "`n" }

function Get-Body([string]$name) {
    $path = Join-Path $root ($name + '.md')
    $text = [IO.File]::ReadAllText($path, $utf8)
    $match = [regex]::Match(
        $text,
        '\A---\r?\n.*?\r?\n---\r?\n',
        [Text.RegularExpressions.RegexOptions]::Singleline
    )
    if (-not $match.Success) {
        throw "笔记缺少 YAML 属性区：$path"
    }
    return ([regex]::Replace($text.Substring($match.Length), '\r\n|\r|\n', $newline)).Trim()
}

function Shift-Headings([string]$text) {
    return [regex]::Replace(
        $text,
        '(?m)^(#{1,5})(?=\s)',
        { param($m) '#' + $m.Groups[1].Value }
    )
}

$sectionStart = [regex]::Match($target, '(?m)^# Fraunhofer衍射\r?$')
if (-not $sectionStart.Success) {
    throw '找不到已合并部分的起点。'
}
$base = $target.Substring(0, $sectionStart.Index).TrimEnd()
$base = [regex]::Replace(
    $base,
    '(?m)^## Kirchhoff衍射公式\r?$',
    '## Fresnel-Kirchhoff衍射公式'
)

$fraunhofer = Get-Body 'Fraunhofer衍射'
$fresnel = Get-Body 'Fresnel衍射'
$grating = Get-Body '光栅衍射'

$intensityHeading = [regex]'(?m)^## 衍射光强分布\r?$'
$fraunhofer = $intensityHeading.Replace($fraunhofer, '## 矩形孔衍射光强分布', 1)
$fraunhofer = $intensityHeading.Replace($fraunhofer, '## 圆孔衍射光强分布', 1)
$fraunhofer = [regex]::Replace($fraunhofer, '(?m)^## 图样特性\r?$', '## 单缝衍射图样特性')
$fraunhofer = [regex]::Replace($fraunhofer, '(?m)^### 图样特性\r?$', '### 多缝衍射图样特性')
$fresnel = $fresnel.Replace('[[光的衍射#Fresnel近似]]]', '前面Fresnel近似')
$fresnel = $fresnel.Replace(
    '[[Fraunhofer衍射]]',
    '[[光的衍射#Fraunhofer衍射|Fraunhofer衍射]]'
)
$grating = $grating.Replace(
    '[[Fraunhofer衍射#Fraunhofer多缝衍射#极值]]',
    '[[光的衍射#极值|Fraunhofer多缝衍射中极值]]'
)

$fraunhofer = Shift-Headings $fraunhofer
$fresnel = Shift-Headings $fresnel
$grating = Shift-Headings $grating

$tail = @(
    '# Fraunhofer衍射'
    $fraunhofer
    '# Fresnel衍射'
    $fresnel
    '# 光栅衍射'
    $grating
) -join ($newline + $newline)

$rebuilt = $base + ($newline + $newline) + $tail + $newline
[IO.File]::WriteAllText($targetPath, $rebuilt, $utf8)
"Rebuilt 光的衍射.md ($($rebuilt.Length) characters)."
