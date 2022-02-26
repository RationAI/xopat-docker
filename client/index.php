<?php

echo <<<EOF
<html lang="en" dir="ltr">
<head>
<title>Visualisation gateway</title>

<link rel="stylesheet" href="./app/external/primer_css.css">
<link rel="stylesheet" href="./list.css">
<link rel="stylesheet" href="theme.blue.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="./jquery.tablesorter.js"></script>
</head>

<body data-color-mode="auto" data-light-theme="light" data-dark-theme="dark_dimmed" >

<div style="max-width: 1260px;padding: 25px 60px;margin: 0 auto;"> <div class="position-relative">

EOF;


$annotation = ", {data: '/server-data/TP-2019_6785-12-1-annot.tif', shader: {name: 'Annotation Layer', type: 'edge', visible: 1, params: {color: {type: 'color', default: '#12fbff'}, threshold: {type: 'number', default: '1', visible: false}, opacity: {type: 'number', default: '1', visible: false}, edgeThickness: {type: 'range', default: '1', visible: true}}}}";
$probability = ""; //", {data: 'probability.tif', shader: {name: 'Probability Layer', type: 'heatmap', visible: 1, params: {color: {type: 'color', default: '#fff700'}, threshold: {type: 'range', default: '1', min: '1', max: '100', step: '1', helper: {type: 'number', default: '1', min: '1', max: '100', step: '1', alignment: '25'}}, opacity: {type: 'range', default: '1', min: '0', max: '1', step: '0.1'}}}}";
    

echo <<<EOF

    <a style="cursor:pointer;" onclick="go(false,
        'Title', '/server-data/TP-2019_6785-12-1.tif'
        $annotation
        $probability
    );" oncontextmenu="go(true,
        'Title', '/server-data/TP-2019_6785-12-1.tif'
        $annotation
        $probability
    );"
    >Some link</a>
EOF;

echo <<<EOF
<form method="POST" action="./app/index.php"  id="redirect">
   <input type="hidden" name="visualisation" id="visualisation" value=''>
  
</form>
</div></div>
<script>

var user_settings = {
    params: {
    },
    data: [],
    background: [],
    shaderSources: [],
    visualizations: [] 
};


function go(newTab, title, image, ...dataArray) {
    let vis = {name: title, shaders: {}};
    user_settings.data.push(image);
    user_settings.background.push({
        dataReference: 0,
        lossless: false
    });
    let index = 0;
    for (let item of dataArray) {
        item.shader.dataReferences = [user_settings.data.length];
        user_settings.data.push(item.data);
        vis.shaders[index++] = item.shader;
    }
    user_settings.visualizations.push(vis);

    document.getElementById("visualisation").value = JSON.stringify(user_settings);
    if (newTab) {
        document.getElementById("redirect").setAttribute("target", "_blank");
    } else {
        document.getElementById("redirect").removeAttribute("target");
    }
    
    document.getElementById("redirect").submit();
    user_settings = {
        params: {
        },
        data: [],
        background: [],
        shaderSources: [],
        visualizations: [] 
    };
}

function goCustom(title, image, ...dataArray) {
    window.open("app/index.php?image=" + image + "&layer=" + dataArray.join(","), '_blank').focus();
}

$(function() {
	// initial sort set using sortList option
	$(".table").tablesorter({sortReset: true});
});
</script>
EOF;
