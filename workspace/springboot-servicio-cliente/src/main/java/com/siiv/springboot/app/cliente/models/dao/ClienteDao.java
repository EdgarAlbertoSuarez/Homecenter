package com.siiv.springboot.app.cliente.models.dao;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.siiv.springboot.app.cliente.models.entity.Cliente;

@RepositoryRestResource(path="clientes")
public interface ClienteDao extends PagingAndSortingRepository<Cliente, Long> {
	public Cliente findByPrimerNombre(String primernombre);
}
