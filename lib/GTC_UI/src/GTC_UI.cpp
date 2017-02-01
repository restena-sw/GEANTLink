﻿/*
    Copyright 2015-2016 Amebis
    Copyright 2016 GÉANT

    This file is part of GÉANTLink.

    GÉANTLink is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GÉANTLink is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
*/

#include "StdAfx.h"


//////////////////////////////////////////////////////////////////////
// wxGTCConfigPanel
//////////////////////////////////////////////////////////////////////

wxGTCConfigPanel::wxGTCConfigPanel(const eap::config_provider &prov, eap::config_method_eapgtc &cfg, wxWindow* parent) : wxPanel(parent)
{
    wxBoxSizer* sb_content;
    sb_content = new wxBoxSizer( wxVERTICAL );

    m_credentials = new wxGTCCredentialsConfigPanel(prov, cfg, this, _("GTC User ID"));
    sb_content->Add(m_credentials, 0, wxEXPAND, 5);

    this->SetSizer(sb_content);
    this->Layout();

    // Connect Events
    this->Connect(wxEVT_INIT_DIALOG, wxInitDialogEventHandler(wxGTCConfigPanel::OnInitDialog));
}


wxGTCConfigPanel::~wxGTCConfigPanel()
{
    // Disconnect Events
    this->Disconnect(wxEVT_INIT_DIALOG, wxInitDialogEventHandler(wxGTCConfigPanel::OnInitDialog));
}


/// \cond internal
void wxGTCConfigPanel::OnInitDialog(wxInitDialogEvent& event)
{
    // Forward the event to child panels.
    if (m_credentials)
        m_credentials->GetEventHandler()->ProcessEvent(event);
}
/// \endcond


//////////////////////////////////////////////////////////////////////
// wxGTCResponsePanel
//////////////////////////////////////////////////////////////////////

wxGTCResponsePanel::wxGTCResponsePanel(const eap::config_provider &prov, eap::config_method_eapgtc &cfg, wxWindow* parent) : wxGTCResponsePanelBase(parent)
{
    UNREFERENCED_PARAMETER(prov);
    UNREFERENCED_PARAMETER(cfg);

    // Load and set icon.
    winstd::library lib_shell32;
    if (lib_shell32.load(_T("shell32.dll"), NULL, LOAD_LIBRARY_AS_DATAFILE | LOAD_LIBRARY_AS_IMAGE_RESOURCE))
        m_response_icon->SetIcon(wxLoadIconFromResource(lib_shell32, MAKEINTRESOURCE(24)));
}