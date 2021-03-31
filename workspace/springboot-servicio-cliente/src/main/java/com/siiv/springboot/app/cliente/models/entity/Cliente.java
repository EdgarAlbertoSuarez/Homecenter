package com.siiv.springboot.app.cliente.models.entity;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "clientes")
public class Cliente implements Serializable {



	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(name = "primer_nombre",length = 255)
	private String primerNombre;
	
	@Column(name = "segundo_nombre",length = 255)
	private String segundoNombre;

	@Column(name = "primer_apellido",length = 255)
	private String primerApellido;
	
	@Column(name = "segundo_apellido",length = 255)
	private String segundoApellido;

	@Column(name = "tipo_de_documento",length = 255)
	private String tipoDeDocumento;
	
	@Column(length = 255)
	private String documento;
	@Column(length = 255)
	
	private String celular;
	@Column(length = 255)
	
	private String direccion;
	
	@Column(name = "correo_electronico", unique = true, length = 100)
	private String correoElectronico;
	
	@Column(name = "valor_maximo_factura")
	private Double valorMmaximoFactura;
	
	@Column(name = "create_at")
	@Temporal(TemporalType.DATE)
	private Date createAt;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPrimerNombre() {
		return primerNombre;
	}

	public void setPrimerNombre(String primerNombre) {
		this.primerNombre = primerNombre;
	}

	public String getSegundoNombre() {
		return segundoNombre;
	}

	public void setSegundoNombre(String segundoNombre) {
		this.segundoNombre = segundoNombre;
	}

	public String getPrimerApellido() {
		return primerApellido;
	}

	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}

	public String getSegundoApellido() {
		return segundoApellido;
	}

	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}

	public String getTipoDeDocumento() {
		return tipoDeDocumento;
	}

	public void setTipoDeDocumento(String tipoDeDocumento) {
		this.tipoDeDocumento = tipoDeDocumento;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getCorreoElectronico() {
		return correoElectronico;
	}

	public void setCorreoElectronico(String correoElectronico) {
		this.correoElectronico = correoElectronico;
	}

	public Double getValorMmaximoFactura() {
		return valorMmaximoFactura;
	}

	public void setValorMmaximoFactura(Double valorMmaximoFactura) {
		this.valorMmaximoFactura = valorMmaximoFactura;
	}

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}
	
	private static final long serialVersionUID = -6943821304738173502L;
	
}
