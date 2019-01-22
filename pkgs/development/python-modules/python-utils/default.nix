{ lib, buildPythonPackage, fetchPypi, pytest, pytestrunner, pytestcov, pytestflakes, pytestpep8, sphinx, six }:

buildPythonPackage rec {
  pname = "python-utils";
  version = "2.3.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "34aaf26b39b0b86628008f2ae0ac001b30e7986a8d303b61e1357dfcdad4f6d3";
  };

  checkInputs = [ pytest pytestrunner pytestcov pytestflakes pytestpep8 sphinx ];

  postPatch = ''
    # pytest-runner is only actually required in checkPhase
    substituteInPlace setup.py --replace "setup_requires=['pytest-runner']," ""
  '';

  # Tests failing
  doCheck = false;

  checkPhase = ''
    py.test
  '';

  propagatedBuildInputs = [ six ];

  meta = with lib; {
    description = "Module with some convenient utilities";
    homepage = "https://github.com/WoLpH/python-utils";
    license = licenses.bsd3;
  };
}
