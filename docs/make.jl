using AirBorne
using AirBorne.ETL
using AirBorne.ETL.YFinance
using Documenter

DocMeta.setdocmeta!(AirBorne, :DocTestSetup, :(using AirBorne); recursive=true)
Documenter.Writers.HTMLWriter.HTML(collapselevel=1)

makedocs(;
    modules=[AirBorne],
    authors="brunocastroibarburu94 <brunocastroibarburu@gmail.com> and contributors",
    repo="https://github.com/JuDO-dev/Airborne.jl/blob/{commit}{path}#{line}",
    sitename="AirBorne.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuDO-dev.github.io/AirBorne.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "High Level Design" => [
            "Glossary" =>"./pages/highLevelDesign.md",
            "Data Pipeline" => "./pages/etl/etl.md"
            ],
        "Autodocs" => "./pages/autodocs.md",
    ]
)

deploydocs(;
    repo="github.com/JuDO-dev/AirBorne.jl",
    devbranch="dev",
)
