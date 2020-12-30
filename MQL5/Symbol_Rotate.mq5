//+------------------------------------------------------------------+
//|                                                    testtest2.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mrseyfi.ir"
#define VERSION "1.25"
#property version VERSION
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
//     /home/idea/.wine/drive_c/Program Files/MofidTrader/MQL5/Files/

int OnInit()
  {
//---
     GlobalVariableSet("rotate_stop", 0);
     long rotate_time = GlobalVariableGet("rotate_time");
     if (rotate_time == 0) GlobalVariableSet("rotate_time", 20);
     EventSetTimer(rotate_time);

    return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   
  }
//+------------------------------------------------------------------+


void OnTimer()
{         
    if (GlobalVariableGet("rotate_stop") == 1) 
    {
        Comment("Rotate is STOP.");
        return;
    }

    // Find next symbol
    long symbolsTotal = SymbolsTotal(true);
    long count = GlobalVariableGet("tsemem");
    
    if(count >= symbolsTotal)
    {
        count = 0;         
    }   
            
    string newSymbol = SymbolName(count, true);
    Comment(StringFormat("Show %s",newSymbol));
    SymbolSelect(newSymbol, true);
    count++;
    GlobalVariableSet("tsemem", count);
    
    // Open file
    string Filename = "symbol_data.json";//newSymbol; //Symbol();
    int handle = 0;
    datetime datelocal =TimeLocal();
    handle = FileOpen(Filename, FILE_READ|FILE_WRITE|FILE_TXT);

    string str = "";
    while(!FileIsEnding(handle)) 
    { 
        //--- read the string 
        str+= FileReadString(handle,-1); 
    } 
    int pos =StringFind( str,",",0);
        str ="[" +  StringSubstr(str,pos+1) + "]";
    //--- close the file 
    FileClose(handle); 

    if (str !="")
    {   //+------------------------------------------------------------------+
        //  ADD To Database
        string cookie = NULL, result_headers;
        string headers = "Authorization: Token ad9847dadd1b14******65f043c4357c39a9c11\r\nContent-Type: application/json;";
        char   data[];
        string body=str; 
        ArrayResize(data,StringToCharArray(body,data,0,WHOLE_ARRAY,CP_UTF8)-1);
        //Print(CharArrayToString( EncodeURL(body ));
        char result_data[];
        string url = "http://example.ir/api/indicator/";
        ResetLastError();
        //Print("cheak:" +str);
        //Alert(str);
        int res = WebRequest("POST", url, headers, 500, data, result_data, result_headers);        
        //int res = 0;
        Print(newSymbol + " load.", "  handle is:"+ handle," Date:",datelocal,"   ver:",VERSION,"  res",res);

        //+------------------------------------------------------------------+

        // Clear file
        handle = FileOpen(Filename, FILE_WRITE|FILE_TXT); 
        if (handle>0){
        FileWrite(handle, "");
        FileClose(handle);
        }
    }

    ChartSetSymbolPeriod(0, newSymbol,  PERIOD_D1);// Period());

  
    string  symbols[];
    ArrayResize(symbols,SymbolsTotal(true));
    for(int i = 0; i < SymbolsTotal(true); i++)
    {
        string symbol = SymbolName(i, true); // Get name from local market watch
        symbols[i]=symbol;
    }           
       

}