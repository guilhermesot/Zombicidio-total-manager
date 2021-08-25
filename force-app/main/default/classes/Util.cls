public with sharing class Util {
    public Util() {}

    public static SObject GetRandomIten(List<SObject> lst)
    {
        return lst.get(Math.mod(Integer.valueof(Math.random()*10000000),lst.size()));
    }

}
