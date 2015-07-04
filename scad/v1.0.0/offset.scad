// https://github.com/openscad/openscad/issues/483#issuecomment-35913453
module offset(d=1) {
    module inverse() {
        render() difference() {
            square(1e5,center=true);
            children();
        }
    }
    if (d >= 0) {
        minkowski() {
            circle(r=d);
            children();
        }
    } else {
        inverse() offset(d=-d) inverse() children();
    }
}
