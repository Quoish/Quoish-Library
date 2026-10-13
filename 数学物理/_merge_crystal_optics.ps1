$ErrorActionPreference = 'Stop'

$sourceFiles = @(
    '光在各向异性介质中传播.md',
    '光在各向异性介质界面传播.md',
    '晶体的偏光干涉.md'
)
$targetFile = '光在晶体中传播.md'

function Get-NoteBody([string]$path) {
    $text = Get-Content -LiteralPath $path -Raw
    return [regex]::Replace($text, '\A---\r?\n.*?\r?\n---\r?\n?', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
}

function Lower-HeadingLevel([string]$text) {
    return [regex]::Replace($text, '(?m)^(#{1,5})(?= )', { param($m) '#' + $m.Value })
}

$sections = foreach ($sourceFile in $sourceFiles) {
    $sectionTitle = [System.IO.Path]::GetFileNameWithoutExtension($sourceFile)
    $body = Lower-HeadingLevel (Get-NoteBody $sourceFile)
    "# $sectionTitle`r`n$($body.TrimEnd())"
}

$frontmatter = @'
---
title: 光在晶体中传播
aliases:
  - 光在各向异性介质中传播
  - 光在各向异性介质界面传播
  - 晶体的偏光干涉
  - 晶体偏光干涉
tags:
  - 光学
  - 固体物理
category:
  - 电磁学与光学
status: 完成
created: 2025-11-16
updated: 2026-10-13
---
'@

$merged = $frontmatter.TrimEnd() + "`r`n" + ($sections -join "`r`n`r`n") + "`r`n"
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $targetFile), $merged, [System.Text.UTF8Encoding]::new($false))

$navigationFile = '导航\电磁学与光学.md'
$navigation = Get-Content -LiteralPath $navigationFile -Raw
$navigation = $navigation.Replace("[[光在各向异性介质中传播]]`r`n[[光在各向异性介质界面传播]]`r`n[[晶体光学元件]]`r`n[[晶体的偏光干涉]]", "[[光在晶体中传播]]`r`n[[晶体光学元件]]")
$navigation = $navigation.Replace("[[光在各向异性介质中传播]]`n[[光在各向异性介质界面传播]]`n[[晶体光学元件]]`n[[晶体的偏光干涉]]", "[[光在晶体中传播]]`n[[晶体光学元件]]")
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $navigationFile), $navigation, [System.Text.UTF8Encoding]::new($false))

$oldTitles = @(
    '光在各向异性介质中传播',
    '光在各向异性介质界面传播',
    '晶体的偏光干涉'
)

$markdownFiles = Get-ChildItem -LiteralPath . -Filter '*.md' -File -Recurse | Where-Object {
    $_.Name -notin $sourceFiles -and $_.Name -ne $targetFile -and $_.FullName -ne (Join-Path (Get-Location) $navigationFile)
}

foreach ($file in $markdownFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw
    $updated = $text
    foreach ($oldTitle in $oldTitles) {
        $pattern = '\[\[' + [regex]::Escape($oldTitle) + '(?<anchor>#[^\]|]+)?(?<label>\|[^\]]+)?\]\]'
        $updated = [regex]::Replace($updated, $pattern, {
            param($match)
            $anchor = $match.Groups['anchor'].Value
            $label = $match.Groups['label'].Value
            if ([string]::IsNullOrEmpty($anchor)) {
                return '[[光在晶体中传播#' + $oldTitle + '|' + $oldTitle + ']]'
            }
            return '[[光在晶体中传播' + $anchor + $label + ']]'
        })
    }
    if ($updated -ne $text) {
        [System.IO.File]::WriteAllText($file.FullName, $updated, [System.Text.UTF8Encoding]::new($false))
    }
}

# Update cross-references inside the merged body after all source text has been combined.
$targetText = Get-Content -LiteralPath $targetFile -Raw
foreach ($oldTitle in $oldTitles) {
    $pattern = '\[\[' + [regex]::Escape($oldTitle) + '(?<anchor>#[^\]|]+)?(?<label>\|[^\]]+)?\]\]'
    $targetText = [regex]::Replace($targetText, $pattern, {
        param($match)
        $anchor = $match.Groups['anchor'].Value
        $label = $match.Groups['label'].Value
        if ([string]::IsNullOrEmpty($anchor)) {
            return '[[光在晶体中传播#' + $oldTitle + '|' + $oldTitle + ']]'
        }
        return '[[光在晶体中传播' + $anchor + $label + ']]'
    })
}
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $targetFile), $targetText, [System.Text.UTF8Encoding]::new($false))
