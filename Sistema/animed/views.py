from django.shortcuts import render
from django.views.generic import ListView, DetailView
from .models import Cliente
from .models import Veterinario
from .models import Fornecedor

class ClienteList(ListView):
    model = Cliente
    template_name = 'cliente_list.html'
    context_object_name = 'clientes'

class ClienteDetail(DetailView):
    model = Cliente
    template_name = 'cliente_detail.html'
    context_object_name = 'cliente'
    
    
class VeterinarioListView(ListView):
    model = Veterinario
    template_name = 'veterinarios.html'
    context_object_name = 'veterinarios'
    
    
class FornecedorListView(ListView):
    model = Fornecedor
    template_name = 'fornecedor_list.html'
    context_object_name = 'fornecedores'

