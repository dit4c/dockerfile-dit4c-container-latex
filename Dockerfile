# Dockerfile for Gephi graph image manipulation software
FROM dit4c/dit4c-container-x11
MAINTAINER Tim Dettrick <t.dettrick@uq.edu.au> and Lachlan \
    Musicman <datakid@gmail.com>

RUN fsudo yum install -y \
    texlive-collection-latex \
    texlive-collection-latexrecommended \
    texlive-latex \
    texlive-latex-bin \
    texlive-latex-bin-bin \
    texlive-latex-doc \
    texlive-latex-fonts \
    texlive-latex-fonts-doc \
    texlive-latexconfig \
    texlive-lualatex-math \
    texlive-lualatex-math-doc \ 
    texlive-pslatex \
    texlive-thailatex \ 
    texlive-thailatex-doc 

RUN fsudo yum localinstall -y \
    "http://download.opensuse.org/repositories/home:/jsundermeyer/CentOS_CentOS-7/x86_64/texstudio-2.10.4-13.1.x86_64.rpm" 
    
RUN cd /tmp/ && \
    curl -L -s -o texstudio.desktop "http://sourceforge.net/p/texstudio/hg/ci/default/tree/utilities/texstudio.desktop?format=raw" && \
    mv texstudio.desktop /usr/share/applications && \
    curl -L -s -o texstudio48x48.png "http://sourceforge.net/p/texstudio/hg/ci/default/tree/utilities/texstudio48x48.png?format=raw" && \
    mv texstudio48x48.png /usr/share/icons/gnome/48x48/apps/

RUN sed -i "s|^Icon=.*|Icon=/usr/share/icons/gnome/48x48/apps/texstudio48x48.png|" /usr/share/applications/texstudio.desktop

RUN LNUM=$(sed -n '/launcher_item_app/=' /etc/tint2/panel.tint2rc | head -1) && \
  sed -i "${LNUM}ilauncher_item_app = /usr/share/applications/texstudio.desktop" /etc/tint2/panel.tint2rc