#include "stdafx.h"

typedef VOID (*DLLPROC) ();
HINSTANCE hinstDLL;
DLLPROC ShowForm;
BOOL fFreeDLL;

int main(void){
	hinstDLL = LoadLibrary("LabDLL.dll");
	if (hinstDLL != NULL)
	{
		ShowForm = (DLLPROC) GetProcAddress(hinstDLL, "ShowForm");
		//if (ShowForm != NULL)
			(*ShowForm)();

		fFreeDLL = FreeLibrary(hinstDLL);
	}
	return 0;
}