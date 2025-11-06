# Projet d’Infrastructure Automatisée avec Terraform et Ansible

Ce projet a pour objectif de déployer et de configurer une infrastructure Windows complète de manière automatisée, reproductible et scalable. L’ensemble du provisioning et de la configuration est réalisé à l’aide de **Terraform** et **Ansible**, garantissant une gestion cohérente et standardisée des ressources.

## Environnement

- **Kagari** : machine Linux Alpine servant de bastion et de poste d’orchestration, avec **Terraform** et **Ansible** installés pour la création et la configuration des ressources.  
- **Client** : machine virtuelle sous **Windows 10**.  
- **DC1** : contrôleur de domaine principal sous **Windows Server 2022**.  
- **DC2** : second contrôleur de domaine sous **Windows Server 2022**, configuré en réplication avec DC1 et hébergeant le rôle **Active Directory Certificate Services (AD CS)**.  
- **Serveur Web** : serveur **Windows Server** configuré avec **IIS (Internet Information Services)**.



## Références

- *Game of Active Directory* – https://github.com/Orange-Cyberdefense/GOAD
- *Application ASPX vulnérable* - https://gist.github.com/stasinopoulos/95ce3d164fec1d477f80ea3675be2021 
