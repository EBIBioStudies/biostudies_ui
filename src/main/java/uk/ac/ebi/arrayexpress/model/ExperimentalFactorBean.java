package uk.ac.ebi.arrayexpress.model;

import java.util.List;

public class ExperimentalFactorBean
{
    private String name;
    private List<String> value;

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public List<String> getValue()
    {
        return value;
    }

    public void setValue(List<String> value)
    {
        this.value = value;
    }
}
