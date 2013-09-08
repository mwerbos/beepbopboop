// .bar for the bar (use fill: color)
// .top for the overlap thingie
// .axis for the axes (use stroke: black)
function visualize() {
  var dataset = {
      "users": [
        {"id": 1, "times": [{"start":(new Date(2001,0,1)), "end":(new Date(2001, 0, 4))}]}, 
        {"id": 2, "times": [{"start":(new Date(2001,0,2)), "end":(new Date(2001, 0, 6))}]},
        {"id": 3, "times": [{"start":(new Date(2001,0,1)), "end":(new Date(2001, 0, 8))}]},
        {"id": 4, "times": [{"start":(new Date(2001,0,9)), "end":(new Date(2001, 0, 12))}]}
        ],
    "times": [{
      "start":(new Date(2001,0,2)),
        "end":(new Date(2001, 0, 4))
        }]};
        
        
  var w = 1000;
    var h = 500;
    var h2 = 600
    
    var minDate = new Date();
    var maxDate = new Date(minDate.getTime() + (1000*60*60*24*7));
    
    var minTime = d3.min(dataset.users, function(user) {
  return d3.min(user.times, function(time) {
    return time.start;
  });
  });
    
  var maxTime = d3.max(dataset.users, function(user) {
      return d3.max(user.times, function(time) {
        return time.end;
      });
    });
    
  var timesScale = d3.time.scale()
    // .domain([minDate, maxDate])
    .domain([minTime, maxTime])
    .range([0,w]);

  var svg = d3.select("#visualization").append("svg")
    .attr("width", w)
    .attr("height", h2);
    
  var rects = svg.selectAll("rect")
            .data(dataset.users)
          .enter()
        .append("rect")
        .attr("class", "bar");

      rects.attr("x", function(d) {
        return timesScale(d.times[0].start);
      })
      .attr("y", function(d, i) {
        return i*(h / dataset.users.length) + (h/dataset.users.length)/4;
      })
      .attr("width", function(d) {
        return timesScale(d.times[0].end) - timesScale(d.times[0].start)
    })
      .attr("height", h / dataset.users.length * 1/2);
      
      
      var ranges = svg.selectAll("circle")
        .data(dataset.times)
        .enter()
        .append("rect")
        .attr("class", "top");
        
      ranges.attr("x", function(d) {
        return timesScale(d.start);
      })
      .attr("y", function(d, i) {
        return 0;
      })
      .attr("width", function(d) {
        return timesScale(d.end) - timesScale(d.start)
    })
      .attr("height", h);
                
      var xAxis = d3.svg.axis()
            .scale(timesScale)
            .orient("bottom")
            .ticks(7)
            .tickSize(5);
            
        svg.append("g")
            .attr("class", "axis")
            .attr("transform", "translate(0," + (h) + ")")
            .call(xAxis);
}
$(document).ready(visualize);