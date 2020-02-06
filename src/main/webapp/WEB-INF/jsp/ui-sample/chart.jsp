<%--
  Created by Hong Nguyen
  Date: 17/01/2020
  Sample for chartjs plugin
--%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="page-content container-fluid">
    <div class="row">
        <div class="col-lg-6">
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Group Code
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnAddGroupClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnDelGroupClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <canvas id="canvas"></canvas>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="panel">
                <div class="panel-heading pdt-8">
                    <h5 class="panel-title">
                        <i class="fa fa-chevron-circle-right"></i>Group Code
                    </h5>
                    <div class="panel-actions">
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnAddGroupClick()"><i class="icon fa fa-plus" aria-hidden="true"></i></button>
                        <button type="button" class="btn btn-icon btn-danger btn-sm" onclick="btnDelGroupClick()"><i class="icon fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
                <div class="panel-body">
                    <canvas id="chart-area"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var _seed = Date.now();
    window.chartColors = {
        red: 'rgb(255, 99, 132)',
        orange: 'rgb(255, 159, 64)',
        yellow: 'rgb(255, 205, 86)',
        green: 'rgb(75, 192, 192)',
        blue: 'rgb(54, 162, 235)',
        purple: 'rgb(153, 102, 255)',
        grey: 'rgb(201, 203, 207)'
    };
    var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    var color = Chart.helpers.color;
    var barChartData = {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [{
            label: 'Dataset 1',
            backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
            borderColor: window.chartColors.red,
            borderWidth: 1,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }, {
            label: 'Dataset 2',
            backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
            borderColor: window.chartColors.blue,
            borderWidth: 1,
            data: [
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor(),
                randomScalingFactor()
            ]
        }]

    };

    var config = {
        type: 'pie',
        data: {
            datasets: [{
                data: [
                    Math.abs(randomScalingFactor()),
                    Math.abs(randomScalingFactor()),
                    Math.abs(randomScalingFactor()),
                    Math.abs(randomScalingFactor()),
                    Math.abs(randomScalingFactor()),
                ],
                backgroundColor: [
                    window.chartColors.red,
                    window.chartColors.orange,
                    window.chartColors.yellow,
                    window.chartColors.green,
                    window.chartColors.blue,
                ],
                label: 'Dataset 1'
            }],
            labels: [
                'Red',
                'Orange',
                'Yellow',
                'Green',
                'Blue'
            ]
        },
        options: {
            responsive: true
        }
    };
    function documentReady() {
        var ctx = document.getElementById('canvas').getContext('2d');
        window.myBar = new Chart(ctx, {
            type: 'bar',
            data: barChartData,
            options: {
                responsive: true,
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Chart.js Bar Chart'
                }
            }
        });

        var ctxpie = document.getElementById('chart-area').getContext('2d');
        window.myPie = new Chart(ctxpie, config);
    }
    function randomizeData() {
        var zero = Math.random() < 0.2 ? true : false;
        barChartData.datasets.forEach(function(dataset) {
            dataset.data = dataset.data.map(function() {
                return zero ? 0.0 : randomScalingFactor();
            });

        });
        window.myBar.update();
    }

    function addDataset() {
        var colorName = colorNames[barChartData.datasets.length % colorNames.length];
        var dsColor = window.chartColors[colorName];
        var newDataset = {
            label: 'Dataset ' + (barChartData.datasets.length + 1),
            backgroundColor: color(dsColor).alpha(0.5).rgbString(),
            borderColor: dsColor,
            borderWidth: 1,
            data: []
        };

        for (var index = 0; index < barChartData.labels.length; ++index) {
            newDataset.data.push(randomScalingFactor());
        }

        barChartData.datasets.push(newDataset);
        window.myBar.update();
    }

    function randomScalingFactor() {
        return Math.round(rand(-100, 100));
    }
    function rand(min, max) {
        var seed = this._seed;
        min = min === undefined ? 0 : min;
        max = max === undefined ? 1 : max;
        this._seed = (seed * 9301 + 49297) % 233280;
        return min + (this._seed / 233280) * (max - min);
    }
</script>