d3.csv("LimitedData.csv").then(function(data) {
    console.log("Hello");
    console.log(data);

    var FilteredData = data.filter(function(d){  if (d.department == "produce") {return d.product_name}  })
        console.log(FilteredData);
});
