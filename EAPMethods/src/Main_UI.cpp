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

#include <StdAfx.h>

#pragma comment(lib, "msxml6.lib")

using namespace std;
using namespace winstd;


#if EAPMETHOD_TYPE==21
#define _EAPMETHOD_PEER_UI eap::peer_ttls_ui
#else
#error Unknown EAP Method type.
#endif

HANDLE g_act_ctx = NULL;
_EAPMETHOD_PEER_UI g_peer;


///
/// DLL main entry point
///
/// \sa [DllMain entry point](https://msdn.microsoft.com/en-us/library/windows/desktop/ms682583.aspx)
///
BOOL WINAPI DllMain(_In_ HINSTANCE hinstDLL, _In_ DWORD fdwReason, _In_ LPVOID lpvReserved)
{
    UNREFERENCED_PARAMETER(lpvReserved);

    if (fdwReason == DLL_PROCESS_ATTACH) {
#ifdef _DEBUG
        //Sleep(10000);
#endif
        g_peer.m_instance = hinstDLL;

#if _WIN32_WINNT >= _WIN32_WINNT_VISTA
        // Declare our DllHost process as DPI-aware.
        SetProcessDPIAware();
#endif

        // Save current activation context, as proper activation context is set at this time only (LoadLibrary() call).
        GetCurrentActCtx(&g_act_ctx);
    } else if (fdwReason == DLL_PROCESS_DETACH) {
        if (g_act_ctx)
            ReleaseActCtx(g_act_ctx);

        // wxWidgets library has some global objects allocating data on heap in constructors,
        // causing false-positive memory leak reports.
        //assert(!_CrtDumpMemoryLeaks());
    }

    return TRUE;
}


///
/// Releases all memory associated with an opaque user interface context data buffer.
///
/// \sa [EapPeerFreeMemory function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363606.aspx)
///
VOID WINAPI EapPeerFreeMemory(_In_ void *pUIContextData)
{
    event_fn_auto event_auto(g_peer.get_event_fn_auto(__FUNCTION__));

    if (pUIContextData)
        g_peer.free_memory((BYTE*)pUIContextData);
}


///
/// Releases error-specific memory allocated by the EAP peer method.
///
/// \sa [EapPeerFreeErrorMemory function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363605.aspx)
///
VOID WINAPI EapPeerFreeErrorMemory(_In_ EAP_ERROR *ppEapError)
{
    event_fn_auto event_auto(g_peer.get_event_fn_auto(__FUNCTION__));

    if (ppEapError)
        g_peer.free_error_memory(ppEapError);
}


///
/// Converts XML into the configuration BLOB.
///
/// \sa [EapPeerConfigXml2Blob function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363602.aspx)
///
DWORD WINAPI EapPeerConfigXml2Blob(
    _In_  DWORD            dwFlags,
    _In_  EAP_METHOD_TYPE  eapMethodType,
    _In_  IXMLDOMDocument2 *pConfigDoc,
    _Out_ BYTE             **pConnectionDataOut,
    _Out_ DWORD            *pdwConnectionDataOutSize,
    _Out_ EAP_ERROR        **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
    event_fn_auto_ret<DWORD> event_auto(g_peer.get_event_fn_auto(__FUNCTION__, dwResult));
#ifdef _DEBUG
    //Sleep(10000);
#endif

    // Parameter check
    if (!ppEapError)
        return dwResult = ERROR_INVALID_PARAMETER;

    assert(!*ppEapError);

    if (eapMethodType.eapType.type != EAPMETHOD_TYPE)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)eapMethodType.eapType.type, (int)EAPMETHOD_TYPE).c_str()));
    else if (eapMethodType.dwAuthorId != 67532)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)eapMethodType.dwAuthorId, (int)67532).c_str()));
    else if (!pConfigDoc)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pConfigDoc is NULL.")));
    else if (!pConnectionDataOut)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pConnectionDataOut is NULL.")));
    else if (!pdwConnectionDataOutSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pdwConnectionDataOutSize is NULL.")));
    else {
        // Configure XML selection namespaces used.
        pConfigDoc->setProperty(bstr(L"SelectionNamespaces"), variant(L"xmlns:eap-metadata=\"urn:ietf:params:xml:ns:yang:ietf-eap-metadata\" xmlns:eaphostconfig=\"http://www.microsoft.com/provisioning/EapHostConfig\""));

        // <Config>
        com_obj<IXMLDOMElement> pXmlElConfig;
        if (FAILED(eapxml::select_element(pConfigDoc, bstr(L"//eaphostconfig:Config"), pXmlElConfig))) {
            g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" Error reading <Config> element.")));
            return dwResult;
        }

        // Load configuration.
        try {
            g_peer.config_xml2blob(dwFlags, pXmlElConfig, pConnectionDataOut, pdwConnectionDataOutSize);
        } catch (std::exception &err) {
            g_peer.log_error(*ppEapError = g_peer.make_error(err));
            dwResult = (*ppEapError)->dwWinError;
        } catch (...) {
            dwResult = ERROR_INVALID_DATA;
        }
    }

    return dwResult;
}


///
/// Converts the configuration BLOB to XML.
///
/// The configuration BLOB is returned in the ppConnectionDataOut parameter of the EapPeerInvokeConfigUI function.
///
/// \sa [EapPeerConfigBlob2Xml function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363601.aspx)
///
DWORD WINAPI EapPeerConfigBlob2Xml(
    _In_                                   DWORD            dwFlags,
    _In_                                   EAP_METHOD_TYPE  eapMethodType,
    _In_count_(dwConnectionDataSize) const BYTE             *pConnectionData,
    _In_                                   DWORD            dwConnectionDataSize,
    _Out_                                  IXMLDOMDocument2 **ppConfigDoc,
    _Out_                                  EAP_ERROR        **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
    event_fn_auto_ret<DWORD> event_auto(g_peer.get_event_fn_auto(__FUNCTION__, dwResult));
#ifdef _DEBUG
    //Sleep(10000);
#endif

    // Parameter check
    if (!ppEapError)
        return dwResult = ERROR_INVALID_PARAMETER;

    assert(!*ppEapError);

    if (eapMethodType.eapType.type != EAPMETHOD_TYPE)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)eapMethodType.eapType.type, (int)EAPMETHOD_TYPE).c_str()));
    else if (eapMethodType.dwAuthorId != 67532)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)eapMethodType.dwAuthorId, (int)67532).c_str()));
    else if (!pConnectionData && dwConnectionDataSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pConnectionData is NULL.")));
    else if (!ppConfigDoc)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" ppConfigDoc is NULL.")));
    else {
        HRESULT hr;

        // Create configuration XML document.
        com_obj<IXMLDOMDocument2> pConfigDoc;
        if (FAILED(hr = pConfigDoc.create(CLSID_DOMDocument60, NULL, CLSCTX_INPROC_SERVER))) {
            g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = HRESULT_CODE(hr), _T(__FUNCTION__) _T(" Error creating XML document.")));
            return dwResult;
        }

        pConfigDoc->put_async(VARIANT_FALSE);

        // Load empty XML configuration.
        VARIANT_BOOL isSuccess = VARIANT_FALSE;
        if (FAILED((hr = pConfigDoc->loadXML(L"<Config xmlns=\"http://www.microsoft.com/provisioning/EapHostConfig\"></Config>", &isSuccess)))) {
            g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = HRESULT_CODE(hr), _T(__FUNCTION__) _T(" Error loading XML document template.")));
            return dwResult;
        }
        if (!isSuccess) {
            g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_XML_PARSE_ERROR, _T(__FUNCTION__) _T(" Loading XML template failed.")));
            return dwResult;
        }

        // Configure XML selection namespaces used.
        pConfigDoc->setProperty(bstr(L"SelectionNamespaces"), variant(L"xmlns:eap-metadata=\"urn:ietf:params:xml:ns:yang:ietf-eap-metadata\" xmlns:eaphostconfig=\"http://www.microsoft.com/provisioning/EapHostConfig\""));

        // Select <Config> node.
        com_obj<IXMLDOMNode> pXmlElConfig;
        if (FAILED(eapxml::select_node(pConfigDoc, bstr(L"eaphostconfig:Config"), pXmlElConfig))) {
            g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_FOUND, _T(__FUNCTION__) _T(" Error selecting <Config> element.")));
            return dwResult;
        }

        // Save configuration.
        pConfigDoc->setProperty(bstr(L"SelectionNamespaces"), variant(L"xmlns:eap-metadata=\"urn:ietf:params:xml:ns:yang:ietf-eap-metadata\""));
        try {
            g_peer.config_blob2xml(dwFlags, pConnectionData, dwConnectionDataSize, pConfigDoc, pXmlElConfig);
        } catch (std::exception &err) {
            g_peer.log_error(*ppEapError = g_peer.make_error(err));
            return dwResult = (*ppEapError)->dwWinError;
        } catch (...) {
            return dwResult = ERROR_INVALID_DATA;
        }

        *ppConfigDoc = pConfigDoc.detach();
    }

    return dwResult;
}


///
/// Raises the EAP method's specific connection configuration user interface dialog on the client.
///
/// \sa [EapPeerInvokeConfigUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363614.aspx)
///
DWORD WINAPI EapPeerInvokeConfigUI(
    _In_                               const EAP_METHOD_TYPE *pEapType,
    _In_                                     HWND            hwndParent,
    _In_                                     DWORD           dwFlags,
    _In_                                     DWORD           dwConnectionDataInSize,
    _In_count_(dwConnectionDataInSize) const BYTE            *pConnectionDataIn,
    _Out_                                    DWORD           *pdwConnectionDataOutSize,
    _Out_                                    BYTE            **ppConnectionDataOut,
    _Out_                                    EAP_ERROR       **ppEapError)
{
    UNREFERENCED_PARAMETER(dwFlags);
    DWORD dwResult = ERROR_SUCCESS;
    event_fn_auto_ret<DWORD> event_auto(g_peer.get_event_fn_auto(__FUNCTION__, dwResult));
    actctx_activator actctx(g_act_ctx);
#ifdef _DEBUG
    //Sleep(10000);
#endif

    // Parameter check
    if (!ppEapError)
        return dwResult = ERROR_INVALID_PARAMETER;

    assert(!*ppEapError);

    if (!pEapType)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pEapType is NULL.")));
    else if (pEapType->eapType.type != EAPMETHOD_TYPE)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)pEapType->eapType.type, (int)EAPMETHOD_TYPE).c_str()));
    else if (pEapType->dwAuthorId != 67532)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)pEapType->dwAuthorId, (int)67532).c_str()));
    else if (!pConnectionDataIn && dwConnectionDataInSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pConnectionDataIn is NULL.")));
    else if (!pdwConnectionDataOutSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pdwConnectionDataOutSize is NULL.")));
    else if (!ppConnectionDataOut)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" ppConnectionDataOut is NULL.")));
    else {
        try {
            g_peer.invoke_config_ui(hwndParent, pConnectionDataIn, dwConnectionDataInSize, ppConnectionDataOut, pdwConnectionDataOutSize);
        } catch (std::exception &err) {
            g_peer.log_error(*ppEapError = g_peer.make_error(err));
            dwResult = (*ppEapError)->dwWinError;
        } catch (...) {
            dwResult = ERROR_INVALID_DATA;
        }
    }

    return dwResult;
}


///
/// Raises a custom interactive user interface dialog to obtain user identity information for the EAP method on the client.
///
/// \sa [EapPeerInvokeIdentityUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363615.aspx)
///
DWORD WINAPI EapPeerInvokeIdentityUI(
    _In_                             const EAP_METHOD_TYPE *pEapType,
    _In_                                   DWORD           dwFlags,
    _In_                                   HWND            hwndParent,
    _In_                                   DWORD           dwConnectionDataSize,
    _In_count_(dwConnectionDataSize) const BYTE            *pConnectionData,
    _In_                                   DWORD           dwUserDataSize,
    _In_count_(dwUserDataSize)       const BYTE            *pUserData,
    _Out_                                  DWORD           *pdwUserDataOutSize,
    _Out_                                  BYTE            **ppUserDataOut,
    _Out_                                  LPWSTR          *ppwszIdentity,
    _Out_                                  EAP_ERROR       **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
    event_fn_auto_ret<DWORD> event_auto(g_peer.get_event_fn_auto(__FUNCTION__, dwResult));
    actctx_activator actctx(g_act_ctx);
#ifdef _DEBUG
    //Sleep(10000);
#endif

    // Parameter check
    if (!ppEapError)
        dwResult = ERROR_INVALID_PARAMETER;

    assert(!*ppEapError);

    if (!pEapType)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pEapType is NULL.")));
    else if (pEapType->eapType.type != EAPMETHOD_TYPE)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)pEapType->eapType.type, (int)EAPMETHOD_TYPE).c_str()));
    else if (pEapType->dwAuthorId != 67532)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)pEapType->dwAuthorId, (int)67532).c_str()));
    else if (!pConnectionData && dwConnectionDataSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pConnectionData is NULL.")));
    else if (!pUserData && dwUserDataSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pUserData is NULL.")));
    else if (!pdwUserDataOutSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pdwUserDataOutSize is NULL.")));
    else if (!ppUserDataOut)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" ppUserDataOut is NULL.")));
    else if (!ppwszIdentity)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" ppwszIdentity is NULL.")));
    else {
        try {
            g_peer.invoke_identity_ui(hwndParent, dwFlags, pConnectionData, dwConnectionDataSize, pUserData, dwUserDataSize, ppUserDataOut, pdwUserDataOutSize, ppwszIdentity);
        } catch (std::exception &err) {
            g_peer.log_error(*ppEapError = g_peer.make_error(err));
            dwResult = (*ppEapError)->dwWinError;
        } catch (...) {
            dwResult = ERROR_INVALID_DATA;
        }
    }

    return dwResult;
}


///
/// Raises a custom interactive user interface dialog for the EAP method on the client.
///
/// \sa [EapPeerInvokeInteractiveUI function](https://msdn.microsoft.com/en-us/library/windows/desktop/aa363616.aspx)
///
DWORD WINAPI EapPeerInvokeInteractiveUI(
    _In_                            const EAP_METHOD_TYPE *pEapType,
    _In_                                  HWND            hwndParent,
    _In_                                  DWORD           dwUIContextDataSize,
    _In_count_(dwUIContextDataSize) const BYTE            *pUIContextData,
    _Out_                                 DWORD           *pdwDataFromInteractiveUISize,
    _Out_                                 BYTE            **ppDataFromInteractiveUI,
    _Out_                                 EAP_ERROR       **ppEapError)
{
    DWORD dwResult = ERROR_SUCCESS;
    event_fn_auto_ret<DWORD> event_auto(g_peer.get_event_fn_auto(__FUNCTION__, dwResult));
    actctx_activator actctx(g_act_ctx);
#ifdef _DEBUG
    //Sleep(10000);
#endif

    // Parameter check
    if (!ppEapError)
        return dwResult = ERROR_INVALID_PARAMETER;

    assert(!*ppEapError);

    if (!pEapType)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pEapType is NULL.")));
    else if (pEapType->eapType.type != EAPMETHOD_TYPE)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" Input EAP type (%d) does not match the supported EAP type (%d)."), (int)pEapType->eapType.type, (int)EAPMETHOD_TYPE).c_str()));
    else if (pEapType->dwAuthorId != 67532)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_NOT_SUPPORTED, wstring_printf(_T(__FUNCTION__) _T(" EAP author (%d) does not match the supported author (%d)."), (int)pEapType->dwAuthorId, (int)67532).c_str()));
    else if (!pUIContextData && dwUIContextDataSize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pUIContextData is NULL.")));
    else if (!pdwDataFromInteractiveUISize)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" pdwDataFromInteractiveUISize is NULL.")));
    else if (!ppDataFromInteractiveUI)
        g_peer.log_error(*ppEapError = g_peer.make_error(dwResult = ERROR_INVALID_PARAMETER, _T(__FUNCTION__) _T(" ppDataFromInteractiveUI is NULL.")));
    else {
        try {
            g_peer.invoke_interactive_ui(hwndParent, pUIContextData, dwUIContextDataSize, ppDataFromInteractiveUI, pdwDataFromInteractiveUISize);
        } catch (std::exception &err) {
            g_peer.log_error(*ppEapError = g_peer.make_error(err));
            dwResult = (*ppEapError)->dwWinError;
        } catch (...) {
            dwResult = ERROR_INVALID_DATA;
        }
    }

    return dwResult;
}
