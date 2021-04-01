
package isdcm.webapp.soapserver.ws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Clase Java para findVideoByTittleRequest complex type.
 * 
 * <p>El siguiente fragmento de esquema especifica el contenido que se espera que haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="findVideoByTittleRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="tittle" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "findVideoByTittleRequest", propOrder = {
    "tittle"
})
public class FindVideoByTittleRequest {

    @XmlElement(required = true)
    protected String tittle;

    /**
     * Obtiene el valor de la propiedad tittle.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTittle() {
        return tittle;
    }

    /**
     * Define el valor de la propiedad tittle.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTittle(String value) {
        this.tittle = value;
    }

}
