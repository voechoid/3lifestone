
/**
 * Created with IntelliJ IDEA.
 * User: bruce_lin_chn
 * Date: 12-9-5
 * Time: 下午9:27
 * To change this template use File | Settings | File Templates.
 */
def list=["green", "yellow", "white","white"].unique()
println list
println list.contains("white")
println list.join(",").contains("white")

list.each
{s->
    s = s.capitalize()

    println s
}

println list