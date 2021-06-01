#!/usr/bin/env sh

if [ "${srcdir}" = "." ]; then
    lsrc=""
else
    lsrc="${srcdir}/"
fi

expected1="<?xml version=\"1.0\"?>
<testsuite name=\"S1\" tests=\"3\" failures=\"1\" errors=\"1\" time=\"\">
  <testcase name=\"Core:test_pass\" time=\"\">
  </testcase>
  <testcase name=\"Core:test_fail\" time=\"\">
    <failure type=\"\" message=\"Failure\">
      Core:test_fail:0
      ex_junit_xml_output.c:14
      Failure
    </failure>
  </testcase>
  <testcase name=\"Core:test_exit\" time=\"\">
    <error type=\"\" message=\"Early exit with return value 1\">
      Core:test_exit:0
      ex_junit_xml_output.c:18
      Early exit with return value 1
    </error>
  </testcase>
  <system-out>
    <![CDATA[]]>
  </system-out>
  <system-err>
    <![CDATA[]]>
  </system-err>
</testsuite>"

expected2="<?xml version=\"1.0\"?>
<testsuite name=\"S2\" tests=\"4\" failures=\"2\" errors=\"0\" time=\"\">
  <testcase name=\"Core:test_pass2\" time=\"\">
  </testcase>
  <testcase name=\"Core:test_loop\" time=\"\">
    <failure type=\"\" message=\"Iteration 0 failed\">
      Core:test_loop:0
      ex_junit_xml_output.c:32
      Iteration 0 failed
    </failure>
  </testcase>
  <testcase name=\"Core:test_loop\" time=\"\">
  </testcase>
  <testcase name=\"Core:test_loop\" time=\"\">
    <failure type=\"\" message=\"Iteration 2 failed\">
      Core:test_loop:2
      ex_junit_xml_output.c:32
      Iteration 2 failed
    </failure>
  </testcase>
  <system-out>
    <![CDATA[]]>
  </system-out>
  <system-err>
    <![CDATA[]]>
  </system-err>
</testsuite>"

./ex_junit_xml_output > /dev/null
actual=`cat test.log.junit-S1.xml | sed 's:time="[^\"]\+":time="":'`
if [ x"${expected1}" != x"${actual}" ]; then
    echo "Problem with ex_junit_xml_output ${3}";
    echo "Difference:";
    diff -u <( echo "${expected1}" ) <( echo "${actual}" );
    exit 1;
fi
actual=`cat test.log.junit-S2.xml | sed 's:time="[^\"]\+":time="":'`
if [ x"${expected2}" != x"${actual}" ]; then
    echo "Problem with ex_junit_xml_output ${3}";
    echo "Difference:";
    diff -u <( echo "${expected2}" ) <( echo "${actual}" );
    exit 1;
fi
    
exit 0
