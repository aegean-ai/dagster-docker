from dagster import op, graph

@op
def hello():
    return 1


@op
def goodbye(foo):
    if foo != 1:
        raise Exception("Bad io manager")
    return foo * 2


@graph
def my_graph():
    goodbye(hello())


@op
def my_op(context):
    context.log.info('Hello, Dagster!')
