# Docker - Guia introdutório
Este repositório contém informações, resumos e exemplos para ajudar a entender conceitos fundamentais do Docker, incluindo contêineres, o que é o Docker, UFS (Union File System), volumes, networks, Dockerfile e Docker Compose.
<hr>

#### Principais conceitos
**Container:** É uma instância em execução de uma imagem, ele fornece um ambiente isolado para a aplicação, garantindo que ela rode da mesma forma em qualquer lugar, ou seja, container é uma tecnologia de virtualização leve usada principalmente para empacotar e isolar aplicativos e suas dependências em um ambiente separado.
Diferentemente de uma máquina virtual, os contêineres compartilham o mesmo kernel do sistema operacional do host, tornando-se mais leves e rápidos.

**Namespaces:** É um recurso do kernel que possibilita criar ambientes isolados para processos, garantindo que cada contêiner tenha sua própria visão do sistema, como PID, rede e sistema de arquivos. Isso permite que diferentes contêineres operem independentemente uns dos outros.

**Cgroups** Os Control Groups (Cgroups) regulam os recursos do sistema (CPU, memória, disco, rede) que cada contêiner pod utilizar. Dessa forma, evitam que um contêiner consuma todos os recursos do host.

* *Observação:* Juntos, os namespaces garantem o isolamento, enquanto os cgroups controlam a alocação de recursos, permitindo que o Docker e outras tecnologias de contêineres operem de forma eficiente e segura.

<p>
    <img src="images/cgroups.png" >
</p>

**Imagem:** Uma imagem é um pacote contendo tudo o que uma aplicação precisa para ser executada, como código-fonte, dependências, bibliotecas e configurações. As imagens são imutáveis e servem como modelo para criar contêineres.

**Registry:** É um repositório onde as imagens são armazenadas e distribuídas. O mais conhecido é o Docker Hub, mas também existem registries privados, como o Amazon ECR e o Google Container Registry.

**Volumes:**

**Redes:**
<hr>

#### Docker