rule all:
    input:
        "test_60min",
        "test_200min"

rule test_short_time:
    params:
        test1="test1"
    output:
        "test_60min"
    resources:
        mem=1000,
        time=60
    shell: """
        sleep 3600
        touch {output}
        """

rule test_long_time:
    params:
        test2="test2"
    output:
        "test_200min"
    resources:
        mem=1000,
        time=400
    shell: """
        sleep 12000
        touch  {output}
        """