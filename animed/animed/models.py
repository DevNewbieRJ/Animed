from django.db import models


class Veterinario(models.Model):
    nome = models.CharField(max_length=100)
    crmv = models.CharField(max_length=50)
    telefone = models.CharField(max_length=20)
    email = models.EmailField(max_length=254)
    endereco = models.CharField(max_length=200)
    
    def __str__(self):
        return self.nome


class Cliente(models.Model):
    nome = models.CharField(max_length=100)
    telefone = models.CharField(max_length=20)
    email = models.EmailField(max_length=254)
    endereco = models.CharField(max_length=200)
    
    def __str__(self):
        return self.nome


class Animal(models.Model):
    nome = models.CharField(max_length=100)
    especie = models.CharField(max_length=100)
    raca = models.CharField(max_length=100)
    data_nascimento = models.DateField()
    cliente = models.ForeignKey(Cliente, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.nome


class Vacina(models.Model):
    nome = models.CharField(max_length=100)
    descricao = models.TextField()
    duracao = models.PositiveIntegerField()
    animal = models.ForeignKey(Animal, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.nome


class AtendimentoClinico(models.Model):
    data_hora = models.DateTimeField()
    veterinario = models.ForeignKey(Veterinario, on_delete=models.CASCADE)
    animal = models.ForeignKey(Animal, on_delete=models.CASCADE)
    descricao = models.TextField()
    valor = models.DecimalField(max_digits=8, decimal_places=2)
    
    def __str__(self):
        return f'{self.data_hora} - {self.veterinario.nome} - {self.animal.nome}'
    
class Fornecedor(models.Model):
    nome = models.CharField(max_length=100)
    email = models.EmailField()
    telefone = models.CharField(max_length=20)
    endereco = models.CharField(max_length=200)

    def __str__(self):
        return self.nome

class Cirurgia(models.Model):
    data_hora = models.DateTimeField()
    veterinario = models.ForeignKey(Veterinario, on_delete=models.CASCADE)
    animal = models.ForeignKey(Animal, on_delete=models.CASCADE)
    descricao = models.TextField()
    valor = models.DecimalField(max_digits=8, decimal_places=2)
    anestesista = models.DecimalField(max_digits=8, decimal_places=2)
    
    def __str__(self):
        return f'{self.data_hora} - {self.veterinario.nome} - {self.animal.nome}'


class Estoque(models.Model):
    item = models.CharField(max_length=100)
    quantidade = models.PositiveIntegerField()
    fornecedor = models.ForeignKey(Fornecedor, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.item


class Fornecedor(models.Model):
    nome = models.CharField(max_length=100)
    telefone = models.CharField(max_length=20)
    email = models.EmailField(max_length=254)
    endereco = models.CharField(max_length=200)
    
    def __str__(self):
        return self.nome


class ContasPagar(models.Model):
    descricao = models.TextField()
    valor = models.DecimalField(max_digits=8, decimal_places=2)
    data_vencimento = models.DateField()
    data_pagamento = models.DateField(null=True, blank=True)
    fornecedor = models.ForeignKey(Fornecedor, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.descricao


class HistoricoClinico(models.Model):
    data_hora = models.DateTimeField()
    animal = models.ForeignKey(Animal, on_delete=models.CASCADE)
    vacina = models.ForeignKey(Vacina, on_delete=models.CASCADE, null=True, blank=True)
    cirurgia = models.ForeignKey(Cirurgia, on_delete=models.CASCADE, null=True, blank=True)
