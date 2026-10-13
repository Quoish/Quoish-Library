$ErrorActionPreference = 'Stop'
$root = (Get-Location).Path
$utf8 = [Text.UTF8Encoding]::new($false)
$targetPath = Join-Path $root '光的衍射.md'
$sourceNames = @('Fraunhofer衍射', 'Fresnel衍射', '光栅衍射')

foreach ($name in $sourceNames) {
    $path = Join-Path $root ($name + '.md')
    if (-not (Test-Path -LiteralPath $path)) {
        throw "找不到源文件：$path"
    }
}

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
    return $text.Substring($match.Length)
}

function Normalize-Newlines([string]$text, [string]$newline) {
    return [regex]::Replace($text, '\r\n|\r|\n', $newline)
}

function Shift-Headings([string]$text) {
    return [regex]::Replace(
        $text,
        '(?m)^(#{1,5})(?=\s)',
        { param($m) '#' + $m.Groups[1].Value }
    )
}

$target = [IO.File]::ReadAllText($targetPath, $utf8)
$newline = if ($target.Contains("`r`n")) { "`r`n" } else { "`n" }

$fraunhofer = (Normalize-Newlines (Get-Body 'Fraunhofer衍射') $newline).Trim()
$fresnel = (Normalize-Newlines (Get-Body 'Fresnel衍射') $newline).Trim()
$grating = (Normalize-Newlines (Get-Body '光栅衍射') $newline).Trim()

$intensityHeading = [regex]'(?m)^## 衍射光强分布\r?$'
$fraunhofer = $intensityHeading.Replace($fraunhofer, '## 矩形孔衍射光强分布', 1)
$fraunhofer = $intensityHeading.Replace($fraunhofer, '## 圆孔衍射光强分布', 1)
$fraunhofer = $fraunhofer.Replace('## 图样特性', '## 单缝衍射图样特性')
$fraunhofer = $fraunhofer.Replace('### 图样特性', '### 多缝衍射图样特性')
$fresnel = $fresnel.Replace('[[光的衍射#Fresnel近似]]]', '前面Fresnel近似')
$grating = $grating.Replace(
    '[[Fraunhofer衍射#Fraunhofer多缝衍射#极值]]',
    '[[光的衍射#极值|Fraunhofer多缝衍射中极值]]'
)

$fraunhofer = Shift-Headings $fraunhofer
$fresnel = Shift-Headings $fresnel
$grating = Shift-Headings $grating

$mergedTail = @(
    '# Fraunhofer衍射'
    $fraunhofer
    '# Fresnel衍射'
    $fresnel
    '# 光栅衍射'
    $grating
) -join ($newline + $newline)

if ($target -notmatch '(?ms)\[\[Fraunhofer衍射\]\]\r?\n\[\[Fresnel衍射\]\]\r?\n\[\[光栅衍射\]\]\s*\z') {
    throw '目标笔记末尾的三个合并入口与预期不符。'
}
$target = [regex]::Replace(
    $target,
    '(?ms)\[\[Fraunhofer衍射\]\]\r?\n\[\[Fresnel衍射\]\]\r?\n\[\[光栅衍射\]\]\s*\z',
    $mergedTail + $newline
)

$aliasBlock = @(
    'aliases:'
    '  - 光衍射'
    '  - Fraunhofer衍射'
    '  - 夫琅禾费衍射'
    '  - Fresnel衍射'
    '  - 菲涅耳衍射'
    '  - 光栅衍射'
) -join $newline
$target = [regex]::Replace(
    $target,
    '(?m)^aliases:\r?\n(?:  - [^\r\n]*\r?\n)*',
    $aliasBlock + $newline
)
$target = [regex]::Replace($target, '(?m)^updated:.*$', 'updated: 2026-10-13')
[IO.File]::WriteAllText($targetPath, $target, $utf8)

$changed = [Collections.Generic.List[string]]::new()
$changed.Add('光的衍射.md')

foreach ($file in Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md') {
    if ($sourceNames -contains $file.BaseName) {
        continue
    }
    $text = [IO.File]::ReadAllText($file.FullName, $utf8)
    $newText = $text

    foreach ($oldTitle in $sourceNames) {
        $escaped = [regex]::Escape($oldTitle)
        $newText = [regex]::Replace(
            $newText,
            "\[\[${escaped}#(?<anchor>[^\]|]+)(?<display>\|[^\]]+)?\]\]",
            { param($m) '[[光的衍射#' + $m.Groups['anchor'].Value + $m.Groups['display'].Value + ']]' }
        )
        $newText = $newText.Replace(
            "[[$oldTitle]]",
            "[[光的衍射#$oldTitle|$oldTitle]]"
        )
    }

    if ($newText -cne $text) {
        $newText = [regex]::Replace($newText, '(?m)^updated:.*$', 'updated: 2026-10-13')
        [IO.File]::WriteAllText($file.FullName, $newText, $utf8)
        $relative = [IO.Path]::GetRelativePath($root, $file.FullName)
        if (-not $changed.Contains($relative)) {
            $changed.Add($relative)
        }
    }
}

"Merged diffraction notes and updated links in $($changed.Count) files."
$changed | Sort-Object
