Literate Programming
================
Tawane Nunes
2022-08-10

The Rmarkdown can be used to write scientific documents. One of its
features is to citate literature from *.bib* files. To do this its
necessary to have the .bib file containing your references and a *.csl*
file that contains the citation format.

Than you add in the YAML header the following information:

**bibliography:** ../filepath/literature-file.bib

**csl:** ../filepath/citation-style-file.csl

Than to cite in the text you use \_\_(**\_\_?**) and the format used by
the reference manager that you used to creat the *.bib* file, as:

Citing (**name_word_date?**) or (**namedate?**)

And the result shoul look like: Zuur, Ieno, & Elphick (2010)

## References

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-zuur_protocol_2010" class="csl-entry">

Zuur, A. F., Ieno, E. N., & Elphick, C. S. (2010). A protocol for data
exploration to avoid common statistical problems. *Methods in Ecology
and Evolution*, *1*(1), 3–14. doi: [cw57t3](https://doi.org/cw57t3)

</div>

</div>
