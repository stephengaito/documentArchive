
// Goal: Browse available Languages

// Story: User starts diSimpExplorer and is presented with the current 
// list of languages.
//
describe("Start diSimpExplore", function() {
  it("presents the current list of languages", function() {
    //
    // there should be some language elements
    //
    expect($('div.languages').size()).not.toEqual(0); 
  });
});
