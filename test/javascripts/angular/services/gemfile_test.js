describe("Rubygems", function() {
  var ROOT, httpBackend, rubygems;
  ROOT = "https://rubygems.org/api/v1";
  beforeEach(module('app'));
  httpBackend = rubygems = null;
  beforeEach(inject(function($httpBackend, Rubygems) {
    rubygems = Rubygems;
    return httpBackend = $httpBackend;
  }));
  afterEach(function() {
    httpBackend.verifyNoOutstandingExpectation();
    return httpBackend.verifyNoOutstandingRequest();
  });
  return describe("search", function() {
    return it("should return a list of gems", function() {
      httpBackend.when('GET', "" + ROOT + "/search.json?query=rails").respond([]);
      rubygems.search("rails").then(function(data) {
        return expect(data).toEqual([]);
      });
      return httpBackend.flush();
    });
  });
});
