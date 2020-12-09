screws = [[-15,0], [15,0]];
plug_radius = 7.5;

module inner(screws = screws, plug_radius = plug_radius) {
    
}

module outer(screws = screws, plug_radius = plug_radius) {
    for (screw = screws) {
        echo(screw);
    }
}

module mould(crews = screws, plug_radius = plug_radius) {
}

outer();