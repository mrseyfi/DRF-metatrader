//+------------------------------------------------------------------+
//|                                                  export_json.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "http://www.mrseyfi.ir/"
#define VERSION "1.25"
#property version VERSION
//---- indicator settings
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2
#property indicator_type1   DRAW_ARROW
#property indicator_type2   DRAW_ARROW
#property indicator_color1  Red
#property indicator_color2  Blue
#property indicator_label1  "Fractal Up"
#property indicator_label2  "Fractal Down"
//---- indicator buffers
double ExtUpperBuffer[];
double ExtLowerBuffer[];
//--- 10 pixels upper from high price
int    ExtArrowShift=-10;

double dataset_price_upper[];
datetime dataset_date_upper[];
int dataset_count_upper =3;

double dataset_price_lower[];
datetime dataset_date_lower[];
int dataset_count_lower =3;

//MqlDateTime date;
string datajson ="\"ok\":true,";
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void OnInit()
  {
//---- indicator buffers mapping
   SetIndexBuffer(0,ExtUpperBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,ExtLowerBuffer,INDICATOR_DATA);
   SetIndexBuffer(2,dataset_price_lower,INDICATOR_DATA);
   
   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);
//---- sets first bar from what index will be drawn
   PlotIndexSetInteger(0,PLOT_ARROW,217);
   PlotIndexSetInteger(1,PLOT_ARROW,218);
//---- arrow shifts when drawing
   PlotIndexSetInteger(0,PLOT_ARROW_SHIFT,ExtArrowShift);
   PlotIndexSetInteger(1,PLOT_ARROW_SHIFT,-ExtArrowShift);
//---- sets drawing line empty value--
   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,EMPTY_VALUE);
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,EMPTY_VALUE);
//---- initialization done
  }
//+------------------------------------------------------------------+
//|  Accelerator/Decelerator Oscillator                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
    string Filename="symbol_data.json"; //Symbol();//
    if(Period()==PERIOD_H1) return 0;

    string cur_period;
    if (_Period==PERIOD_H1)cur_period="H1";
    else if (_Period==PERIOD_D1)cur_period="D1";
    else if (_Period==PERIOD_W1)cur_period="W1";
    else if (_Period==PERIOD_MN1)cur_period="MN1";
    else cur_period=_Period;


    //Filename = "symbol_data.json";  //Symbol()+"log.txt";
    int handle = FileOpen(Filename, FILE_READ|FILE_WRITE|FILE_TXT);
        
    int i,limit;


    //---
    if(rates_total<5)
        return(0);
    //---
    if(prev_calculated<7)
        {
        limit=2;
        //--- clean up arrays
        ArrayInitialize(ExtUpperBuffer,EMPTY_VALUE);
        ArrayInitialize(ExtLowerBuffer,EMPTY_VALUE);      
        
        }
    else limit=rates_total-5;
    int size1 =0;
    int size2 =0;
    for(i=limit;i<rates_total-3 && !IsStopped();i++)
        {
        
        //---- Upper Fractal
        if(high[i]>high[i+1] && high[i]>high[i+2] && high[i]>=high[i-1] && high[i]>=high[i-2])
        {
            ExtUpperBuffer[i]=high[i];
            size1++;
            ArrayResize(dataset_price_upper,size1);
            ArrayResize(dataset_date_upper,size1);
            dataset_price_upper[size1-1]=high[i];
            dataset_date_upper[size1-1] =time[i];
        }
        else ExtUpperBuffer[i]=EMPTY_VALUE;

        //---- Lower Fractal
        if(low[i]<low[i+1] && low[i]<low[i+2] && low[i]<=low[i-1] && low[i]<=low[i-2])
        {
            ExtLowerBuffer[i]=low[i];
            size2++;
            ArrayResize(dataset_price_lower,size2);
            ArrayResize(dataset_date_lower,size2);
            dataset_price_lower[size2-1]=low[i];
            dataset_date_lower[size2-1] =time[i];            
        }
        else ExtLowerBuffer[i]=EMPTY_VALUE;
        }
    string time_request ;
    //datajson +="\"Fractal_upper\":[";
    if(ArraySize(dataset_price_upper) > dataset_count_upper)
        {
            for(int i=ArraySize(dataset_price_upper)-1; i>=ArraySize(dataset_price_upper)-dataset_count_upper ; i--){     
            // some manipulations on the Variable[i] element
            time_request = TimeToString (dataset_date_upper[i]);
            StringReplace(time_request ,".","-");
            if(i!=ArraySize(dataset_price_upper)-1) datajson += ",";
            datajson += "\n{\"time_frame\":\""+cur_period+"\",\"title\": \"Fractal_upper\",\"symbol_name\": \""+_Symbol+"\", \"type\":\""+"upper" +"\",\"time_request\":\""+time_request +"\",\"price\":"+dataset_price_upper[i] +"}";
            }
        }
    datajson += ",";

    if(ArraySize(dataset_price_lower) > dataset_count_lower)
        {
            for(int i=ArraySize(dataset_price_lower)-1; i>=ArraySize(dataset_price_lower)-dataset_count_lower ; i--){
            // some manipulations on the Variable[i] element
            if(i!=ArraySize(dataset_price_lower)-1) datajson += ",";
            time_request = TimeToString (dataset_date_lower[i]);
            StringReplace(time_request ,".","-");
            datajson += "\n{\"time_frame\":\""+cur_period+"\",\"title\": \"Fractal_upper\",\"symbol_name\": \""+_Symbol+"\", \"type\":\""+"lower" +"\",\"time_request\":\""+ time_request +"\",\"price\":"+dataset_price_lower[i] +"}";
            //"{\n    \"title\": \"signal\",\n    \"symbol_name\": \"فملی\",\n    \"time_frame\": \"D1\",\n    \"price\": 2500,\n    \"amount\": 0.2,\n    \"type\": \"type-fractal_upper\",\n    \"time_request\": \"2020-12-28T16:36:38+03:30\"\n}";
            }
        }

    if(handle > 0) 
    {
        ArrayFree(dataset_price_upper);
        ArrayFree(dataset_date_upper);
        ArrayFree(dataset_price_lower);
        ArrayFree(dataset_date_lower);

        FileSeek(handle, 0, SEEK_END); 
        if(StringReplace(datajson,"\"ok\":true,",",") == 1)
            FileWrite(handle, datajson);
                
        FileClose(handle);
        datajson = "";
        if(Period() == PERIOD_D1)
            ChartSetSymbolPeriod(0, _Symbol,  PERIOD_W1);
        else if(Period() == PERIOD_W1)
            ChartSetSymbolPeriod(0, _Symbol,  PERIOD_MN1);
        else if(Period() == PERIOD_MN1)
            ChartSetSymbolPeriod(0, _Symbol,  PERIOD_H1);         
    }

    return(rates_total);

}
