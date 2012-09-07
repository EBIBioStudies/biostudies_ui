//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2012.02.29 at 03:34:24 PM GMT 
//


package uk.ac.ebi.xml.jaxb;

import java.math.BigInteger;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the uk.ac.ebi.xml.jaxb package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Bioassaydatacubes_QNAME = new QName("", "bioassaydatacubes");
    private final static QName _Count_QNAME = new QName("", "count");
    private final static QName _Issue_QNAME = new QName("", "issue");
    private final static QName _Releasedate_QNAME = new QName("", "releasedate");
    private final static QName _Contact_QNAME = new QName("", "contact");
    private final static QName _Id_QNAME = new QName("", "id");
    private final static QName _Authors_QNAME = new QName("", "authors");
    private final static QName _Title_QNAME = new QName("", "title");
    private final static QName _Submissiondate_QNAME = new QName("", "submissiondate");
    private final static QName _LegacyId_QNAME = new QName("", "legacy_id");
    private final static QName _Measuredbioassaydatascore_QNAME = new QName("", "measuredbioassaydatascore");
    private final static QName _Experimenttype_QNAME = new QName("", "experimenttype");
    private final static QName _Seqdatauri_QNAME = new QName("", "seqdatauri");
    private final static QName _Name_QNAME = new QName("", "name");
    private final static QName _Protocolscore_QNAME = new QName("", "protocolscore");
    private final static QName _Value_QNAME = new QName("", "value");
    private final static QName _Role_QNAME = new QName("", "role");
    private final static QName _Year_QNAME = new QName("", "year");
    private final static QName _Derivedbioassaydatascore_QNAME = new QName("", "derivedbioassaydatascore");
    private final static QName _Species_QNAME = new QName("", "species");
    private final static QName _Reportersequencescore_QNAME = new QName("", "reportersequencescore");
    private final static QName _Status_QNAME = new QName("", "status");
    private final static QName _Pages_QNAME = new QName("", "pages");
    private final static QName _Loaddate_QNAME = new QName("", "loaddate");
    private final static QName _Bioassays_QNAME = new QName("", "bioassays");
    private final static QName _Overallscore_QNAME = new QName("", "overallscore");
    private final static QName _Factorvaluescore_QNAME = new QName("", "factorvaluescore");
    private final static QName _Experimentdesign_QNAME = new QName("", "experimentdesign");
    private final static QName _Uri_QNAME = new QName("", "uri");
    private final static QName _Assays_QNAME = new QName("", "assays");
    private final static QName _Samples_QNAME = new QName("", "samples");
    private final static QName _Publication_QNAME = new QName("", "publication");
    private final static QName _Lastupdatedate_QNAME = new QName("", "lastupdatedate");
    private final static QName _Category_QNAME = new QName("", "category");
    private final static QName _Experimentdesignscore_QNAME = new QName("", "experimentdesignscore");
    private final static QName _Isderived_QNAME = new QName("", "isderived");
    private final static QName _Secondaryaccession_QNAME = new QName("", "secondaryaccession");
    private final static QName _Email_QNAME = new QName("", "email");
    private final static QName _Volume_QNAME = new QName("", "volume");
    private final static QName _Accession_QNAME = new QName("", "accession");
    private final static QName _Dataformat_QNAME = new QName("", "dataformat");
    private final static QName _Doi_QNAME = new QName("", "doi");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: uk.ac.ebi.xml.jaxb
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link All }
     * 
     */
    public All createAll() {
        return new All();
    }

    /**
     * Create an instance of {@link Sampleattribute }
     * 
     */
    public Sampleattribute createSampleattribute() {
        return new Sampleattribute();
    }

    /**
     * Create an instance of {@link Experimentalfactor }
     * 
     */
    public Experimentalfactor createExperimentalfactor() {
        return new Experimentalfactor();
    }

    /**
     * Create an instance of {@link Text }
     * 
     */
    public Text createText() {
        return new Text();
    }

    /**
     * Create an instance of {@link Arraydesign }
     * 
     */
    public Arraydesign createArraydesign() {
        return new Arraydesign();
    }

    /**
     * Create an instance of {@link Source }
     * 
     */
    public Source createSource() {
        return new Source();
    }

    /**
     * Create an instance of {@link Rawdatafiles }
     * 
     */
    public Rawdatafiles createRawdatafiles() {
        return new Rawdatafiles();
    }

    /**
     * Create an instance of {@link Minseqescores }
     * 
     */
    public Minseqescores createMinseqescores() {
        return new Minseqescores();
    }

    /**
     * Create an instance of {@link Fgemdatafiles }
     * 
     */
    public Fgemdatafiles createFgemdatafiles() {
        return new Fgemdatafiles();
    }

    /**
     * Create an instance of {@link Arraydesignprovider }
     * 
     */
    public Arraydesignprovider createArraydesignprovider() {
        return new Arraydesignprovider();
    }

    /**
     * Create an instance of {@link Bioassaydatagroup }
     * 
     */
    public Bioassaydatagroup createBioassaydatagroup() {
        return new Bioassaydatagroup();
    }

    /**
     * Create an instance of {@link Miamescores }
     * 
     */
    public Miamescores createMiamescores() {
        return new Miamescores();
    }

    /**
     * Create an instance of {@link Br }
     * 
     */
    public Br createBr() {
        return new Br();
    }

    /**
     * Create an instance of {@link Bibliography }
     * 
     */
    public Bibliography createBibliography() {
        return new Bibliography();
    }

    /**
     * Create an instance of {@link File }
     * 
     */
    public File createFile() {
        return new File();
    }

    /**
     * Create an instance of {@link Experiments }
     * 
     */
    public Experiments createExperiments() {
        return new Experiments();
    }

    /**
     * Create an instance of {@link User }
     * 
     */
    public User createUser() {
        return new User();
    }

    /**
     * Create an instance of {@link Provider }
     * 
     */
    public Provider createProvider() {
        return new Provider();
    }

    /**
     * Create an instance of {@link Protocol }
     * 
     */
    public Protocol createProtocol() {
        return new Protocol();
    }

    /**
     * Create an instance of {@link Experiment }
     * 
     */
    public Experiment createExperiment() {
        return new Experiment();
    }

    /**
     * Create an instance of {@link Description }
     * 
     */
    public Description createDescription() {
        return new Description();
    }

    /**
     * Create an instance of {@link Folder }
     * 
     */
    public Folder createFolder() {
        return new Folder();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "bioassaydatacubes")
    public JAXBElement<BigInteger> createBioassaydatacubes(BigInteger value) {
        return new JAXBElement<BigInteger>(_Bioassaydatacubes_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "count")
    public JAXBElement<BigInteger> createCount(BigInteger value) {
        return new JAXBElement<BigInteger>(_Count_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "issue")
    public JAXBElement<BigInteger> createIssue(BigInteger value) {
        return new JAXBElement<BigInteger>(_Issue_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link XMLGregorianCalendar }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "releasedate")
    public JAXBElement<XMLGregorianCalendar> createReleasedate(XMLGregorianCalendar value) {
        return new JAXBElement<XMLGregorianCalendar>(_Releasedate_QNAME, XMLGregorianCalendar.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "contact")
    public JAXBElement<String> createContact(String value) {
        return new JAXBElement<String>(_Contact_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "id")
    public JAXBElement<String> createId(String value) {
        return new JAXBElement<String>(_Id_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "authors")
    public JAXBElement<String> createAuthors(String value) {
        return new JAXBElement<String>(_Authors_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "title")
    public JAXBElement<String> createTitle(String value) {
        return new JAXBElement<String>(_Title_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link XMLGregorianCalendar }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "submissiondate")
    public JAXBElement<XMLGregorianCalendar> createSubmissiondate(XMLGregorianCalendar value) {
        return new JAXBElement<XMLGregorianCalendar>(_Submissiondate_QNAME, XMLGregorianCalendar.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "legacy_id")
    public JAXBElement<BigInteger> createLegacyId(BigInteger value) {
        return new JAXBElement<BigInteger>(_LegacyId_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "measuredbioassaydatascore")
    public JAXBElement<BigInteger> createMeasuredbioassaydatascore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Measuredbioassaydatascore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "experimenttype")
    public JAXBElement<String> createExperimenttype(String value) {
        return new JAXBElement<String>(_Experimenttype_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "seqdatauri")
    public JAXBElement<String> createSeqdatauri(String value) {
        return new JAXBElement<String>(_Seqdatauri_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "name")
    public JAXBElement<String> createName(String value) {
        return new JAXBElement<String>(_Name_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "protocolscore")
    public JAXBElement<BigInteger> createProtocolscore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Protocolscore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "value")
    public JAXBElement<String> createValue(String value) {
        return new JAXBElement<String>(_Value_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "role")
    public JAXBElement<String> createRole(String value) {
        return new JAXBElement<String>(_Role_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "year")
    public JAXBElement<BigInteger> createYear(BigInteger value) {
        return new JAXBElement<BigInteger>(_Year_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "derivedbioassaydatascore")
    public JAXBElement<BigInteger> createDerivedbioassaydatascore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Derivedbioassaydatascore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "species")
    public JAXBElement<String> createSpecies(String value) {
        return new JAXBElement<String>(_Species_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "reportersequencescore")
    public JAXBElement<BigInteger> createReportersequencescore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Reportersequencescore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "status")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    public JAXBElement<String> createStatus(String value) {
        return new JAXBElement<String>(_Status_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "pages")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    public JAXBElement<String> createPages(String value) {
        return new JAXBElement<String>(_Pages_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link XMLGregorianCalendar }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "loaddate")
    public JAXBElement<XMLGregorianCalendar> createLoaddate(XMLGregorianCalendar value) {
        return new JAXBElement<XMLGregorianCalendar>(_Loaddate_QNAME, XMLGregorianCalendar.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "bioassays")
    public JAXBElement<BigInteger> createBioassays(BigInteger value) {
        return new JAXBElement<BigInteger>(_Bioassays_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "overallscore")
    public JAXBElement<BigInteger> createOverallscore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Overallscore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "factorvaluescore")
    public JAXBElement<BigInteger> createFactorvaluescore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Factorvaluescore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "experimentdesign")
    public JAXBElement<String> createExperimentdesign(String value) {
        return new JAXBElement<String>(_Experimentdesign_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "uri")
    public JAXBElement<String> createUri(String value) {
        return new JAXBElement<String>(_Uri_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "assays")
    public JAXBElement<BigInteger> createAssays(BigInteger value) {
        return new JAXBElement<BigInteger>(_Assays_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "samples")
    public JAXBElement<BigInteger> createSamples(BigInteger value) {
        return new JAXBElement<BigInteger>(_Samples_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "publication")
    public JAXBElement<String> createPublication(String value) {
        return new JAXBElement<String>(_Publication_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link XMLGregorianCalendar }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "lastupdatedate")
    public JAXBElement<XMLGregorianCalendar> createLastupdatedate(XMLGregorianCalendar value) {
        return new JAXBElement<XMLGregorianCalendar>(_Lastupdatedate_QNAME, XMLGregorianCalendar.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "category")
    public JAXBElement<String> createCategory(String value) {
        return new JAXBElement<String>(_Category_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "experimentdesignscore")
    public JAXBElement<BigInteger> createExperimentdesignscore(BigInteger value) {
        return new JAXBElement<BigInteger>(_Experimentdesignscore_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "isderived")
    public JAXBElement<BigInteger> createIsderived(BigInteger value) {
        return new JAXBElement<BigInteger>(_Isderived_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "secondaryaccession")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    public JAXBElement<String> createSecondaryaccession(String value) {
        return new JAXBElement<String>(_Secondaryaccession_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "email")
    public JAXBElement<String> createEmail(String value) {
        return new JAXBElement<String>(_Email_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link BigInteger }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "volume")
    public JAXBElement<BigInteger> createVolume(BigInteger value) {
        return new JAXBElement<BigInteger>(_Volume_QNAME, BigInteger.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "accession")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    public JAXBElement<String> createAccession(String value) {
        return new JAXBElement<String>(_Accession_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "dataformat")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    public JAXBElement<String> createDataformat(String value) {
        return new JAXBElement<String>(_Dataformat_QNAME, String.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "doi")
    public JAXBElement<String> createDoi(String value) {
        return new JAXBElement<String>(_Doi_QNAME, String.class, null, value);
    }

}