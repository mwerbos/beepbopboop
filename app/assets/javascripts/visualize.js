// .bar for the bar (use fill: color)
// .top for the overlap thingie
// .axis for the axes (use stroke: black)
function visualize() {
    if (window.gon == undefined)
        return;
        
    if (window.gon.timeData == undefined)
        return;
        
    // console.log(window.gon.timeData)
        
    var dataset = JSON.parse(window.gon.timeData)
    
    // console.log(dataset)
    
    // var dataset = {
        // "users": [
            // {"id": 1, "times": [{"start":(new Date(2001,0,1)), "end":(new Date(2001, 0, 4))}, {"start":(new Date(2001,0,7)), "end":(new Date(2001, 0, 10))}]}, 
            // {"id": 2, "times": [{"start":(new Date(2001,0,2)), "end":(new Date(2001, 0, 6))}]},
            // {"id": 3, "times": [{"start":(new Date(2001,0,1)), "end":(new Date(2001, 0, 8))}]},
            // {"id": 4, "times": [{"start":(new Date(2001,0,9)), "end":(new Date(2001, 0, 12))}]}
        // ],
    // "times": [
        // {"start":(new Date(2001,0,2)),"end":(new Date(2001, 0, 4))},
        // {"start":(new Date(2001,0,7)),"end":(new Date(2001, 0, 8))}
        // ]};
        
    if (dataset.users.length == 0)
        return;
    
    border = 50
    var w = $(window).width() - 50;
    var h = 600;
    var w2 = w - border*2;
    var h2 = h - border*2;

    var minDate = new Date();
    var maxDate = new Date(minDate.getTime() + (1000*60*60*24*7));
    
    var minTime = d3.min(dataset.users, function(user) {
        return d3.min(user.times, function(time) {
            return new Date(time.start);
        });
    });
    
    var maxTime = d3.max(dataset.users, function(user) {
        return d3.max(user.times, function(time) {
            return new Date(time.end);
        });
    });
    
    // console.log(new Date(minTime))
    // console.log(new Date(maxTime))
    
    var timesScale = d3.time.scale()
        // .domain([minDate, maxDate])
        .domain([minTime, maxTime])
        .range([border,w-border]);
        
    // console.log(timesScale(minTime))

    var svg = d3.select("#visualization").append("svg")
        .attr("width", w)
        .attr("height", h);
        
    allSpans = []
        
    dataset.users.forEach(function (user, i) {
        user.times.forEach(function (time) {
            allSpans.push({"span": time, "row": i, "user": user.id})
        });
    });
    
    var rects = svg.selectAll("rect")
        .data(allSpans)
        .enter()
        .append("rect")
        .attr("class", "bar");

    rects.attr("x", function(d) {
        return timesScale(new Date(d.span.start));
    })
    .attr("y", function(d, i) {
        return d.row*(h2 / dataset.users.length) + (h2/dataset.users.length)/4 + border;
    })
    .attr("width", function(d) {
        return timesScale(new Date(d.span.end)) - timesScale(new Date(d.span.start))
    })
    .attr("height", h2 / dataset.users.length * 1/2)
    .style("fill", function(d) {
        if (d.user == window.user)
            return "blue"
        else
            return "#cc0000"
    });
      
      
    var ranges = svg.selectAll()
        .data(dataset.times)
        .enter()
        .append("rect")
        .attr("class", "top");
        
    ranges.attr("x", function(d) {
        return timesScale(new Date(d.start));
    })
    .attr("y", function(d, i) {
        return 0 + border;
    })
    .attr("width", function(d) {
        return timesScale(new Date(d.end)) - timesScale(new Date(d.start))
    })
    .attr("height", h2);
                
    var xAxis = d3.svg.axis()
        .scale(timesScale)
        .orient("bottom")
        .tickSize(5);
            
    svg.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(0," + (h-border) + ")")
        .call(xAxis);
}
